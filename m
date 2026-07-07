Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5B3F88BA;
	Tue,  7 Jul 2026 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429589; cv=none; b=dXRXCOE326+XMRdNVmx2IZHqTi/BnT6fsMNq08ICqZ+HU7vpcy40u8KAofsOwevPI3YmCTMrNzGu4nvJ03BcJNCWOav4sdlhboGbuZqB/2pVT++WhFdV/kLol27Q3tIWQTO5EJ8/UB1uVsY4Iegn6GtmluuglVwSXxtCJJmFG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429589; c=relaxed/simple;
	bh=s9KsTzIpIujJFX/x/AbpZFDJ5Gix2qeUb1AgpHtXbIY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KCCCfvWnv2EMBheX70U6Qn1GFUx411ZZTnE/JbENPAU/81lvhhKjpGp3gFsk5bn2f0zggAd5vNhlS/mCNvlDlNGnrmB26OGUdxFmh4NkLvHjothLlHOJPsnhSRE6VN64XofZw93skbgarpWFozj2+czCpBC+NWGaMA9/gWqb2Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxHTCQD+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxHTCQD+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783429588; x=1814965588;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=s9KsTzIpIujJFX/x/AbpZFDJ5Gix2qeUb1AgpHtXbIY=;
  b=QxHTCQD+llXvWHsDrYxU5inzONzowM4Jqpyxny4EDVApJRiMUlD+G+C5
   M2Y2SpPhVqKCJz4vQ20REdo8vwM0fkKG3xjqoyPpiFe9fXXfxWUsqjrL6
   cScNGv/PJKnJHIg4Trw1leffc65QXnJKKKHkGE55PmF3IXsju27G6cqnr
   gxFMmfD4AvnEwrN+b4tG5BAXTe9Xe2UZTGLvS/7cFWqHP/m4GwlWUv13f
   +YJtVFRBQiGamSy2hKjunWXDeFEJCyV6TTESHWX8DKaAFlBJWNqM3FFy0
   dgEbqK/gGWzYJKBGK/3r1dH0Y9/vG4bD0KAwDgYKMcF2Dpr5x5PVXA4+c
   Q==;
X-CSE-ConnectionGUID: H7lzYX68SqiAiMXcgM1jZA==
X-CSE-MsgGUID: ElTQ4wXoR/ajmfo+1CCxAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84166167"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84166167"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:06:28 -0700
X-CSE-ConnectionGUID: jzXLdH8ZRN2lG3unjbhLyA==
X-CSE-MsgGUID: aWF8I8c8RNmktsmDqVn2Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="255920709"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.226])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:06:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Jul 2026 16:06:21 +0300 (EEST)
To: Navon John Lukose <navonjohnlukose@gmail.com>
cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com, sre@kernel.org, 
    platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] platform/x86: hp-wmi: Add charge behaviour
 support
In-Reply-To: <20260531181326.1000801-1-navonjohnlukose@gmail.com>
Message-ID: <edbe584a-c241-c3e6-9993-2783934885d9@linux.intel.com>
References: <20260505200222.157144-1-navonjohnlukose@gmail.com> <20260531181326.1000801-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 31 May 2026, Navon John Lukose wrote:

> Some HP laptops expose battery charge mode control through the existing
> HP BIOS WMI GUID. On HP board 85C6, command types 0x1f and 0x2b map to
> the ACPI GBCC/GBCO and SBCC/SBCO methods through the WMI command
> dispatcher.
> 
> Expose the mode control through the standard power_supply
> charge_behaviour property using a battery hook and power_supply
> extension. The initial quirk is limited to board 85C6 and still
> requires a successful charge mode read before registering the extension.
> 
> The firmware uses different commands for restoring auto mode and setting
> explicit charge modes, so report the last successfully requested policy
> after seeding it from firmware at probe time. The regular battery status
> continues to report the live charging state.
> 
> Compile the battery hook support only when the ACPI battery driver is
> reachable so non-battery hp-wmi configurations keep building.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
> ---
> Changes in v2:
> - Compile the battery hook integration only when ACPI battery support is
>   reachable.
> - Keep charge_behaviour as the last successfully requested policy.
> - Use FIELD_PREP() for the write-mode field and document the readback values.
> - Leave the ACPI battery header include unguarded and split compact return
>   handling into explicit branches.
> - Reject unknown GBCO readback values during setup instead of treating them as
>   auto.

Why is this marked as RFC?

