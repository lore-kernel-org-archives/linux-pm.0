From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 1/1] power: sbs-manager: Add interrupt support and battery detect gpios
Date: Mon, 25 Jul 2016 15:50:03 +0800
Message-ID: <1469433003-68564-2-git-send-email-preid@electromag.com.au>
References: <1469433003-68564-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:48554 "EHLO
	preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752264AbcGYHuQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2016 03:50:16 -0400
In-Reply-To: <1469433003-68564-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, preid@electromag.com.au, karl-heinz@schneider-inet.de, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

This patch added irq support for the SMBALERT pin and notification of
the battery removal / insertion. The sbs manager would typically be
used with the corresponding sbs-battery driver that currently uses a
gpio input for battery presence and interrupt. To remain compatible with
that existing driver this patch implements GPIO inputs with interrupt
support. IRQ masking is performed in software as the hardware does not
support masking of notifications from each battery.
In addition a power_supply change notification is generated for the sbs
manager device when the AC present flag is changed.
Tested with LTC1760 and dual sbs compatible batteries.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 .../devicetree/bindings/power/sbs,sbs-manager.txt  |  29 ++++
 drivers/power/sbs-manager.c                        | 157 +++++++++++++++++++++
 2 files changed, 186 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
index f0e2253..624967e 100644
--- a/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
+++ b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
@@ -3,6 +3,26 @@ Binding for sbs-manager
 Required properties:
 - compatible: should be "lltc,ltc1760" or use "sbs,sbs-manager" as fallback.
 - reg: integer, i2c address of the device. Should be <0xa>.
+Optional properties:
+- gpio-controller: Marks the port as GPIO controller.
+  See "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
+- #gpio-cells: Should be <2>. The first cell is the pin number, the second cell
+  is used to specify optional parameters:
+  See "gpio-specifier" in .../devicetree/bindings/gpio/gpio.txt.
+- interrupt-parent: Phandle for the interrupt controller that services
+  interrupts for this device.
+  See also .../devicetree/bindings/interrupt-controller/interrupts.txt.
+- interrupts: Interrupt mapping for SMBALERT IRQ.
+  See also .../devicetree/bindings/interrupt-controller/interrupts.txt.
+- #interrupt-cells: Should be <2>. The first cell is the GPIO number. The
+  second cell is used to specify flags. The following subset of flags is
+  supported:
+  - trigger type (bits[1:0]):
+      3 = low-to-high or high-to-low edge triggered
+      Valid value is 3
+  See also .../devicetree/bindings/interrupt-controller/interrupts.txt.
+- interrupt-controller: Marks the device node as an interrupt controller.
+  See also .../devicetree/bindings/interrupt-controller/interrupts.txt.
 
 From OS view the device is basically an i2c-mux used to communicate with up to
 four smart battery devices at address 0xb. The driver actually implements this
