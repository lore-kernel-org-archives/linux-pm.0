From: Mandeep Singh Baines <msb@chromium.org>
Subject: [PATCH 3/6] PM: use appropriate printk priority level
Date: Wed, 26 Jan 2011 15:29:27 -0800
Message-ID: <1296084570-31453-4-git-send-email-msb__8238.77287698469$1296144568$gmane$org@chromium.org>
References: <20110125235700.GR8008@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110125235700.GR8008@google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: gregkh@suse.de, rjw@sisk.pl, mingo@redhat.com, akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Mandeep Singh Baines <msb@chromium.org>
List-Id: linux-pm@vger.kernel.org

printk()s without a priority level default to KERN_WARNING. To reduce
noise at KERN_WARNING, this patch set the priority level appriopriately
for unleveled printks()s. This should be useful to folks that look at
dmesg warnings closely.

Changed these messages to pr_info. But might be more appropriate as
pr_debug.

Signed-off-by: Mandeep Singh Baines <msb@chromium.org>
---
 drivers/base/power/trace.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index 9f4258d..c80e138 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -112,7 +112,7 @@ static unsigned int read_magic_time(void)
 	unsigned int val;
 
 	get_rtc_time(&time);
-	printk("Time: %2d:%02d:%02d  Date: %02d/%02d/%02d\n",
+	pr_info("Time: %2d:%02d:%02d  Date: %02d/%02d/%02d\n",
 		time.tm_hour, time.tm_min, time.tm_sec,
 		time.tm_mon + 1, time.tm_mday, time.tm_year % 100);
 	val = time.tm_year;				/* 100 years */
@@ -179,7 +179,7 @@ static int show_file_hash(unsigned int value)
 		unsigned int hash = hash_string(lineno, file, FILEHASH);
 		if (hash != value)
 			continue;
-		printk("  hash matches %s:%u\n", file, lineno);
+		pr_info("  hash matches %s:%u\n", file, lineno);
 		match++;
 	}
 	return match;
@@ -255,7 +255,7 @@ static int late_resume_init(void)
 	val = val / FILEHASH;
 	dev = val /* % DEVHASH */;
 
-	printk("  Magic number: %d:%d:%d\n", user, file, dev);
+	pr_info("  Magic number: %d:%d:%d\n", user, file, dev);
 	show_file_hash(file);
 	show_dev_hash(dev);
 	return 0;
-- 
1.7.3.1
