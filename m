Received: from outbound11.mail.transip.nl (outbound11.mail.transip.nl [136.144.136.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267C399CE6;
	Wed,  3 Jun 2026 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470937; cv=none; b=iS871DIV2xA/hDEciU90+ubXhlGsQ+GUzhusibuzyqnYzaHlzwsrJzKJFZRuhAxR7hCeoYlq4RRc0n9W84OCm4OsvQW0nD0rYwJhj63q9sralIjUcxVfW+tX23RPQ8vtCpnB0GTVShOgGSjT0HLU6jxjAWVoq/YcifqU90iAcpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470937; c=relaxed/simple;
	bh=zxHoyjs6y/jmxNfBUNRe8Y4jk7x+5/HosJWesooToGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpVZMxdwjuwcFEM8GsdpdfGk2UG9B7oUr/4y5fY12pmbkLpB3urDddA7IYV1bM18qY/OT1n04lXyA6Zg+6hzHEIXlA0RRSgBV0il7fD42pcQQ/fe1VDs+Lh3Eqe3qvCIEy2FNDgqNdiPDzoCQjvdZ0snvVxhR2loUp9IDppxA+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=FGiAGq78; arc=none smtp.client-ip=136.144.136.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="FGiAGq78"
Received: from submission9.mail.transip.nl (unknown [10.103.8.160])
	by outbound11.mail.transip.nl (Postfix) with ESMTP id 4gVf9R1HYvzkQMbd;
	Wed,  3 Jun 2026 09:15:23 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission9.mail.transip.nl (Postfix) with ESMTPA id 4gVf9P4YL7z3NZKgV;
	Wed,  3 Jun 2026 09:15:21 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: sre@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH 2/2] power: supply: max8903: add DC and USB input current-limit GPIO controls
Date: Wed,  3 Jun 2026 09:15:19 +0200
Message-ID: <20260603071519.807604-3-github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603071519.807604-1-github.com@herrie.org>
References: <20260603071519.807604-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission9.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780470922; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version:content-type;
 bh=IkvPeEvcPZJF24rL45B2rO35dUlyNTzo5GHUZFfz18Q=;
 b=FGiAGq78jyyEklyqbnHAX1weKTpm+5yvRzq8b3bIYxJ4ObfHm3kJVuH34FinGqyD+npWmp
 vOiylZja2cdFGDr7BJf9VP2S60g/dcy+vJQorqFccgKsaNDqY+cxTPvEQdG+lYnsplJgAH
 05AcUi0aKJdUNStZXzZ6uUt1ftHKYgTTbx+PEK+2nfOc0KQSsOkxygUMXffV2+BF3prg2P
 8fpNfffbi6HrYz++ld28oNO9G3O8wF2SKLIqneH5bC1PtIbO32KauCmAkGfNfii4Cp+HKz
 CZcWYQWkWIn7Pk6FJSAMpwkFDxnLm2tH8+zh0783SPkYRQcO8GCbex2HyuTttQ==
X-Report-Abuse-To: abuse@transip.nl

Add two optional current-limit knobs surfaced through
POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, selected by which input source
is currently online:

  - DC (DOK / TA-IN): a "dc-current-limit-gpios" array drives the
    GPIOs of an external resistor mux connected to the MAX8903 IDC pin
    (DC Current-Limit Set Input, pin 11). The IDC pin programs the
    step-down DC input current limit from 0.5 A to 2 A via R_IDC when
    the DCM mode pin is logic-high. The DT property
    "dc-current-limit-mapping" describes the (current_ua, gpio_value)
    pairs the board can program; the driver picks the largest entry
    whose limit is <= the requested limit. A 0 uA entry, used to
    stop drawing DC current, is selectable by issuing a 0 uA request
    (the selection uses a -1 "not found" sentinel rather than
    tracking best_limit > 0, so the all-zero entry can win).

  - USB (UOK / USB-IN): a single "usb-current-limit-gpio" drives the
    MAX8903 IUSB pin (USB Current-Limit Set Input, pin 7). Logic-low
    selects 100 mA; logic-high selects 500 mA per the MAX8903 spec.
    The DT property "usb-current-limit-values" overrides those limits
    for boards with non-standard IUSB thresholds. The requested limit
    selects the highest of the two configured values that does not
    exceed the cap: requests at or above the high value pick high,
    requests at or above the low value pick low, and a request below
    the low value is rejected with -EINVAL rather than silently
    programming a higher current that would violate the system power
    budget.

The dispatch in max8903_set_property() to the DC vs USB path needs to
match the active source flag set by the corresponding *_ok GPIO IRQ
handler; both update sites take a new struct mutex source_lock so the
check and the resulting hardware write cannot be torn by a concurrent
IRQ flipping the source-online flag mid-decision. The IRQs are
requested with IRQF_ONESHOT (threaded), so a sleepable lock is the
right primitive in both contexts. max8903_get_property() also takes
source_lock briefly to snapshot the source flags and current-limit
values so userspace never observes a torn pair of
(source-online flag, current-limit ua).

dc-current-limit-mapping gpio_value entries are validated at parse
against the GPIO array width so a malformed DT value is rejected
instead of being silently truncated by gpiod_set_array_value() and
selecting the wrong mux level. The mapping is additionally required
to contain a gpio_value=0 entry: devm_gpiod_get_array_optional()
asks for GPIOD_OUT_LOW, so the hardware mux starts at gpio_value 0,
and the driver seeds dc_current_limit_ua from the matching map entry.
A DT lacking the all-zero entry is rejected with -EINVAL because
otherwise the reported INPUT_CURRENT_LIMIT could disagree with the
mux state until a set_property write picks a real value.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 drivers/power/supply/max8903_charger.c | 369 ++++++++++++++++++++++++-
 1 file changed, 358 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/max8903_charger.c b/drivers/power/supply/max8903_charger.c
index 45fbaad6c647..19c2b348a045 100644
--- a/drivers/power/supply/max8903_charger.c
+++ b/drivers/power/supply/max8903_charger.c
@@ -9,11 +9,18 @@
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/power_supply.h>
 #include <linux/platform_device.h>
 
+struct max8903_current_limit_mapping {
+	u32 limit_ua;		/* Current limit in microamps */
+	u32 gpio_value;		/* GPIO bit pattern */
+};
+
 struct max8903_data {
 	struct device *dev;
 	struct power_supply *psy;
@@ -31,6 +38,27 @@ struct max8903_data {
 	struct gpio_desc *flt; /* Fault output */
 	struct gpio_desc *dcm; /* Current-Limit Mode input (1: DC, 2: USB) */
 	struct gpio_desc *usus; /* USB Suspend Input (1: suspended) */
+
+	/* DC current limit control (ISET pins) */
+	struct gpio_descs *dc_current_limit_gpios;
+	struct max8903_current_limit_mapping *dc_current_limit_map;
+	u32 dc_current_limit_map_size;
+	u32 dc_current_limit_ua;	/* Current setting in uA */
+
+	/* USB current limit control (IUSB pin) */
+	struct gpio_desc *usb_current_limit_gpio;
+	u32 usb_current_limit_low_ua;	/* Current when GPIO low */
+	u32 usb_current_limit_high_ua;	/* Current when GPIO high */
+	u32 usb_current_limit_ua;	/* Current setting in uA */
+
+	/*
+	 * Serialises ta_in / usb_in updates against
+	 * max8903_set_property() which steers the current-limit write to
+	 * the DC or USB path based on which source is currently online.
+	 * The IRQ handlers are requested with IRQF_ONESHOT (threaded), so
+	 * a sleepable mutex is the right primitive in both contexts.
+	 */
+	struct mutex source_lock;
 	bool fault;
 	bool usb_in;
 	bool ta_in;
@@ -40,6 +68,7 @@ static enum power_supply_property max8903_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS, /* Charger status output */
 	POWER_SUPPLY_PROP_ONLINE, /* External power source */
 	POWER_SUPPLY_PROP_HEALTH, /* Fault or OK */
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, /* Input current limit */
 };
 
 static int max8903_get_property(struct power_supply *psy,
@@ -47,6 +76,24 @@ static int max8903_get_property(struct power_supply *psy,
 		union power_supply_propval *val)
 {
 	struct max8903_data *data = power_supply_get_drvdata(psy);
+	bool ta_in, usb_in;
+	u32 dc_limit, usb_limit;
+
+	/*
+	 * Snapshot the source flags and current-limit settings under the
+	 * source_lock that the IRQs (max8903_dcin / max8903_usbin) and
+	 * max8903_set_property() take when updating them, so we never
+	 * observe a torn pair of (source-online flag, current-limit ua).
+	 * The gpiod_get_value() reads further down deliberately stay
+	 * outside the lock — they hit the GPIO controller, not driver
+	 * state, and the IRQs do not touch them under the lock either.
+	 */
+	mutex_lock(&data->source_lock);
+	ta_in = data->ta_in;
+	usb_in = data->usb_in;
+	dc_limit = data->dc_current_limit_ua;
+	usb_limit = data->usb_current_limit_ua;
+	mutex_unlock(&data->source_lock);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -55,21 +102,31 @@ static int max8903_get_property(struct power_supply *psy,
 			if (gpiod_get_value(data->chg))
 				/* CHG asserted */
 				val->intval = POWER_SUPPLY_STATUS_CHARGING;
-			else if (data->usb_in || data->ta_in)
+			else if (usb_in || ta_in)
 				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 			else
 				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		}
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = 0;
-		if (data->usb_in || data->ta_in)
-			val->intval = 1;
+		val->intval = (ta_in || usb_in) ? 1 : 0;
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
-		val->intval = POWER_SUPPLY_HEALTH_GOOD;
-		if (data->fault)
-			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		/*
+		 * data->fault is a single bool toggled from one IRQ
+		 * handler, so a torn read is not possible; no need to
+		 * extend source_lock coverage here.
+		 */
+		val->intval = data->fault ? POWER_SUPPLY_HEALTH_UNSPEC_FAILURE
+					  : POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		if (ta_in && data->dc_current_limit_gpios)
+			val->intval = dc_limit;
+		else if (usb_in && data->usb_current_limit_gpio)
+			val->intval = usb_limit;
+		else
+			return -ENODATA;
 		break;
 	default:
 		return -EINVAL;
@@ -78,6 +135,130 @@ static int max8903_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int max8903_set_dc_current_limit(struct max8903_data *data, u32 limit_ua)
+{
+	int i, best_idx = -1;
+	u32 best_gpio_value;
+	/*
+	 * gpio_value is a u32 in the DT mapping and is parse-time
+	 * validated to fit in BIT(ndescs); size the bitmap to the full
+	 * width of the source u32 so a DT with up to 32 dc-current-limit
+	 * GPIOs cannot overflow this stack buffer.
+	 */
+	DECLARE_BITMAP(values, BITS_PER_TYPE(u32));
+
+	if (!data->dc_current_limit_gpios)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Find the highest supported current <= requested. Use a -1
+	 * "not found" sentinel rather than tracking best_limit > 0 so
+	 * that a 0 uA entry (used to disable charging) can be selected
+	 * by a 0 uA request.
+	 */
+	for (i = 0; i < data->dc_current_limit_map_size; i++) {
+		if (data->dc_current_limit_map[i].limit_ua > limit_ua)
+			continue;
+		if (best_idx < 0 ||
+		    data->dc_current_limit_map[i].limit_ua >
+				data->dc_current_limit_map[best_idx].limit_ua)
+			best_idx = i;
+	}
+
+	if (best_idx < 0)
+		return -EINVAL;
+
+	best_gpio_value = data->dc_current_limit_map[best_idx].gpio_value;
+	bitmap_from_arr32(values, &best_gpio_value, BITS_PER_TYPE(u32));
+	gpiod_set_array_value_cansleep(data->dc_current_limit_gpios->ndescs,
+				       data->dc_current_limit_gpios->desc,
+				       data->dc_current_limit_gpios->info,
+				       values);
+
+	data->dc_current_limit_ua = data->dc_current_limit_map[best_idx].limit_ua;
+	dev_dbg(data->dev, "DC current limit set to %u uA\n",
+		data->dc_current_limit_ua);
+
+	return 0;
+}
+
+static int max8903_set_usb_current_limit(struct max8903_data *data, u32 limit_ua)
+{
+	u32 selected;
+	int gpio_val;
+
+	if (!data->usb_current_limit_gpio)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Pick the highest of the two configured limits that does not
+	 * exceed the requested cap. Mirror the DC path's policy: if
+	 * neither value fits (the request is below even the low limit),
+	 * refuse the request rather than silently program a higher
+	 * current that violates the system power budget.
+	 */
+	if (limit_ua >= data->usb_current_limit_high_ua) {
+		selected = data->usb_current_limit_high_ua;
+		gpio_val = 1;
+	} else if (limit_ua >= data->usb_current_limit_low_ua) {
+		selected = data->usb_current_limit_low_ua;
+		gpio_val = 0;
+	} else {
+		return -EINVAL;
+	}
+
+	gpiod_set_value_cansleep(data->usb_current_limit_gpio, gpio_val);
+	data->usb_current_limit_ua = selected;
+
+	dev_dbg(data->dev, "USB current limit set to %u uA\n",
+		data->usb_current_limit_ua);
+
+	return 0;
+}
+
+static int max8903_set_property(struct power_supply *psy,
+		enum power_supply_property psp,
+		const union power_supply_propval *val)
+{
+	struct max8903_data *data = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		/*
+		 * Hold source_lock across the source check and the
+		 * resulting hardware write so the IRQ handler cannot
+		 * flip ta_in/usb_in between them and have us program the
+		 * limit for a source that has just gone offline.
+		 */
+		mutex_lock(&data->source_lock);
+		if (data->ta_in && data->dc_current_limit_gpios)
+			ret = max8903_set_dc_current_limit(data, val->intval);
+		else if (data->usb_in && data->usb_current_limit_gpio)
+			ret = max8903_set_usb_current_limit(data, val->intval);
+		else
+			ret = -EINVAL;
+		mutex_unlock(&data->source_lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max8903_property_is_writeable(struct power_supply *psy,
+		enum power_supply_property psp)
+{
+	struct max8903_data *data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return data->dc_current_limit_gpios ||
+		       data->usb_current_limit_gpio;
+	default:
+		return 0;
+	}
+}
+
 static irqreturn_t max8903_dcin(int irq, void *_data)
 {
 	struct max8903_data *data = _data;
@@ -91,12 +272,21 @@ static irqreturn_t max8903_dcin(int irq, void *_data)
 	 * library as the line should be flagged GPIO_ACTIVE_LOW in the device
 	 * tree.
 	 */
+	/*
+	 * Sample the line under source_lock so a concurrent
+	 * max8903_set_property() observes either the old or the new
+	 * state consistently, never a torn read where the lock is held
+	 * but the cached flag is about to be updated.
+	 */
+	mutex_lock(&data->source_lock);
 	ta_in = gpiod_get_value(data->dok);
-
-	if (ta_in == data->ta_in)
+	if (ta_in == data->ta_in) {
+		mutex_unlock(&data->source_lock);
 		return IRQ_HANDLED;
+	}
 
 	data->ta_in = ta_in;
+	mutex_unlock(&data->source_lock);
 
 	/* Set Current-Limit-Mode 1:DC 0:USB */
 	if (data->dcm)
@@ -150,12 +340,16 @@ static irqreturn_t max8903_usbin(int irq, void *_data)
 	 * library as the line should be flagged GPIO_ACTIVE_LOW in the device
 	 * tree.
 	 */
+	/* See ta_in handler: sample the line under the lock. */
+	mutex_lock(&data->source_lock);
 	usb_in = gpiod_get_value(data->uok);
-
-	if (usb_in == data->usb_in)
+	if (usb_in == data->usb_in) {
+		mutex_unlock(&data->source_lock);
 		return IRQ_HANDLED;
+	}
 
 	data->usb_in = usb_in;
+	mutex_unlock(&data->source_lock);
 
 	/* Do not touch Current-Limit-Mode */
 
@@ -221,6 +415,148 @@ static irqreturn_t max8903_fault(int irq, void *_data)
 	return IRQ_HANDLED;
 }
 
+static int max8903_parse_dc_current_limit(struct platform_device *pdev,
+					  struct max8903_data *data)
+{
+	struct device *dev = &pdev->dev;
+	int ret, i, map_size;
+	u32 *map;
+
+	data->dc_current_limit_gpios = devm_gpiod_get_array_optional(dev,
+					"dc-current-limit", GPIOD_OUT_LOW);
+	if (IS_ERR(data->dc_current_limit_gpios))
+		return dev_err_probe(dev, PTR_ERR(data->dc_current_limit_gpios),
+				     "failed to get DC current limit GPIOs");
+
+	if (!data->dc_current_limit_gpios)
+		return 0;	/* Optional feature not present */
+
+	/* Parse mapping: pairs of (current_ua, gpio_value) */
+	map_size = device_property_count_u32(dev, "dc-current-limit-mapping");
+	if (map_size <= 0 || map_size % 2) {
+		dev_err(dev, "invalid dc-current-limit-mapping\n");
+		return -EINVAL;
+	}
+
+	map = devm_kcalloc(dev, map_size, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	ret = device_property_read_u32_array(dev, "dc-current-limit-mapping",
+					     map, map_size);
+	if (ret) {
+		dev_err(dev, "failed to read dc-current-limit-mapping\n");
+		return ret;
+	}
+
+	data->dc_current_limit_map_size = map_size / 2;
+	data->dc_current_limit_map = devm_kcalloc(dev,
+					data->dc_current_limit_map_size,
+					sizeof(*data->dc_current_limit_map),
+					GFP_KERNEL);
+	if (!data->dc_current_limit_map)
+		return -ENOMEM;
+
+	for (i = 0; i < data->dc_current_limit_map_size; i++) {
+		u32 gpio_value = map[i * 2 + 1];
+
+		/*
+		 * gpio_value is the bitmap programmed across the
+		 * dc-current-limit GPIOs, so it cannot represent more
+		 * bits than the GPIO array width. A larger value would
+		 * be silently truncated by gpiod_set_array_value() and
+		 * select the wrong limit; reject it at parse time so
+		 * the bogus DT is visible to the integrator.
+		 */
+		if (gpio_value >= BIT(data->dc_current_limit_gpios->ndescs)) {
+			dev_err(dev,
+				"dc-current-limit-mapping entry %d: gpio_value 0x%x exceeds %u-GPIO range\n",
+				i, gpio_value,
+				data->dc_current_limit_gpios->ndescs);
+			return -EINVAL;
+		}
+		data->dc_current_limit_map[i].limit_ua = map[i * 2];
+		data->dc_current_limit_map[i].gpio_value = gpio_value;
+	}
+
+	/*
+	 * devm_gpiod_get_array_optional() above asked for GPIOD_OUT_LOW,
+	 * so the hardware mux starts at gpio_value 0. Require the DT
+	 * mapping to include a gpio_value=0 entry so the software
+	 * current-limit state has a definite initial value matching the
+	 * hardware. Without this entry we would have to guess and the
+	 * reported INPUT_CURRENT_LIMIT could disagree with what the
+	 * mux is actually wired to until a set_property write picks a
+	 * real value.
+	 */
+	for (i = 0; i < data->dc_current_limit_map_size; i++)
+		if (data->dc_current_limit_map[i].gpio_value == 0)
+			break;
+	if (i == data->dc_current_limit_map_size) {
+		dev_err(dev,
+			"dc-current-limit-mapping must include a gpio_value=0 entry to describe the boot-time mux state\n");
+		return -EINVAL;
+	}
+	data->dc_current_limit_ua = data->dc_current_limit_map[i].limit_ua;
+
+	dev_dbg(dev, "DC current limit control: %d levels available, initial %u uA\n",
+		data->dc_current_limit_map_size, data->dc_current_limit_ua);
+
+	return 0;
+}
+
+static int max8903_parse_usb_current_limit(struct platform_device *pdev,
+					   struct max8903_data *data)
+{
+	struct device *dev = &pdev->dev;
+	u32 limits[2];
+	int ret;
+
+	data->usb_current_limit_gpio = devm_gpiod_get_optional(dev,
+					"usb-current-limit", GPIOD_OUT_LOW);
+	if (IS_ERR(data->usb_current_limit_gpio))
+		return dev_err_probe(dev, PTR_ERR(data->usb_current_limit_gpio),
+				     "failed to get USB current limit GPIO");
+
+	if (!data->usb_current_limit_gpio)
+		return 0;	/* Optional feature not present */
+
+	/* Parse [low_ua, high_ua] values, default to USB spec values */
+	ret = device_property_read_u32_array(dev, "usb-current-limit-values",
+					     limits, 2);
+	if (ret) {
+		/* Default to USB spec values */
+		data->usb_current_limit_low_ua = 100000;   /* 100mA */
+		data->usb_current_limit_high_ua = 500000;  /* 500mA */
+	} else {
+		data->usb_current_limit_low_ua = limits[0];
+		data->usb_current_limit_high_ua = limits[1];
+	}
+
+	/*
+	 * max8903_set_usb_current_limit() picks the highest cap that
+	 * doesn't exceed the request by checking >=high first then
+	 * >=low; that policy only works when high > low. Reject DTs
+	 * that hand the property in the wrong order rather than
+	 * silently program a sub-optimal current limit.
+	 */
+	if (data->usb_current_limit_high_ua <= data->usb_current_limit_low_ua) {
+		dev_err(dev,
+			"usb-current-limit-values must be [low, high] with high > low (got low=%u uA, high=%u uA)\n",
+			data->usb_current_limit_low_ua,
+			data->usb_current_limit_high_ua);
+		return -EINVAL;
+	}
+
+	/* Start at low current for safety */
+	data->usb_current_limit_ua = data->usb_current_limit_low_ua;
+
+	dev_dbg(dev, "USB current limit control: %u/%u uA\n",
+		data->usb_current_limit_low_ua, data->usb_current_limit_high_ua);
+
+	return 0;
+}
+
 static int max8903_setup_gpios(struct platform_device *pdev)
 {
 	struct max8903_data *data = platform_get_drvdata(pdev);
@@ -335,17 +671,28 @@ static int max8903_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	data->dev = dev;
+	mutex_init(&data->source_lock);
 	platform_set_drvdata(pdev, data);
 
 	ret = max8903_setup_gpios(pdev);
 	if (ret)
 		return ret;
 
+	ret = max8903_parse_dc_current_limit(pdev, data);
+	if (ret)
+		return ret;
+
+	ret = max8903_parse_usb_current_limit(pdev, data);
+	if (ret)
+		return ret;
+
 	data->psy_desc.name = "max8903_charger";
 	data->psy_desc.type = (data->ta_in) ? POWER_SUPPLY_TYPE_MAINS :
 			((data->usb_in) ? POWER_SUPPLY_TYPE_USB :
 			 POWER_SUPPLY_TYPE_BATTERY);
 	data->psy_desc.get_property = max8903_get_property;
+	data->psy_desc.set_property = max8903_set_property;
+	data->psy_desc.property_is_writeable = max8903_property_is_writeable;
 	data->psy_desc.properties = max8903_charger_props;
 	data->psy_desc.num_properties = ARRAY_SIZE(max8903_charger_props);
 
-- 
2.43.0

