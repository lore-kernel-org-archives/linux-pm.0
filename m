From: Roman Pen <roman.penyaev@profitbricks.com>
Subject: [PATCH 4/4] hibernate: fix disk and module leak on successfull resume
Date: Mon,  1 Feb 2016 15:51:55 +0100
Message-ID: <1454338315-13465-5-git-send-email-roman.penyaev@profitbricks.com>
References: <1454338315-13465-1-git-send-email-roman.penyaev@profitbricks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454338315-13465-1-git-send-email-roman.penyaev@profitbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Roman Pen <roman.penyaev@profitbricks.com>, Gi-Oh Kim <gi-oh.kim@profitbricks.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Do not forget to put the disk back.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/power/hibernate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index b7342a2..1f53dc2 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -785,8 +785,11 @@ static int software_resume(void)
 	 */
 	if (isdigit(resume_file[0]) && resume_wait) {
 		int partno;
-		while (!get_gendisk(swsusp_resume_device, &partno))
+		struct gendisk *disk;
+
+		while (!(disk = get_gendisk(swsusp_resume_device, &partno)))
 			msleep(10);
+		put_gendisk(disk);
 	}
 
 	if (!swsusp_resume_device) {
-- 
2.6.2
