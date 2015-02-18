From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 3/8] tools/thermal: tmon: tui: don't hard-code dialog window size assumptions
Date: Tue, 17 Feb 2015 18:18:31 -0800
Message-ID: <1424225916-13488-4-git-send-email-computersforpeace@gmail.com>
References: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, jacob.jun.pan@linux.intel.com
Cc: Neil Horman <nhorman@tuxdriver.com>, Brian Norris <computersforpeace@gmail.com>, Javi Merino <javi.merino@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

We can use the ncurses API to get the number of rows.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 tools/thermal/tmon/tui.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 43c5aecf71da..2779573a53cb 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -274,11 +274,14 @@ const char DIAG_TITLE[] = "[ TUNABLES ]";
 void show_dialogue(void)
 {
 	int j, x = 0, y = 0;
+	int rows, cols;
 	WINDOW *w = dialogue_window;
 
 	if (tui_disabled || !w)
 		return;
 
+	getmaxyx(w, rows, cols);
+
 	werase(w);
 	box(w, 0, 0);
 	mvwprintw(w, 0, maxx/4, DIAG_TITLE);
@@ -297,10 +300,8 @@ void show_dialogue(void)
 	wattron(w, A_BOLD);
 	mvwprintw(w, DIAG_DEV_ROWS+1, 1, "Enter Choice [A-Z]?");
 	wattroff(w, A_BOLD);
-	/* y size of dialogue win is nr cdev + 5, so print legend
-	 * at the bottom line
-	 */
-	mvwprintw(w, ptdata.nr_cooling_dev+3, 1,
+	/* print legend at the bottom line */
+	mvwprintw(w, rows - 2, 1,
 		"Legend: A=Active, P=Passive, C=Critical");
 
 	wrefresh(dialogue_window);
-- 
1.9.1
