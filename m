Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386B93932E2
	for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780251223; cv=none; b=mSla4E7FAXuQ2vBLvV9rKUhwH1lrOFWLKb5J304qI1sEDbNYTQkkJlHGnJVDFIUKEQuQkpB9py6fBmSHwOWPaV5MQaTEtvlmHQ+7ew/fITdpanNEmjH3ksJUkOfX7b482GtyyNGH+a+xKlGP7D/MV3k5h2/9sfQPf3BamyzCchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780251223; c=relaxed/simple;
	bh=sdJ+FYN+5u3FKoq0bsozzCIYAPQJjewWKODeLqMHW3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECICcTupKeRYmCZ3muxiigzcIWvl84lAeN3N68TYXaSnvyunox0XPCC+a9ERSt8na52YyDOCIPYQagdclhqduYKctljPXtiAjxgDrKSeVW5k6uMpYNL0tUcChAakhmeE6L5rZoV3Ssdx1Bl4jRuBhqg9pUX/mrCPyBfwTdL75BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPu3EMlk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPu3EMlk"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c274f362so2452615ad.0
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780251221; x=1780856021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zq+iuii3TV8UNuKcPAeXq3DMOEeF5c38TvhCpVD+Lxw=;
        b=XPu3EMlkWTtNvtwX2iBxdLf88yfpuLPmi4ky5b+v4kuIfmkytk9Es1iqkWHMgsOyvP
         GF5bh4sBKYxQkODsW7jLO8ecHP3964kMZlQXSkc5f0Rwd42yw01Bd90qPhdSTQxZnwQr
         JjxGYSLoYitlpoMvVAqrA58NAB0bUE+dqfUIf3x057SE9IkvXf75Fq4vAnOlosr4BZdp
         z6/rfS1ciTGP8GyXSWHGYCjxNKvqkborHpbcx+I3SjiKkcN1ptH+funLJXFk5LgsJdBr
         OihpdadKQUY44vkeOlKltXAO+mg3PsvGr5FVay2h1py8GaQezEm8xaLM4HWGxugcycW0
         PJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780251221; x=1780856021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zq+iuii3TV8UNuKcPAeXq3DMOEeF5c38TvhCpVD+Lxw=;
        b=YL+MusSIXpREQEOCQkqdqaVsQwNXeg4+eqB1+RhrfpTZA+4sucCTLD0U9EfMqZuT0G
         RiEGs1hrzsp8VuB6I1ICuAu6YsGiAqrpsvI4PN5v98EiebvqlomgLOu305gO8og6HlMh
         yMyBk8C+iCNBLUDW0FHtO3n9RjTcjoz9gkhMKPoH4pqfEqvGtIcmvHIdH/+bed5XlzTH
         tCHuHMnwlv07K7N3AmPiJw+ZqqAEAcOrY7hKttxqWJRUEmY6tVSmhTznaVSBjGrcA6/m
         fyYtuLncMJlztMYEKi8XMIFhdvrYsiJxLat6yv2sHHKVGnpy5Jg43QdkXqMG8VVxJ6xG
         NLJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+xkJ5opSmabpZ3OGMEERiTCL1p2jXToygeGTpI4V2lAlGo6noT6zn8JI5+DnSmKub4c36JJRE2oQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHCFjWJe3R2sM5Mt+CW5UzAk38xBRhxTxIXDSebLGwZCl/7NN
	OaIlt3Pr9KBMaSb3q0Es9k94XPCT5VuSVoj2llR+xSWdSXiLdEa+eir1
