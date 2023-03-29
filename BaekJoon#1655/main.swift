//
//  main.swift
//  BaekJoon#1655
//
//  Created by 김병엽 on 2023/03/30.
//

import Foundation

struct Heap<T> {
    
    var nodes: Array<T> = []
    let comparer: (T, T) -> Bool
    
    init(comparer: @escaping (T, T) -> Bool) {
        self.comparer = comparer
    }
    
    var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    var count: Int {
        return nodes.count
    }
    
    var root: T? {
        return nodes.isEmpty ? nil : nodes[0]
    }
    
    mutating func insert(_ element: T) {
        
        var index = nodes.count
        
        nodes.append(element)
        
        while index > 0, comparer(nodes[index], nodes[(index - 1) / 2]) {
            nodes.swapAt(index, (index - 1) / 2)
            index = (index - 1) / 2
        }
    }
    
    mutating func shiftDown(at: Int) {
        
        var index = at
        
        while index < nodes.count {
            let left = index * 2 + 1
            let right = left + 1
            
            if right < nodes.count {
                if !comparer(nodes[left], nodes[right]), !comparer(nodes[index], nodes[right]) {
                    nodes.swapAt(index, right)
                    index = right
                } else if !comparer(nodes[index], nodes[left]) {
                    nodes.swapAt(index, left)
                    index = left
                } else {
                    break
                }
            } else if left < nodes.count {
                if !comparer(nodes[index], nodes[left]) {
                    nodes.swapAt(index, left)
                    index = left
                } else {
                    break
                }
            } else {
                break
            }
        }
    }
    
}

extension Heap where T: Comparable {
    
    init() {
        self.init(comparer: <)
    }
    
    
}

func solution() {
    
    let n = Int(readLine()!)!
    var minHeap = Heap<Int>(comparer: <)
    var maxHeap = Heap<Int>(comparer: >)
    
    var result = ""
    
    for i in 1...n {
        
        let num = Int(readLine()!)!
        
        if i % 2 == 0 {
            minHeap.insert(num)
        } else {
            maxHeap.insert(num)
        }
        
        if minHeap.isEmpty {
            result += "\(maxHeap.root!)\n"
            continue
        }
        
        let minRoot = minHeap.root!
        let maxRoot = maxHeap.root!
        
        if maxRoot > minRoot {
            minHeap.nodes[0] = maxRoot
            maxHeap.nodes[0] = minRoot
        }
        
        if i % 2 == 0 { maxHeap.shiftDown(at: 0) }
        else { minHeap.shiftDown(at: 0) }
        
        result += "\(maxHeap.root!)\n"
    }
    
    print(result)
    
}

solution()
