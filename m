From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH v8 17/18] ARM: tegra: Add CPU regulator to the Jetson TK1
 device tree
Date: Sun,  1 Mar 2015 14:44:40 +0200
Message-ID: <1425213881-5262-18-git-send-email-mikko.perttunen@kapsi.fi>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: pgaikwad@nvidia.com, mturquette@linaro.org, vinceh@nvidia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, tuomas.tynkkynen@iki.fi, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, pwalmsley@nvidia.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Specify the CPU voltage regulator for the cpufreq driver.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index f0888dd..e723759 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1782,6 +1782,12 @@
 		};
 	};
 
+	cpus {
+		cpu@0 {
+			vdd-cpu-supply = <&vdd_cpu>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
-- 
2.3.0