@@ -17,6 +37,15 @@ batman@0a {
     #address-cells = <1>;
     #size-cells = <0>;
 
+    gpio-controller;
+    #gpio-cells = <2>;
+
+    interrupt-controller;
+    #interrupt-cells=<2>;
+    interrupt-parent = <&parent_irq>;
+    interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+    interrupts-names = "irq";
+
     i2c@1 {
         #address-cells = <1>;
         #size-cells = <0>;
diff --git a/drivers/power/sbs-manager.c b/drivers/power/sbs-manager.c
index adf9e41..3911329 100644
--- a/drivers/power/sbs-manager.c
+++ b/drivers/power/sbs-manager.c
@@ -20,6 +20,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
 #include <linux/power_supply.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
 
 #define SBSM_MAX_BATS  4
 #define SBSM_RETRY_CNT 3
@@ -30,14 +32,22 @@
 #define SBSM_CMD_BATSYSINFO      0x04
 #define SBSM_CMD_LTC             0x3c
 
+#define SBSM_BIT_AC_PRESENT      BIT(0)
+
 struct sbsm_data {
 	struct i2c_client *client;
 	struct i2c_mux_core *muxc;
 
 	struct power_supply *psy;
 
+	struct gpio_chip chip;
+
 	int cur_chan;         /* currently selected channel */
 	bool is_ltc1760;      /* special capabilities */
+
+	unsigned int irq_mask;
+	unsigned int last_state;
+	unsigned int last_state_cont;
 };
 
 static enum power_supply_property sbsm_props[] = {
@@ -206,6 +216,149 @@ static const struct power_supply_desc sbsm_default_psy_desc = {
 	.property_is_writeable = &sbsm_prop_is_writeable,
 };
 
+static int sbsm_gpio_get_value(struct gpio_chip *gc, unsigned off)
+{
+	struct sbsm_data *data = gpiochip_get_data(gc);
+	int ret;
+
+	ret = sbsm_read_word(data->client, SBSM_CMD_BATSYSSTATE);
+	if (ret < 0)
+		return ret;
+
+	return ret & BIT(off);
+}
+
+/*
+ * This needs to be defined or the GPIO lib fails to register the pin.
+ * But the 'gpio' is always an input.
+ */
+static int sbsm_gpio_direction_input(struct gpio_chip *gc, unsigned off)
+{
+	return 0;
+}
+
+static irqreturn_t sbsm_irq(int irq, void *data)
+{
+	struct sbsm_data *sbsm = data;
+	int ret, i, nhandled = 0, child_irq = 0, irq_bat = 0;
+
+	ret = sbsm_read_word(sbsm->client, SBSM_CMD_BATSYSSTATE);
+	if (ret >= 0)
+		irq_bat = (ret ^ sbsm->last_state) & sbsm->irq_mask;
+	sbsm->last_state = ret;
+
+	ret = sbsm_read_word(sbsm->client, SBSM_CMD_BATSYSSTATECONT);
+	if ((ret >= 0) &&
+	    ((ret ^ sbsm->last_state_cont) & SBSM_BIT_AC_PRESENT)) {
+		irq_bat |= sbsm->irq_mask;
+		power_supply_changed(sbsm->psy);
+	}
+	sbsm->last_state_cont = ret;
+
+	for (i = 0; i < SBSM_MAX_BATS; i++) {
+		if (irq_bat & BIT(i)) {
+			child_irq = irq_find_mapping(sbsm->chip.irqdomain, i);
+			handle_nested_irq(child_irq);
+			nhandled++;
+		}
+	}
+
+	return (nhandled > 0) ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static void sbsm_irq_mask(struct irq_data *data)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct sbsm_data *sbsm = gpiochip_get_data(gc);
+	unsigned int pos = data->hwirq;
+
+	sbsm->irq_mask &= ~BIT(pos);
+}
+
+static void sbsm_irq_unmask(struct irq_data *data)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct sbsm_data *sbsm = gpiochip_get_data(gc);
+	unsigned int pos = data->hwirq;
+
+	sbsm->irq_mask |= BIT(pos);
+}
+
+static int sbsm_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH)
+		return 0;
+
+	return -EINVAL;
+}
+
+static struct irq_chip sbsm_irq_chip = {
+	.name = "sbs-manager",
+	.irq_mask = sbsm_irq_mask,
+	.irq_unmask = sbsm_irq_unmask,
+	.irq_set_type = sbsm_irq_set_type,
+};
+
+static int sbsm_gpio_setup(struct sbsm_data *data)
+{
+	struct gpio_chip *gc = &data->chip;
+	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
+	struct device_node *of_node = client->dev.of_node;
+	unsigned long irqflags = IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_HIGH;
+	int irq = client->irq;
+	int ret;
+
+	if (!of_get_property(of_node, "gpio-controller", NULL))
+		return 0;
+
+	ret  = sbsm_read_word(client, SBSM_CMD_BATSYSSTATE);
+	if (ret < 0)
+		return ret;
+	data->last_state = ret;
+
+	ret  = sbsm_read_word(client, SBSM_CMD_BATSYSSTATECONT);
+	if (ret < 0)
+		return ret;
+	data->last_state_cont = ret;
+
+	gc->get = sbsm_gpio_get_value;
+	gc->direction_input  = sbsm_gpio_direction_input;
+	gc->can_sleep = true;
+	gc->base = -1;
+	gc->ngpio = SBSM_MAX_BATS;
+	gc->label = client->name;
+	gc->parent = dev;
+	gc->owner = THIS_MODULE;
+
+	ret = devm_gpiochip_add_data(dev, gc, data);
+	if (ret) {
+		dev_err(dev, "devm_gpiochip_add_data failed: %d\n", ret);
+		return ret;
+	}
+
+	if (irq < 0)
+		return 0;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, sbsm_irq,
+					irqflags, dev_name(dev), data);
+	if (ret != 0) {
+		dev_err(dev, "unable to request IRQ%d: %d\n", irq, ret);
+		return ret;
+	}
+
+	ret =  gpiochip_irqchip_add(gc, &sbsm_irq_chip, 0, handle_simple_irq,
+				    IRQ_TYPE_NONE);
+	if (ret) {
+		dev_err(dev, "gpiochip_irqchip_add failed: %d\n", ret);
+		return ret;
+	}
+
+	gpiochip_set_chained_irqchip(gc, &sbsm_irq_chip, irq, NULL);
+
+	return ret;
+}
+
 static int sbsm_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
@@ -283,6 +436,10 @@ static int sbsm_probe(struct i2c_client *client,
 		goto err_psy;
 	}
 
+	ret = sbsm_gpio_setup(data);
+	if (ret < 0)
+		goto err_psy;
+
 	dev_info(dev, "sbsm registered\n");
 	return 0;
 
-- 
1.8.3.1

