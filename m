From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 4/9] power: supply: axp20x_usb_power: Drop unnecessary static
Date: Thu,  4 May 2017 22:10:49 +0200
Message-ID: <1493928654-18768-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Drop static on a local variable, when the variable is either first
initialized or never used, on every possible execution path through the
function.  The static has no benefit, and dropping it reduces the code
size.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@bad exists@
position p;
identifier x;
type T;
@@

static T x@p;
...
x = <+...x...+>

@@
identifier x;
expression e;
type T;
position p != bad.p;
@@

-static
 T x@p;
 ... when != x
     when strict
?x = e;
// </smpl>

The change in code size is indicates by the following output from the size
command.

before:
   text    data     bss     dec     hex filename
   2865     252       8    3125     c35 drivers/power/supply/axp20x_usb_power.o

after:
   text    data     bss     dec     hex filename
   2822     252       0    3074     c02 drivers/power/supply/axp20x_usb_power.o

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/power/supply/axp20x_usb_power.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 2397c48..44f70dc 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -339,7 +339,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		"VBUS_REMOVAL", "VBUS_VALID", "VBUS_NOT_VALID", NULL };
 	static const char * const axp22x_irq_names[] = {
 		"VBUS_PLUGIN", "VBUS_REMOVAL", NULL };
-	static const char * const *irq_names;
+	const char * const *irq_names;
 	const struct power_supply_desc *usb_power_desc;
 	int i, irq, ret;
 
