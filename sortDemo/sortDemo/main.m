//
//  main.m
//  sortDemo
//
//  Created by lly on 2016/11/8.
//  Copyright © 2016年 lly. All rights reserved.
//

#import <Foundation/Foundation.h>

void Insertion_Sort(int *a);
void Bubble_Sort(int *a);
void Selection_Sort(int *a);
void Merge_Sort(int *a);
void Quick_Sort(int *a);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World! \n");
        
        int a[10] = {5,3,7,6,2,1,8,4,9,0};

        for (int i = 0; i < 10; ++i) {
            printf("%d ",a[i]);
        }
        printf("\n");
        
        //插入排序
        Insertion_Sort(a);
        
        //冒泡排序
//        Bubble_Sort(a);
        
        //选择排序
//        Selection_Sort(a);
        
        //归并排序
//        Merge_Sort(a);
        
        //快速排序
//        Quick_Sort(a);
        
        for (int i = 0; i < 10; ++i) {
            printf("%d ",a[i]);
        }
        printf("\n");
        
        
        
    }
    return 0;
}


//初始：i=2，A[1...1]已排序，成立。
//保持：在迭代开始前，A[1...i-1]已排序，而循环体的目的是将A[i]插入A[1...i-1]中，使得A[1...i]排序，因此在下一轮迭代开始前，i++，因此现在A[1...i-1]排好序了，因此保持循环不变式。
//终止：最后i=n+1，并且A[1...n]已排序，而A[1...n]就是整个数组，因此证毕。
void Insertion_Sort(int *a){
    
    for (int i = 1; i < 10; ++i) {
        int j = 0;
        while (j < i) {
            if (a[i] < a[j]) {
                int tmp = a[i];
                a[i] = a[j];
                a[j] = tmp;
            }
            j++;
        }
    }

}

//初始：i=1，因此A[1..0]=空，因此成立。
//保持：当循环开始时，已知A[1...i-1]是A中最小的i-1个元素，且A[1]<=A[2]<=...<=A[i-1]，根据内循环不变式，终止时A[i]是A[i...n]中最小的元素，因此A[1...i]包含了A中最小的i个元素，且A[1]<=A[2]<=...<=A[i-1]<=A[i]
//终止：i=n+1，已知A[1...n]是A中最小的n个元素，且A[1]<=A[2]<=...<=A[n]，得证。
void Bubble_Sort(int *a){

    for (int i = 0; i < 10; ++i) {
        for (int j = i+1; j < 10; ++j) {
            if (a[i] > a[j]) {
                int tmp = a[i];
                a[i] = a[j];
                a[j] = tmp;
            }
        }
    }
}

//初始：i=1，A[1...0]=空，因此成立。
//保持：在某次迭代开始之前，保持循环不变式，即A[1...i-1]包含了A中最小的i-1个元素，且已排序，则进入循环体后，程序从         A[i...n]中找出最小值放在A[i]处，因此A[1...i]包含了A中最小的i个元素，且已排序，而i++，因此下一次循环之前，保持       循环不变式：A[1..i-1]包含了A中最小的i-1个元素，且已排序。
//终止：i=n，已知A[1...n-1]包含了A中最小的i-1个元素，且已排序，因此A[n]中的元素是最大的，因此A[1...n]已排序，证毕。
void Selection_Sort(int *a){

    for (int i = 0; i < 10; ++i) {
        int index = i;
        for (int j = i+1; j < 10; ++j) {
            if (a[index] > a[j]) {
                index = j;
            }
        }
        int tmp = a[i];
        a[i] = a[index];
        a[index] = tmp;
    }
}

//初始：k=p，A[p...p-1]为空，因此已排序，成立。
//保持：在第k次迭代之前，A[p...k-1]已经排序，而因为L[i]和R[j]是L和R中剩下的元素中最小的两个元素，因此只需要将L[i]和R[j]中最小的元素放到A[k]即可，在第k+1次迭代之前A[p...k]已排序，且L[i]和R[j]为剩下的最小的两个元素。
//终止：k=q+1，且A[p...q]已排序，这就是我们想要的，因此证毕。
void merge(int *a,int p,int m,int q){
    
    printf("%d,%d,%d\n",p,m,q);
    int i = p,j = m + 1;
    int mid = m,n = q;
    int k = 0;
    
    int tmp[q];
    
    while (i <= mid && j <= n) {
        if (a[i] <= a[j]) {
            tmp[k++] = a[i++];
        }
        else{
            tmp[k++] = a[j++];
        }
    }
    
    while (i <= m)
        tmp[k++] = a[i++];
    
    while (j <= n)
        tmp[k++] = a[j++];
    
    for (i = 0; i < k; i++)
        a[p + i] = tmp[i];
}


void Recursive_MergeSort(int *a,int p,int q){
    if (p < q) {
        int m = (p + q)/2;
        printf("%d,%d,%d\n",p,m,q);
        Recursive_MergeSort(a, p, m);
        Recursive_MergeSort(a, m+1, q);
        merge(a,p,m,q);
    }
}

void Merge_Sort(int *a){
    
    Recursive_MergeSort(a, 0, 9);
}



//quick sort
void swap(int * a,int m,int n){
    int tmp = a[m];
    a[m] = a[n];
    a[n] = tmp;
}

int partition(int *a,int low,int high){

    int pivot = a[low];
    while (low < high) {
        
        while (low < high && a[high] > pivot) {
            high--;
        }
        swap(a, low, high);
        
        while (low < high && a[low] <= pivot) {
            low++;
        }
        swap(a, high, low);
       
        
        for (int i = 0; i < 10; ++i) {
            printf("%d ",a[i]);
        }
        printf("\n");
    }
//    a[low] = pivot;
    return low;
}


void Recurive_QuickSort(int *a,int low,int high){

    int loc = 0;
    if (low < high) {
        loc = partition(a,low,high);
        Recurive_QuickSort(a, low, loc-1);
        Recurive_QuickSort(a, loc+1, high);
    }
}

void Quick_Sort(int *a){

    Recurive_QuickSort(a,0,9);
}





