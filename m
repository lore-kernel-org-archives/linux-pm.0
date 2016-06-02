From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/11] ARM: davinci: Sort frequency table
Date: Thu,  2 Jun 2016 19:49:01 +0530
Message-ID: <08ad59656c493a72284c523560fb820deac95520.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steven Miao <realmz6@gmail.com>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This is required for some of the changes in cpufreq core. There was only
one function dependent on the order of the table, that is fixed as well.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-davinci/da850.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 239886299968..f683c119cfed 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1004,13 +1004,14 @@ static const struct da850_opp da850_opp_96 = {
 		.frequency = freq * 1000, \
 	}
 
+/* Table sorted in ascending order of frequencies */
 static struct cpufreq_frequency_table da850_freq_table[] = {
-	OPP(456),
-	OPP(408),
-	OPP(372),
-	OPP(300),
-	OPP(200),
 	OPP(96),
+	OPP(200),
+	OPP(300),
+	OPP(372),
+	OPP(408),
+	OPP(456),
 	{
 		.driver_data		= 0,
 		.frequency	= CPUFREQ_TABLE_END,
@@ -1076,8 +1077,9 @@ int da850_register_cpufreq(char *async_clk)
 		clk_add_alias("async", da850_cpufreq_device.name,
 							async_clk, NULL);
 	for (i = 0; i < ARRAY_SIZE(da850_freq_table); i++) {
-		if (da850_freq_table[i].frequency <= da850_max_speed) {
-			cpufreq_info.freq_table = &da850_freq_table[i];
+		if (da850_freq_table[i].frequency > da850_max_speed) {
+			&da850_freq_table[i].driver_data = 0;
+			&da850_freq_table[i].frequency = CPUFREQ_TABLE_END;
 			break;
 		}
 	}
-- 
2.7.1.410.g6faf27b
