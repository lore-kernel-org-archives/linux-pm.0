From: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
Subject: [PATCH 1/2] power: reset: syscon-poweroff: add a mask property
Date: Tue,  7 Feb 2017 17:56:05 +0200
Message-ID: <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
References: <1486472054-4367-1-git-send-email-guy.shapiro@mobi-wize.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBCNJ5VGR4ANRBYW447CAKGQEHP2Z4NI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1486472054-4367-1-git-send-email-guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Cc: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Make the syscon-poweroff driver accept value and mask instead of
just value.

Prior to this patch, the property name for the value was 'mask'. If
only the mask property is defined on a node, maintain compatibility
by using it as the value.

Signed-off-by: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
---
 .../bindings/power/reset/syscon-poweroff.txt          | 11 +++++++++--
 drivers/power/reset/syscon-poweroff.c                 | 19 ++++++++++++++++---
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
index 1e2546f..022ed1f 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
+++ b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
@@ -3,13 +3,20 @@ Generic SYSCON mapped register poweroff driver
 This is a generic poweroff driver using syscon to map the poweroff register.
 The poweroff is generally performed with a write to the poweroff register
 defined by the register map pointed by syscon reference plus the offset
-with the mask defined in the poweroff node.
+with the value and mask defined in the poweroff node.
 
 Required properties:
 - compatible: should contain "syscon-poweroff"
 - regmap: this is phandle to the register map node
 - offset: offset in the register map for the poweroff register (in bytes)
-- mask: the poweroff value written to the poweroff register (32 bit access)
+- value: the poweroff value written to the poweroff register (32 bit access)
+
+Optional properties:
+- mask: update only the register bits defined by the mask (32 bit)
+
+Legacy usage:
+If a node doesn't contain a value property but contains a mask property, the
+mask property is used as the value.
 
 Default will be little endian mode, 32 bit access only.
 
diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/syscon-poweroff.c
index b683383..f9f1cb5 100644
--- a/drivers/power/reset/syscon-poweroff.c
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -28,12 +28,13 @@
 
 static struct regmap *map;
 static u32 offset;
+static u32 value;
 static u32 mask;
 
 static void syscon_poweroff(void)
 {
 	/* Issue the poweroff */
-	regmap_write(map, offset, mask);
+	regmap_update_bits(map, offset, mask, value);
 
 	mdelay(1000);
 
@@ -43,6 +44,7 @@ static void syscon_poweroff(void)
 static int syscon_poweroff_probe(struct platform_device *pdev)
 {
 	char symname[KSYM_NAME_LEN];
+	int mask_err, value_err;
 
 	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "regmap");
 	if (IS_ERR(map)) {
@@ -55,11 +57,22 @@ static int syscon_poweroff_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (of_property_read_u32(pdev->dev.of_node, "mask", &mask)) {
-		dev_err(&pdev->dev, "unable to read 'mask'");
+	value_err = of_property_read_u32(pdev->dev.of_node, "value", &value);
+	mask_err = of_property_read_u32(pdev->dev.of_node, "mask", &mask);
+	if (value_err && mask_err) {
+		dev_err(&pdev->dev, "unable to read 'value' and 'mask'");
 		return -EINVAL;
 	}
 
+	if (value_err) {
+		/* support old binding */
+		value = mask;
+		mask = 0xFFFFFFFF;
+	} else if (mask_err) {
+		/* support value without mask*/
+		mask = 0xFFFFFFFF;
+	}
+
 	if (pm_power_off) {
 		lookup_symbol_name((ulong)pm_power_off, symname);
 		dev_err(&pdev->dev,
-- 
2.1.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
