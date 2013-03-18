From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 7/8] stating: ti-soc-thermal: use sizeof(*pointer) while allocating
Date: Mon, 18 Mar 2013 10:59:15 -0400
Message-ID: <1363618756-15851-8-git-send-email-eduardo.valentin@ti.com>
References: <1363618756-15851-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1363618756-15851-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

Follow Documentation/CodingStyle and use sizeof(*pointer)
instead of sizeof(struct type).

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

diff --git a/drivers/staging/ti-soc-thermal/ti-bandgap.c b/drivers/staging/ti-soc-thermal/ti-bandgap.c
index b74e847..4382c0c 100644
--- a/drivers/staging/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/staging/ti-soc-thermal/ti-bandgap.c
@@ -902,8 +902,7 @@ static struct ti_bandgap *ti_bandgap_build(struct platform_device *pdev)
 		return ERR_PTR(-EINVAL);
 	}
 
-	bgp = devm_kzalloc(&pdev->dev, sizeof(struct ti_bandgap),
-				    GFP_KERNEL);
+	bgp = devm_kzalloc(&pdev->dev, sizeof(*bgp), GFP_KERNEL);
 	if (!bgp) {
 		dev_err(&pdev->dev, "Unable to allocate mem for driver ref\n");
 		return ERR_PTR(-ENOMEM);
-- 
1.7.7.1.488.ge8e1c

