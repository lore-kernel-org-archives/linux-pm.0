From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PM / AVS: rockchip-io: make the log more consistent
Date: Mon, 10 Oct 2016 20:44:22 +0800
Message-ID: <1476103462-7559-1-git-send-email-shawn.lin@rock-chips.com>
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
To: Kevin Hilman <khilman@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Nishanth Menon <nm@ti.com>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When testing SD hotplug automatically, I got bunch of
useless log like this:

[  588.357838] mmc0: card 0007 removed
[  589.492664] rockchip-iodomain ff770000.syscon:io-domains: Setting to 3300000 done
[  589.500698] vccio_sd: ramp_delay not set
[  589.504817] rockchip-iodomain ff770000.syscon:io-domains: Setting to 3300000 done
[  589.669705] rockchip-iodomain ff770000.syscon:io-domains: Setting to 3300000 done
[  589.677593] vccio_sd: ramp_delay not set
[  589.681581] rockchip-iodomain ff770000.syscon:io-domains: Setting to 1800000 done
[  590.032820] dwmmc_rockchip ff0c0000.dwmmc: Successfully tuned phase to 140
[  590.039725] mmc0: new ultra high speed SDR50 SDHC card at address 0007
[  590.046641] mmcblk0: mmc0:0007 SD32G 29.3 GiB
[  590.052163]  mmcblk0: p1

Moreover the code is intent to print the 'uV' for debug but
later print it using dev_info. It looks more like to me that
it should be the real intention of the code. Anyway, let's
mark this verbose log as debug message.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/power/avs/rockchip-io-domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
index 01b6d3f..56bce19 100644
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -143,7 +143,7 @@ static int rockchip_iodomain_notify(struct notifier_block *nb,
 	if (ret && event == REGULATOR_EVENT_PRE_VOLTAGE_CHANGE)
 		return NOTIFY_BAD;
 
-	dev_info(supply->iod->dev, "Setting to %d done\n", uV);
+	dev_dbg(supply->iod->dev, "Setting to %d done\n", uV);
 	return NOTIFY_OK;
 }
 
-- 
2.3.7
