From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH] cpufreq: highbank-cpufreq: Enable Midway/ECX-2000
Date: Tue,  1 Oct 2013 10:30:24 -0500
Message-ID: <1380641424-5666-1-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
List-Id: linux-pm@vger.kernel.org

Calxeda's new ECX-2000 part uses the same cpufreq interface as highbank,
so add it to the driver's compatibility list.

This is a minor change that can safely be applied to the 3.10 and 3.11
stable trees.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
---
 drivers/cpufreq/highbank-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
index 794123f..bf8902a 100644
--- a/drivers/cpufreq/highbank-cpufreq.c
+++ b/drivers/cpufreq/highbank-cpufreq.c
@@ -66,7 +66,8 @@ static int hb_cpufreq_driver_init(void)
 	struct device_node *np;
 	int ret;
 
-	if (!of_machine_is_compatible("calxeda,highbank"))
+	if ((!of_machine_is_compatible("calxeda,highbank")) &&
+		(!of_machine_is_compatible("calxeda,ecx-2000")))
 		return -ENODEV;
 
 	cpu_dev = get_cpu_device(0);
-- 
1.8.1.2
