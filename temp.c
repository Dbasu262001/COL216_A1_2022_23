#include "stdio.h"
#include <time.h>
int main(){
    int arr[6] ={1, 4, 4, 7, 8,10};
    int st = 4;
    //Binary search
    int n=6;
    int i=0;
    int j=n-1;
    int index = -1;
    clock_t start, end;
    /* Store time before function call */
    start = clock();
    while(i<=j){
        int mid = (i+j)/2;
        if(arr[mid] == st) {
            index = mid;
            j = mid-1;
        }else if( arr[mid] < st){
            i = mid+1;
        }else{
            i = mid-1;
        }
    }
    end = clock();
    float time_t = start - end;
    if(index == -1){
        printf("No element found");
    }else{
        printf("Number %d is found at index %d",st,index);

    }
    printf("/n %f",time_t);
    return 0;

}