>  drivers/platform/x86/hp/hp-wmi.c | 230 +++++++++++++++++++++++++++++++
>  1 file changed, 230 insertions(+)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index d1cc6e7d176c..66f409962cd9 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -14,6 +14,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/acpi.h>
> +#include <linux/bitfield.h>
>  #include <linux/cleanup.h>
>  #include <linux/compiler_attributes.h>
>  #include <linux/dmi.h>
> @@ -36,6 +37,8 @@
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>  
> +#include <acpi/battery.h>
> +
>  MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
>  MODULE_DESCRIPTION("HP laptop WMI driver");
>  MODULE_LICENSE("GPL");
> @@ -309,7 +312,9 @@ enum hp_wmi_commandtype {
>  	HPWMI_HOTKEY_QUERY		= 0x0c,
>  	HPWMI_FEATURE2_QUERY		= 0x0d,
>  	HPWMI_WIRELESS2_QUERY		= 0x1b,
> +	HPWMI_BATTERY_CHARGE_CONTROL	= 0x1f,
>  	HPWMI_POSTCODEERROR_QUERY	= 0x2a,
> +	HPWMI_BATTERY_CHARGE_MODE	= 0x2b,
>  	HPWMI_SYSTEM_DEVICE_MODE	= 0x40,
>  	HPWMI_THERMAL_PROFILE_QUERY	= 0x4c,
>  };
> @@ -378,6 +383,27 @@ enum hp_wireless2_bits {
>  #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) != HPWMI_POWER_FW_OR_HW)
>  #define IS_SWBLOCKED(x) !(x & HPWMI_POWER_SOFT)
>  
> +#if IS_REACHABLE(CONFIG_ACPI_BATTERY)
> +#define HPWMI_CHARGE_BEHAVIOURS \
> +	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) | \
> +	 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE) | \
> +	 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE))
> +
> +/*
> + * SBCC/SBCO read the requested mode from the high byte of the input value.
> + * GBCO returns literal status values, not a bit mask.
> + */
> +#define HPWMI_CHARGE_MODE_MASK			GENMASK(15, 8)
> +#define HPWMI_CHARGE_MODE_AUTO			0x00
> +#define HPWMI_CHARGE_MODE_FORCE_DISCHARGE	0x02
> +#define HPWMI_CHARGE_MODE_INHIBIT		0x05
> +
> +#define HPWMI_CHARGE_MODE_READ_AUTO		0x00
> +#define HPWMI_CHARGE_MODE_READ_FORCE_DISCHARGE	0x02
> +#define HPWMI_CHARGE_MODE_READ_INHIBIT		0x04
> +#define HPWMI_CHARGE_MODE_READ_INHIBIT_EXT	0x06
> +#endif
> +
>  struct bios_rfkill2_device_state {
>  	u8 radio_type;
>  	u8 bus_type;
> @@ -465,6 +491,18 @@ static const char * const tablet_chassis_types[] = {
>  	"32"  /* Detachable */
>  };
>  
> +#if IS_REACHABLE(CONFIG_ACPI_BATTERY)
> +static const struct dmi_system_id hp_wmi_charge_control_quirks[] __initconst = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
> +			DMI_MATCH(DMI_BOARD_NAME, "85C6"),
> +		},
> +	},
> +	{}
> +};
> +#endif
> +
>  #define DEVICE_MODE_TABLET	0x06
>  
>  #define CPU_FAN 0
> @@ -694,6 +732,194 @@ static int hp_wmi_read_int(int query)
>  	return val;
>  }
>  
> +#if IS_REACHABLE(CONFIG_ACPI_BATTERY)
> +static DEFINE_MUTEX(hp_wmi_charge_lock);

Please always add a comment telling what is protected by a lock.