X-Gm-Gg: Acq92OGzg7S0W/LrNY7k1F6uOKz8NIC/nIkEZ9jw7MCPRwGLGUviGeZaD6NfaM5kKT2
	lHhu83eCblvGb4dPDbTrnVM4LbyhDZ9HY7ecRtzBihP6nlmErj5EqgetGm0HCwtpCg74663W9kT
	3R4BUPGFyhnwDT+cCqLF07H1i+Fk/0hYmB0w3EZRCJDOIc0EQDS6B/MEhtippGF0JCKFuu6f3IJ
	AuDdRgZYEW7uH0krJcaAPcyL9onPYYf6c1T0J+FMcwajAptBncV30NbFgvOTdsRALoPAqq3l5LB
	CV4PpOlCz8Kd2MDTjgK51E/45HVGIEfIGv8emHsTmS/nuyGLjeTB86wH9SONTOy1A6ZaMf0b/OG
	wiTw/3Y7uIfXNYY7clnUfNo3mmXat04oXW5RMq7Yjrln1U51woeX24LH1VW+foNMPHmiROdAX0E
	QQt+GF/8uZ/qT2v4r36RJKGKxYSDPaTi2PrsaDore6
X-Received: by 2002:a17:902:e54c:b0:2bd:c5fa:a78 with SMTP id d9443c01a7336-2bf3688a2cfmr53623945ad.8.1780251221261;
        Sun, 31 May 2026 11:13:41 -0700 (PDT)
Received: from magniquick ([2409:40f3:100e:de5:ae3b:b2d0:4f43:7ae])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c3f496sm83256775ad.76.2026.05.31.11.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:13:40 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: sre@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2] platform/x86: hp-wmi: Add charge behaviour support
Date: Sun, 31 May 2026 23:43:26 +0530
Message-ID: <20260531181326.1000801-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505200222.157144-1-navonjohnlukose@gmail.com>
References: <20260505200222.157144-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some HP laptops expose battery charge mode control through the existing
HP BIOS WMI GUID. On HP board 85C6, command types 0x1f and 0x2b map to
the ACPI GBCC/GBCO and SBCC/SBCO methods through the WMI command
dispatcher.

Expose the mode control through the standard power_supply
charge_behaviour property using a battery hook and power_supply
extension. The initial quirk is limited to board 85C6 and still
requires a successful charge mode read before registering the extension.

The firmware uses different commands for restoring auto mode and setting
explicit charge modes, so report the last successfully requested policy
after seeding it from firmware at probe time. The regular battery status
continues to report the live charging state.

Compile the battery hook support only when the ACPI battery driver is
reachable so non-battery hp-wmi configurations keep building.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
Changes in v2:
- Compile the battery hook integration only when ACPI battery support is
  reachable.
- Keep charge_behaviour as the last successfully requested policy.
- Use FIELD_PREP() for the write-mode field and document the readback values.
- Leave the ACPI battery header include unguarded and split compact return
  handling into explicit branches.
- Reject unknown GBCO readback values during setup instead of treating them as
  auto.

 drivers/platform/x86/hp/hp-wmi.c | 230 +++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index d1cc6e7d176c..66f409962cd9 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/compiler_attributes.h>
 #include <linux/dmi.h>
@@ -36,6 +37,8 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+#include <acpi/battery.h>
+
 MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
 MODULE_DESCRIPTION("HP laptop WMI driver");
 MODULE_LICENSE("GPL");
@@ -309,7 +312,9 @@ enum hp_wmi_commandtype {
 	HPWMI_HOTKEY_QUERY		= 0x0c,
 	HPWMI_FEATURE2_QUERY		= 0x0d,
 	HPWMI_WIRELESS2_QUERY		= 0x1b,
+	HPWMI_BATTERY_CHARGE_CONTROL	= 0x1f,
 	HPWMI_POSTCODEERROR_QUERY	= 0x2a,
+	HPWMI_BATTERY_CHARGE_MODE	= 0x2b,
 	HPWMI_SYSTEM_DEVICE_MODE	= 0x40,
 	HPWMI_THERMAL_PROFILE_QUERY	= 0x4c,
 };
