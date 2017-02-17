From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial 4/4] PM / Documentation: Spelling s/wrtie/write/
Date: Fri, 17 Feb 2017 16:36:39 +0100
Message-ID: <1487345799-1638-4-git-send-email-geert+renesas@glider.be>
References: <1487345799-1638-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487345799-1638-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
---
 Documentation/power/states.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/states.txt b/Documentation/power/states.txt
index 008ecb588317bc1d..bc4548245a243134 100644
--- a/Documentation/power/states.txt
+++ b/Documentation/power/states.txt
@@ -25,7 +25,7 @@ to be used subsequently to change to the one represented by that string.
 Consequently, there are two ways to cause the system to go into the
 Suspend-To-Idle sleep state.  The first one is to write "freeze" directly to
 /sys/power/state.  The second one is to write "s2idle" to /sys/power/mem_sleep
-and then to wrtie "mem" to /sys/power/state.  Similarly, there are two ways
+and then to write "mem" to /sys/power/state.  Similarly, there are two ways
 to cause the system to go into the Power-On Suspend sleep state (the strings to
 write to the control files in that case are "standby" or "shallow" and "mem",
 respectively) if that state is supported by the platform.  In turn, there is
-- 
1.9.1
