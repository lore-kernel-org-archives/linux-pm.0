From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 3/4] PM / devfreq: rockchip-dfi: Fix module autoload
Date: Wed, 19 Oct 2016 18:06:26 -0300
Message-ID: <1476911187-11040-4-git-send-email-javier@osg.samsung.com>
References: <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476911187-11040-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, linux-rockchip@lists.infradead.org, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/devfreq/event/rockchip-dfi.ko | grep alias
$

After this patch:

$ modinfo drivers/devfreq/event/rockchip-dfi.ko | grep alias
alias:          of:N*T*Crockchip,rk3399-dfiC*
alias:          of:N*T*Crockchip,rk3399-dfi

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/devfreq/event/rockchip-dfi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 43fcc5a7f515..22b113363ffc 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -188,6 +188,7 @@ static const struct of_device_id rockchip_dfi_id_match[] = {
 	{ .compatible = "rockchip,rk3399-dfi" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, rockchip_dfi_id_match);
 
 static int rockchip_dfi_probe(struct platform_device *pdev)
 {
-- 
2.7.4