@@ -378,6 +383,27 @@ enum hp_wireless2_bits {
 #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
 #define IS_SWBLOCKED(x) !(x & HPWMI_POWER_SOFT)
 
+#if IS_REACHABLE(CONFIG_ACPI_BATTERY)
+#define HPWMI_CHARGE_BEHAVIOURS \
+	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) | \
+	 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE) | \
+	 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE))
+
+/*
+ * SBCC/SBCO read the requested mode from the high byte of the input value.
+ * GBCO returns literal status values, not a bit mask.
+ */
+#define HPWMI_CHARGE_MODE_MASK			GENMASK(15, 8)
+#define HPWMI_CHARGE_MODE_AUTO			0x00
+#define HPWMI_CHARGE_MODE_FORCE_DISCHARGE	0x02
+#define HPWMI_CHARGE_MODE_INHIBIT		0x05
+
+#define HPWMI_CHARGE_MODE_READ_AUTO		0x00
+#define HPWMI_CHARGE_MODE_READ_FORCE_DISCHARGE	0x02
+#define HPWMI_CHARGE_MODE_READ_INHIBIT		0x04
+#define HPWMI_CHARGE_MODE_READ_INHIBIT_EXT	0x06
+#endif
+
 struct bios_rfkill2_device_state {
 	u8 radio_type;
 	u8 bus_type;
@@ -465,6 +491,18 @@ static const char * const tablet_chassis_types[] = {
 	"32"  /* Detachable */
 };
 
+#if IS_REACHABLE(CONFIG_ACPI_BATTERY)
+static const struct dmi_system_id hp_wmi_charge_control_quirks[] __initconst = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "85C6"),
+		},
+	},
+	{}
+};
+#endif
+
 #define DEVICE_MODE_TABLET	0x06
 
 #define CPU_FAN 0
@@ -694,6 +732,194 @@ static int hp_wmi_read_int(int query)
 	return val;
 }
 
