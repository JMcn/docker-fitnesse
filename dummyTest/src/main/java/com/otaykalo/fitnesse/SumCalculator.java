package com.otaykalo.fitnesse;

/**
 * Created by otaykalo on 7/8/2016.
 */
public class SumCalculator {

    private int first, second;

    public void setFirst(int first) {
        this.first = first;
    }

    public void setSecond(int second) {
        this.second = second;
    }

    public int sum() {
        return first + second;
    }

    public SumCalculator() {
    }
}