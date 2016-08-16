From: Finlye Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH v1 1/3] nvmem: rockchip-efuse: Change initcall to subsys
Date: Tue, 16 Aug 2016 10:38:57 +0800
Message-ID: <1471315139-28285-2-git-send-email-finley.xiao@rock-chips.com>
References: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com, heiko@sntech.de, robh+dt@kernel.org, frowand.list@gmail.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, mark.rutland@arm.com, khilman@kernel.org, nm@ti.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, sboyd@codeaurora.org
Cc: devicetree@vger.kernel.org, tim.chen@rock-chips.com, linux-pm@vger.kernel.org, lin.huang@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, tony.xie@rock-chips.com, Finley Xiao <finley.xiao@rock-chips.com>, ulysses.huang@rock-chips.com, rocky.hao@rock-chips.com, jay.xu@rock-chips.com, linux-arm-kernel@lists.infradead.org, wxt@rock-chips.com
List-Id: linux-pm@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

We will register a cpufreq notifier for adjusting opp's voltage, and it
need to fetch cpu's leakage from efuse in the notifier_call. so the efuse
driver should probe before cpufreq driver.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 drivers/nvmem/rockchip-efuse.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index 4d3f391..378993d 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -144,6 +144,13 @@ static struct platform_driver rockchip_efuse_driver = {
 	},
 };
 
-module_platform_driver(rockchip_efuse_driver);
+static int __init rockchip_efuse_module_init(void)
+{
+	return platform_driver_probe(&rockchip_efuse_driver,
+				     rockchip_efuse_probe);
+}
+
+subsys_initcall(rockchip_efuse_module_init);
+
 MODULE_DESCRIPTION("rockchip_efuse driver");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1
