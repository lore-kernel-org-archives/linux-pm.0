From: <cl@rock-chips.com>
Subject: [PATCH v2 2/3] cpufreq: rockchip: add support for rk3328 soc
Date: Thu, 24 Aug 2017 10:37:02 +0800
Message-ID: <1503542223-21044-3-git-send-email-cl@rock-chips.com>
References: <1503542223-21044-1-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1503542223-21044-1-git-send-email-cl@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: heiko@sntech.de
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, rjw@rjwysocki.net, catalin.marinas@arm.com, shawn.lin@rock-chips.com, linux-pm@vger.kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, kever.yang@rock-chips.com, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, Liang Chen <cl@rock-chips.com>, viresh.kumar@linaro.org, fabio.estevam@nxp.com, rocky.hao@rock-chips.com, shawnguo@kernel.org, afaerber@suse.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Add compatible rockchip,rk3328 to the machines table to
launch cpufreq-dt driver for rk3328 soc.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 1c26292..f16c3ba 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -76,6 +76,7 @@
 	{ .compatible = "rockchip,rk3188", },
 	{ .compatible = "rockchip,rk3228", },
 	{ .compatible = "rockchip,rk3288", },
+	{ .compatible = "rockchip,rk3328", },
 	{ .compatible = "rockchip,rk3366", },
 	{ .compatible = "rockchip,rk3368", },
 	{ .compatible = "rockchip,rk3399", },
-- 
1.9.1