> +static enum power_supply_charge_behaviour hp_wmi_charge_behaviour =
> +	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +
> +static int hp_wmi_charge_mode_to_behaviour(int mode,
> +					   enum power_supply_charge_behaviour *behaviour)
> +{
> +	switch (mode) {
> +	case HPWMI_CHARGE_MODE_READ_AUTO:
> +		*behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +		return 0;
> +	case HPWMI_CHARGE_MODE_READ_FORCE_DISCHARGE:
> +		*behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
> +		return 0;
> +	case HPWMI_CHARGE_MODE_READ_INHIBIT:
> +	case HPWMI_CHARGE_MODE_READ_INHIBIT_EXT:
> +		*behaviour = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int hp_wmi_charge_mode_read(void)
> +{
> +	int val = 0, ret;
> +
> +	ret = hp_wmi_perform_query(HPWMI_BATTERY_CHARGE_MODE, HPWMI_READ,
> +				   &val, zero_if_sup(val), sizeof(val));
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		return -EINVAL;
> +
> +	return val & 0xff;
> +}
> +
> +static int hp_wmi_charge_write(enum hp_wmi_commandtype query, u32 mode)
> +{
> +	int ret;
> +
> +	mode = FIELD_PREP(HPWMI_CHARGE_MODE_MASK, mode);
> +	ret = hp_wmi_perform_query(query, HPWMI_WRITE, &mode, sizeof(mode), 0);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int hp_wmi_charge_set_behaviour(enum power_supply_charge_behaviour behaviour)
> +{
> +	int ret;
> +
> +	guard(mutex)(&hp_wmi_charge_lock);
> +
> +	/*
> +	 * HP firmware exposes normal charging through the GBCC/SBCC command
> +	 * pair, while explicit charge modes use the GBCO/SBCO command pair.
> +	 */
> +	switch (behaviour) {
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> +		ret = hp_wmi_charge_write(HPWMI_BATTERY_CHARGE_CONTROL,
> +					  HPWMI_CHARGE_MODE_AUTO);
> +		break;
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> +		ret = hp_wmi_charge_write(HPWMI_BATTERY_CHARGE_MODE,
> +					  HPWMI_CHARGE_MODE_INHIBIT);
> +		break;
> +	case POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE:
> +		ret = hp_wmi_charge_write(HPWMI_BATTERY_CHARGE_MODE,
> +					  HPWMI_CHARGE_MODE_FORCE_DISCHARGE);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * charge_behaviour is the requested policy. The live charging state is
> +	 * still reported by the regular battery status property.
> +	 */
> +	hp_wmi_charge_behaviour = behaviour;
> +
> +	return 0;
> +}
> +
> +static int hp_wmi_charge_get_property(struct power_supply *psy,
> +				      const struct power_supply_ext *ext,
> +				      void *data,
> +				      enum power_supply_property psp,
> +				      union power_supply_propval *val)
> +{
> +	if (psp != POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR)
> +		return -EINVAL;
> +
> +	guard(mutex)(&hp_wmi_charge_lock);
> +	val->intval = hp_wmi_charge_behaviour;
> +
> +	return 0;
> +}
> +
> +static int hp_wmi_charge_set_property(struct power_supply *psy,
> +				      const struct power_supply_ext *ext,
> +				      void *data,
> +				      enum power_supply_property psp,
> +				      const union power_supply_propval *val)
> +{
> +	if (psp != POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR)
> +		return -EINVAL;
> +
> +	return hp_wmi_charge_set_behaviour(val->intval);
> +}
> +
> +static int hp_wmi_charge_property_is_writeable(struct power_supply *psy,
> +					       const struct power_supply_ext *ext,
> +					       void *data,
> +					       enum power_supply_property psp)
> +{
> +	return psp == POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR;
> +}
> +
> +static const enum power_supply_property hp_wmi_charge_properties[] = {
> +	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +};
> +
> +static const struct power_supply_ext hp_wmi_charge_extension = {
> +	.name			= "hp-wmi-charge-control",
> +	.properties		= hp_wmi_charge_properties,
> +	.num_properties		= ARRAY_SIZE(hp_wmi_charge_properties),
> +	.charge_behaviours	= HPWMI_CHARGE_BEHAVIOURS,
> +	.get_property		= hp_wmi_charge_get_property,
> +	.set_property		= hp_wmi_charge_set_property,
> +	.property_is_writeable	= hp_wmi_charge_property_is_writeable,
> +};
> +
> +static int hp_wmi_charge_add_battery(struct power_supply *battery,
> +				     struct acpi_battery_hook *hook)
> +{
> +	return power_supply_register_extension(battery, &hp_wmi_charge_extension,
> +					       &hp_wmi_platform_dev->dev, NULL);
> +}
> +
> +static int hp_wmi_charge_remove_battery(struct power_supply *battery,
> +					struct acpi_battery_hook *hook)
> +{
> +	power_supply_unregister_extension(battery, &hp_wmi_charge_extension);
> +	return 0;
> +}
> +
> +static struct acpi_battery_hook hp_wmi_charge_battery_hook = {
> +	.name = "HP WMI charge control",
> +	.add_battery = hp_wmi_charge_add_battery,
> +	.remove_battery = hp_wmi_charge_remove_battery,
> +};
> +
> +static int __init hp_wmi_charge_control_setup(struct device *dev)
> +{
> +	enum power_supply_charge_behaviour behaviour;
> +	int ret;
> +
> +	if (!dmi_check_system(hp_wmi_charge_control_quirks))
> +		return 0;
> +
> +	ret = hp_wmi_charge_mode_read();
> +	if (ret < 0)
> +		return 0;
> +
> +	ret = hp_wmi_charge_mode_to_behaviour(ret, &behaviour);
> +	if (ret)
> +		return 0;
> +
> +	scoped_guard(mutex, &hp_wmi_charge_lock)
> +		hp_wmi_charge_behaviour = behaviour;
> +
> +	return devm_battery_hook_register(dev, &hp_wmi_charge_battery_hook);
> +}
> +#else
> +static int __init hp_wmi_charge_control_setup(struct device *dev)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int hp_wmi_get_dock_state(void)
>  {
>  	int state = hp_wmi_read_int(HPWMI_HARDWARE_QUERY);
> @@ -2284,6 +2510,10 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>  	if (err < 0)
>  		return err;
>  
> +	err = hp_wmi_charge_control_setup(&device->dev);
> +	if (err)
> +		return err;
> +
>  	thermal_profile_setup(device);
>  
>  	return 0;
> 

-- 
 i.