+#if IS_REACHABLE(CONFIG_ACPI_BATTERY)
+static DEFINE_MUTEX(hp_wmi_charge_lock);
+static enum power_supply_charge_behaviour hp_wmi_charge_behaviour =
+	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+
+static int hp_wmi_charge_mode_to_behaviour(int mode,
+					   enum power_supply_charge_behaviour *behaviour)
+{
+	switch (mode) {
+	case HPWMI_CHARGE_MODE_READ_AUTO:
+		*behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+		return 0;
+	case HPWMI_CHARGE_MODE_READ_FORCE_DISCHARGE:
+		*behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
+		return 0;
+	case HPWMI_CHARGE_MODE_READ_INHIBIT:
+	case HPWMI_CHARGE_MODE_READ_INHIBIT_EXT:
+		*behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hp_wmi_charge_mode_read(void)
+{
+	int val = 0, ret;
+
+	ret = hp_wmi_perform_query(HPWMI_BATTERY_CHARGE_MODE, HPWMI_READ,
+				   &val, zero_if_sup(val), sizeof(val));
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		return -EINVAL;
+
+	return val & 0xff;
+}
+
+static int hp_wmi_charge_write(enum hp_wmi_commandtype query, u32 mode)
+{
+	int ret;
+
+	mode = FIELD_PREP(HPWMI_CHARGE_MODE_MASK, mode);
+	ret = hp_wmi_perform_query(query, HPWMI_WRITE, &mode, sizeof(mode), 0);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int hp_wmi_charge_set_behaviour(enum power_supply_charge_behaviour behaviour)
+{
+	int ret;
+
+	guard(mutex)(&hp_wmi_charge_lock);
+
+	/*
+	 * HP firmware exposes normal charging through the GBCC/SBCC command
+	 * pair, while explicit charge modes use the GBCO/SBCO command pair.
+	 */
+	switch (behaviour) {
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
+		ret = hp_wmi_charge_write(HPWMI_BATTERY_CHARGE_CONTROL,
+					  HPWMI_CHARGE_MODE_AUTO);
+		break;
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
+		ret = hp_wmi_charge_write(HPWMI_BATTERY_CHARGE_MODE,
+					  HPWMI_CHARGE_MODE_INHIBIT);
+		break;
+	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
+		ret = hp_wmi_charge_write(HPWMI_BATTERY_CHARGE_MODE,
+					  HPWMI_CHARGE_MODE_FORCE_DISCHARGE);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	/*
+	 * charge_behaviour is the requested policy. The live charging state is
+	 * still reported by the regular battery status property.
+	 */
+	hp_wmi_charge_behaviour = behaviour;
+
+	return 0;
+}
+
+static int hp_wmi_charge_get_property(struct power_supply *psy,
+				      const struct power_supply_ext *ext,
+				      void *data,
+				      enum power_supply_property psp,
+				      union power_supply_propval *val)
+{
+	if (psp != POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR)
+		return -EINVAL;
+
+	guard(mutex)(&hp_wmi_charge_lock);
+	val->intval = hp_wmi_charge_behaviour;
+
+	return 0;
+}
+
+static int hp_wmi_charge_set_property(struct power_supply *psy,
+				      const struct power_supply_ext *ext,
+				      void *data,
+				      enum power_supply_property psp,
+				      const union power_supply_propval *val)
+{
+	if (psp != POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR)
+		return -EINVAL;
+
+	return hp_wmi_charge_set_behaviour(val->intval);
+}
+
+static int hp_wmi_charge_property_is_writeable(struct power_supply *psy,
+					       const struct power_supply_ext *ext,
+					       void *data,
+					       enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR;
+}
+
+static const enum power_supply_property hp_wmi_charge_properties[] = {
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+};
+
+static const struct power_supply_ext hp_wmi_charge_extension = {
+	.name			= "hp-wmi-charge-control",
+	.properties		= hp_wmi_charge_properties,
+	.num_properties		= ARRAY_SIZE(hp_wmi_charge_properties),
+	.charge_behaviours	= HPWMI_CHARGE_BEHAVIOURS,
+	.get_property		= hp_wmi_charge_get_property,
+	.set_property		= hp_wmi_charge_set_property,
+	.property_is_writeable	= hp_wmi_charge_property_is_writeable,
+};
+
+static int hp_wmi_charge_add_battery(struct power_supply *battery,
+				     struct acpi_battery_hook *hook)
+{
+	return power_supply_register_extension(battery, &hp_wmi_charge_extension,
+					       &hp_wmi_platform_dev->dev, NULL);
+}
+
+static int hp_wmi_charge_remove_battery(struct power_supply *battery,
+					struct acpi_battery_hook *hook)
+{
+	power_supply_unregister_extension(battery, &hp_wmi_charge_extension);
+	return 0;
+}
+
+static struct acpi_battery_hook hp_wmi_charge_battery_hook = {
+	.name = "HP WMI charge control",
+	.add_battery = hp_wmi_charge_add_battery,
+	.remove_battery = hp_wmi_charge_remove_battery,
+};
+
+static int __init hp_wmi_charge_control_setup(struct device *dev)
+{
+	enum power_supply_charge_behaviour behaviour;
+	int ret;
+
+	if (!dmi_check_system(hp_wmi_charge_control_quirks))
+		return 0;
+
+	ret = hp_wmi_charge_mode_read();
+	if (ret < 0)
+		return 0;
+
+	ret = hp_wmi_charge_mode_to_behaviour(ret, &behaviour);
+	if (ret)
+		return 0;
+
+	scoped_guard(mutex, &hp_wmi_charge_lock)
+		hp_wmi_charge_behaviour = behaviour;
+
+	return devm_battery_hook_register(dev, &hp_wmi_charge_battery_hook);
+}
+#else
+static int __init hp_wmi_charge_control_setup(struct device *dev)
+{
+	return 0;
+}
+#endif
+
 static int hp_wmi_get_dock_state(void)
 {
 	int state = hp_wmi_read_int(HPWMI_HARDWARE_QUERY);
@@ -2284,6 +2510,10 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	if (err < 0)
 		return err;
 
+	err = hp_wmi_charge_control_setup(&device->dev);
+	if (err)
+		return err;
+
 	thermal_profile_setup(device);
 
 	return 0;
-- 
2.54.0
