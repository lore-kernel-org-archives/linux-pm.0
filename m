From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 03/15] wm8350_power: use permission-specific DEVICE_ATTR variants
Date: Sat, 29 Oct 2016 21:36:57 +0200
Message-ID: <1477769829-22230-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel-janitors@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use DEVICE_ATTR_RO for read only attributes.  This simplifies the source
code, improves readbility, and reduces the chance of inconsistencies.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@ro@
declarer name DEVICE_ATTR;
identifier x,x_show;
@@

DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL);

@script:ocaml@
x << ro.x;
x_show << ro.x_show;
@@

if not (x^"_show" = x_show) then Coccilib.include_match false

@@
declarer name DEVICE_ATTR_RO;
identifier ro.x,ro.x_show;
@@

- DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL);
+ DEVICE_ATTR_RO(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/power/supply/wm8350_power.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/wm8350_power.c
index 5c58806..a2740cf 100644
--- a/drivers/power/supply/wm8350_power.c
+++ b/drivers/power/supply/wm8350_power.c
@@ -182,7 +182,7 @@ static ssize_t charger_state_show(struct device *dev,
 	return sprintf(buf, "%s\n", charge);
 }
 
-static DEVICE_ATTR(charger_state, 0444, charger_state_show, NULL);
+static DEVICE_ATTR_RO(charger_state);
 
 static irqreturn_t wm8350_charger_handler(int irq, void *data)
 {
