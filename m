From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH]drivers:base:power:trace.c Add "UTC" Coordinated
	Universal Time to the printk.
Date: Wed,  8 Jun 2011 23:01:41 -0700
Message-ID: <1307599301-2524-1-git-send-email-justinmattock__39067.9164826453$1307599451$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: len.brown@intel.com
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: "Justin P. Mattock" <justinmattock@gmail.com>

sounds stupid, but taking a glance at the time, and seeing the wrong time, or what seemed 
wrong in dmesg, caused me to go into total check the time clock panic mode.. So the patch below adds:
"UTC" Coordinated Universal Time abreviation to the printk so people like me dont flip out over the time!

before:
[    0.114915] Time:  1:47:03  Date: 06/09/11

after:
[    0.114728] Time:  5:46:02 UTC Date: 06/09/11

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/base/power/trace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index c80e138..009f459 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -112,7 +112,7 @@ static unsigned int read_magic_time(void)
 	unsigned int val;
 
 	get_rtc_time(&time);
-	pr_info("Time: %2d:%02d:%02d  Date: %02d/%02d/%02d\n",
+	pr_info("Time: %2d:%02d:%02d UTC Date: %02d/%02d/%02d\n",
 		time.tm_hour, time.tm_min, time.tm_sec,
 		time.tm_mon + 1, time.tm_mday, time.tm_year % 100);
 	val = time.tm_year;				/* 100 years */
-- 
1.7.5.2
