From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 2/2] Revert "cpufreq: rcar: Add support for R8A7795 SoC"
Date: Wed,  2 May 2018 11:58:06 +0200
Message-ID: <20180502095806.30341-3-horms+renesas@verge.net.au>
References: <20180502095806.30341-1-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180502095806.30341-1-horms+renesas@verge.net.au>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-renesas-soc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This reverts commit 034def597bb73cbf29ffade7d8aec8408af8c743.

This is no longer needed since the flowing commit and to the best
of my knowledge is not relied on by any upstream DTS:
edeec420de24 ("cpufreq: dt-platdev: Automatically create cpufreq device with OPP v2")

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 206ae7460f4a..c2165edadd41 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -66,7 +66,6 @@ static const struct of_device_id whitelist[] __initconst = {
 	{ .compatible = "renesas,r8a7792", },
 	{ .compatible = "renesas,r8a7793", },
 	{ .compatible = "renesas,r8a7794", },
-	{ .compatible = "renesas,r8a7795", },
 	{ .compatible = "renesas,sh73a0", },
 
 	{ .compatible = "rockchip,rk2928", },
-- 
2.11.0
