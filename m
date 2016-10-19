From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/5] cpufreq: enable the DT cpufreq driver on the Integrators
Date: Wed, 19 Oct 2016 11:59:10 +0200
Message-ID: <1476871154-32243-2-git-send-email-linus.walleij@linaro.org>
References: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This enables the generic DT and OPP-based cpufreq driver on the
ARM Integrator/AP and Integrator/CP.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 71267626456b..142a6f615e52 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -26,6 +26,9 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "allwinner,sun8i-a83t", },
 	{ .compatible = "allwinner,sun8i-h3", },
 
+	{ .compatible = "arm,integrator-ap", },
+	{ .compatible = "arm,integrator-cp", },
+
 	{ .compatible = "hisilicon,hi6220", },
 
 	{ .compatible = "fsl,imx27", },
-- 
2.7.4
