package exam;

import java.util.Scanner;

public class Main {
	public static void main(String[] args) {

		Scanner sc = new Scanner(System.in);

		int num = sc.nextInt();

		int[][] arr = new int[1000][1000];

		for (int i = 0; i < num; i++) {

			double total = 0;
			int stu = 0;
			int cnt = 0;
			stu = sc.nextInt();
			for (int j = 0; j < stu; j++) {

				arr[i][j] = sc.nextInt();

				total += arr[i][j];
			}
			total = total / (double) stu;
			for (int k = 0; k < stu; k++) {
				if (total < arr[i][k])
					cnt++;
			}
			total = (double) cnt / (double) stu * 100;

			System.out.println(String.format("%.3f", total) + "%");

		}

	}
}
