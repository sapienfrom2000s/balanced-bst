require 'pry-byebug'

class Node
    attr_accessor :data, :left, :right
end

class Tree
    attr_accessor :array
    def initialize(arr)
        @array = arr.sort.uniq
    end

    def build_tree(arr)
        root = Node.new
        root.data = arr[arr.length/2] 

        return if arr.length == 0
        return root if arr.length == 1
        # binding.pry
        root.left = build_tree(arr.slice!(0,arr.length/2))
        root.right = build_tree(arr[1,arr.length])
        root
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def insert(root, value)

        if root == nil
            new_root = Node.new
            new_root.data = value
            return new_root
        end

        if(value > root.data)
            if root.right == nil
              root.right = insert(root.right, value) 
            else
              insert(root.right, value)
            end
       else
            if root.left == nil
                root.left = insert(root.left, value)
            else
                insert(root.left, value)
            end
       end
    end

    def delete(root, value)
        return nil if root == nil
        if(root.data == value && (root.left==nil && root.right == nil))
            return nil
        end

        if((root.data == value) && (root.left || root.right) && !(root.left && root.right))
            return root.left||root.right
        end

        if((root.data == value) &&(root.left && root.right))
            temp = replace(root.right)
            delete(root, temp)
            root.data = temp
        end

        if value > root.data
            root.right = delete(root.right, value)
        else
            root.left = delete(root.left, value)
        end
        root
    end

    def replace(root)
        return root.data if root.left == nil
        replace(root.left)
    end

    def find(root, value)
        return if root == nil
        return root if root.data == value
        if value > root.data
            find(root.right, value)
        else
            find(root.left, value)
        end
    end

    def level_order_arrayversion(root, arr = []) 
        arr.push(root)
        for node in arr do
            arr.push(node.left) unless node.left == nil
            arr.push(node.right) unless node.right == nil
            print(node.data, " ")
        end 
    end

    def preorder(root, arr = [])
        print(root.data,' ')
        arr.push(root)
        preorder(root.left, arr) unless root.left == nil
        preorder(root.right,arr) unless root.right == nil
    end
    
    def inorder(root, arr = [])
        inorder(root.left, arr) unless root.left == nil
        arr.push(root.data)
        # print(root.data,' ')
        inorder(root.right,arr) unless root.right == nil
        arr
    end       

    def postorder(root, arr = [])

        postorder(root.left, arr) unless root.left == nil
        postorder(root.right, arr) unless root.right == nil
        arr.push(root.data)
        print(root.data,' ')
    end 

    def height(root)
        return 0 if root == nil
        depth_leftnode = 1 + height(root.left)
        depth_rightnode = 1 + height(root.right)

        [depth_leftnode, depth_rightnode].max
    end

    def depth(root,node)
        # binding.pry
        return 0 if ((root == nil) || (root == node))
        if(node.data > root.data)
            height = 1 + depth(root.right, node)
        else
            height = 1 + depth(root.left, node)
        end
    end

    def balanced?(root)
        (height(root.left) - height(root.right)).abs <= 1 ? true : false
    end
    def rebalance(root)
        arr = inorder(root)
        root = build_tree(arr)
        pretty_print(root)
        root
    end

end

# obj = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9,99, 67, 6345, 324])
# k = obj.build_tree(obj.array)

# obj.pretty_print(k)

# obj.insert(k, 68)
# # obj.pretty_print(k)
# obj.insert(k, 89)
# obj.insert(k,90)
# obj.insert(k,91)
# obj.delete(k,1)
# # obj.delete(k,68)
# # obj.delete(k,99)
# obj.delete(k,5)
# # obj.delete(k,9)
# # obj.delete(k,7)
# obj.pretty_print(k)
# # puts obj.find(k,68)
# # obj.level_order_arrayversion(k)   
# # obj.preorder(k)
# # puts
# # obj.inorder(k)
# # puts
# # obj.postorder(k)
# # puts
# # puts obj.height(k)
# # puts obj.depth(k,obj.find(k,91))
# # obj.find(k,68)
# # puts obj.balanced?(k)
# obj.rebalance(k)

obj = Tree.new((Array.new(15) { rand(1..100) }))
k = obj.build_tree(obj.array)

obj.pretty_print(k)
puts obj.balanced?(k)
# obj.level_order_arrayversion(k)
# obj.inorder(k)
# obj.preorder(k)
# obj.postorder(k)
obj.insert(k,102)
obj.insert(k,105)
obj.insert(k,106)
obj.insert(k,108)
obj.insert(k,109)
obj.insert(k,1011)
obj.pretty_print(k)
puts obj.balanced?(k)
k = obj.rebalance(k)
puts obj.balanced?(k)