From: Colin King <colin.king@canonical.com>
Subject: [PATCH] cpufreq: speedstep-lib: make several arrays static, makes code smaller
Date: Fri, 25 Aug 2017 18:00:16 +0100
Message-ID: <20170825170016.23719-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate arrays on the stack, instead make them static.
Makes the object code smaller by over 860 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  10716	   5196	      0	  15912	   3e28	drivers/cpufreq/speedstep-lib.o

After:
   text	   data	    bss	    dec	    hex	filename
   9690	   5356	      0	  15046	   3ac6	drivers/cpufreq/speedstep-lib.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/cpufreq/speedstep-lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
index 1b8062182c81..ccab452a4ef5 100644
--- a/drivers/cpufreq/speedstep-lib.c
+++ b/drivers/cpufreq/speedstep-lib.c
@@ -35,7 +35,7 @@ static int relaxed_check;
 static unsigned int pentium3_get_frequency(enum speedstep_processor processor)
 {
 	/* See table 14 of p3_ds.pdf and table 22 of 29834003.pdf */
-	struct {
+	static const struct {
 		unsigned int ratio;	/* Frequency Multiplier (x10) */
 		u8 bitmap;		/* power on configuration bits
 					[27, 25:22] (in MSR 0x2a) */
@@ -58,7 +58,7 @@ static unsigned int pentium3_get_frequency(enum speedstep_processor processor)
 	};
 
 	/* PIII(-M) FSB settings: see table b1-b of 24547206.pdf */
-	struct {
+	static const struct {
 		unsigned int value;	/* Front Side Bus speed in MHz */
 		u8 bitmap;		/* power on configuration bits [18: 19]
 					(in MSR 0x2a) */
-- 
2.14.1
