From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 4/8] tools/thermal: tmon: fixup tui windowing calculations
Date: Tue, 17 Feb 2015 18:18:32 -0800
Message-ID: <1424225916-13488-5-git-send-email-computersforpeace@gmail.com>
References: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, jacob.jun.pan@linux.intel.com
Cc: Neil Horman <nhorman@tuxdriver.com>, Brian Norris <computersforpeace@gmail.com>, Javi Merino <javi.merino@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The number of rows in the dialog vary according to the number of cooling
devices. However, some of the windowing computations were assuming a
fixed number of rows. This computation is OK when we have between 4 and
9 cooling devices (and they wrap to the next column), but with fewer
devices, we end up printing off the end of the window.

This unifies the row computation into a single function and uses that
throughout the TUI code. This also accounts for increasing the number of
rows when there are more than 9 total cooling devices.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 tools/thermal/tmon/tui.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 2779573a53cb..36e1f86c8452 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -110,6 +110,18 @@ void write_status_bar(int x, char *line)
 	wrefresh(status_bar_window);
 }
 
+/* wrap at 5 */
+#define DIAG_DEV_ROWS  5
+/*
+ * list cooling devices + "set temp" entry; wraps after 5 rows, if they fit
+ */
+static int diag_dev_rows(void)
+{
+	int entries = ptdata.nr_cooling_dev + 1;
+	int rows = max(DIAG_DEV_ROWS, (entries + 1) / 2);
+	return min(rows, entries);
+}
+
 void setup_windows(void)
 {
 	int y_begin = 1;
@@ -134,7 +146,7 @@ void setup_windows(void)
 	 * dialogue window is a pop-up, when needed it lays on top of cdev win
 	 */
 
-	dialogue_window = subwin(stdscr, ptdata.nr_cooling_dev+5, maxx-50,
+	dialogue_window = subwin(stdscr, diag_dev_rows() + 5, maxx-50,
 				DIAG_Y, DIAG_X);
 
 	thermal_data_window = subwin(stdscr, ptdata.nr_tz_sensor *
@@ -270,7 +282,6 @@ void show_cooling_device(void)
 }
 
 const char DIAG_TITLE[] = "[ TUNABLES ]";
-#define DIAG_DEV_ROWS  5
 void show_dialogue(void)
 {
 	int j, x = 0, y = 0;
@@ -287,7 +298,7 @@ void show_dialogue(void)
 	mvwprintw(w, 0, maxx/4, DIAG_TITLE);
 	/* list all the available tunables */
 	for (j = 0; j <= ptdata.nr_cooling_dev; j++) {
-		y = j % DIAG_DEV_ROWS;
+		y = j % diag_dev_rows();
 		if (y == 0 && j != 0)
 			x += 20;
 		if (j == ptdata.nr_cooling_dev)
@@ -298,7 +309,7 @@ void show_dialogue(void)
 				ptdata.cdi[j].type, ptdata.cdi[j].instance);
 	}
 	wattron(w, A_BOLD);
-	mvwprintw(w, DIAG_DEV_ROWS+1, 1, "Enter Choice [A-Z]?");
+	mvwprintw(w, diag_dev_rows()+1, 1, "Enter Choice [A-Z]?");
 	wattroff(w, A_BOLD);
 	/* print legend at the bottom line */
 	mvwprintw(w, rows - 2, 1,
@@ -450,7 +461,7 @@ static void handle_input_choice(int ch)
 			snprintf(buf, sizeof(buf), "New Value for %.10s-%2d: ",
 				ptdata.cdi[cdev_id].type,
 				ptdata.cdi[cdev_id].instance);
-		write_dialogue_win(buf, DIAG_DEV_ROWS+2, 2);
+		write_dialogue_win(buf, diag_dev_rows() + 2, 2);
 		handle_input_val(cdev_id);
 	} else {
 		snprintf(buf, sizeof(buf), "Invalid selection %d", ch);
-- 
1.9.1
