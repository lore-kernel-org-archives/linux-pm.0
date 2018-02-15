From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] cpufreq: s3c24xx: Delete an error message for a failed memory
 allocation in two functions
Date: Thu, 15 Feb 2018 17:40:12 +0100
Message-ID: <201722ce-019d-a5b4-fc00-74679d82b64f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Feb 2018 17:28:40 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/cpufreq/s3c24xx-cpufreq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 7b596fa38ad2..024afd0b9458 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -473,10 +473,8 @@ int __init s3c_cpufreq_setboard(struct s3c_cpufreq_board *board)
 	 * initdata. */
 
 	ours = kzalloc(sizeof(*ours), GFP_KERNEL);
-	if (ours == NULL) {
-		pr_err("%s: no memory\n", __func__);
+	if (!ours)
 		return -ENOMEM;
-	}
 
 	*ours = *board;
 	cpu_cur.board = ours;
@@ -562,10 +560,8 @@ static int s3c_cpufreq_build_freq(void)
 	size++;
 
 	ftab = kzalloc(sizeof(*ftab) * size, GFP_KERNEL);
-	if (!ftab) {
-		pr_err("%s: no memory for tables\n", __func__);
+	if (!ftab)
 		return -ENOMEM;
-	}
 
 	ftab_size = size;
 
-- 
2.16.1
