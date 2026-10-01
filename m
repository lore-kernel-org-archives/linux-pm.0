Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF62BE65B;
	Thu,  1 Oct 2026 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.101.241.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814278; cv=none; b=sKU0rw/iFg8sb1Y574SPAlSZ4ikGybn/rHteIBnwCyHc5WJGqADOHT/NxUfh2Ya8u5OidRrdb+ISlqjCnju0CpEIdYsaNWZQ8vhaq/dSAataWNaMt+m+onuHtUyjZp2qHP108W9mnwO7mJKQBZELwV9NvCiREG2iCeVqnWYnIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814278; c=relaxed/simple;
	bh=00yGBWFbap8QVot+fNSGkXGAgc65xR2TNmIv1bOz3v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ/NEhGD22YgVwqQSBqlj3DzyPpuL2Zq1Lw+BLFB0Lc7h72B0lmZ0GIj7oJ0o4a32bjCD69xxJuJ+ezb8zQUBFjRh082xTrNQRneRCblF1/NvsJ7a4+ySd+MhmAPSeJhJ9gX+FW4HZvmapu1qThmaAsjDqmJ7rZP/5bc6BHGXO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net; spf=pass smtp.mailfrom=just42.net; arc=none smtp.client-ip=150.101.241.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.18.1/8.18.1) with ESMTPS id 6910LJnP001901
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 1 Oct 2026 09:51:21 +0930
Date: Thu, 1 Oct 2026 09:51:19 +0930
From: Jonathan Woithe <jwoithe@just42.net>
To: Jordan Brough <jordan@brough.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        Denis Benato <denis.benato@linux.dev>,
        Hans de Goede <hansg@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Antheas Kapenekakis <lkml@antheas.dev>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Armin Wolf <W_Armin@gmx.de>, Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Ike Panhc <ikepanhc@gmail.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Matan Ziv-Av <matan@svgalib.org>, Nikita Kravets <teackot@gmail.com>,
        =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        Joshua Grisham <josh@joshuagrisham.com>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ibm-acpi-devel@lists.sourceforge.net, chrome-platform@lists.linux.dev,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ACPI: battery: add acpi_ prefix to the battery
 hook API
Message-ID: <ar2nf4od0AJjUnLD@marvin.atrad.com.au>
References: <20260930222650.1883805-1-jordan@brough.org>
 <20260930222650.1883805-2-jordan@brough.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930222650.1883805-2-jordan@brough.org>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Wed, Sep 30, 2026 at 04:26:33PM -0600, Jordan Brough wrote:
> Rename battery_hook_register(), battery_hook_unregister() and
> devm_battery_hook_register() to acpi_battery_hook_register(),
> acpi_battery_hook_unregister() and devm_acpi_battery_hook_register(), so
> that the exported ACPI battery hook API has a consistent namespace, and
> update all in-tree callers.
> 
> No functional change.

For the fujitsu-laptop changes:

    Signed-off-by: Jonathan Woithe <jwoithe@just42.net>


> Signed-off-by: Jordan Brough <jordan@brough.org>
> ---
>  drivers/acpi/battery.c                       | 30 ++++++++++----------
>  drivers/platform/x86/asus-wmi.c              |  4 +--
>  drivers/platform/x86/ayaneo-ec.c             |  2 +-
>  drivers/platform/x86/dell/dell-laptop.c      |  4 +--
>  drivers/platform/x86/dell/dell-wmi-ddv.c     |  2 +-
>  drivers/platform/x86/fujitsu-laptop.c        |  4 +--
>  drivers/platform/x86/huawei-wmi.c            |  4 +--
>  drivers/platform/x86/lenovo/ideapad-laptop.c |  4 +--
>  drivers/platform/x86/lenovo/thinkpad_acpi.c  |  4 +--
>  drivers/platform/x86/lenovo/wmi-other.c      |  4 +--
>  drivers/platform/x86/lg-laptop.c             |  4 +--
>  drivers/platform/x86/msi-ec.c                |  4 +--
>  drivers/platform/x86/oxpec.c                 |  2 +-
>  drivers/platform/x86/samsung-galaxybook.c    |  3 +-
>  drivers/platform/x86/samsung-laptop.c        |  4 +--
>  drivers/platform/x86/system76_acpi.c         |  4 +--
>  drivers/platform/x86/toshiba_acpi.c          |  4 +--
>  drivers/platform/x86/uniwill/uniwill-acpi.c  |  2 +-
>  drivers/power/supply/cros_charge-control.c   |  2 +-
>  include/acpi/battery.h                       |  7 +++--
>  20 files changed, 50 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 8599949f8786..306bb2088ca6 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -821,7 +821,7 @@ static LIST_HEAD(acpi_battery_list);
>  static LIST_HEAD(battery_hook_list);
>  static DEFINE_MUTEX(hook_mutex);
>  
> -static void battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
> +static void acpi_battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
>  {
>  	struct acpi_battery *battery;
>  
> @@ -838,7 +838,7 @@ static void battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
>  	pr_info("hook unregistered: %s\n", hook->name);
>  }
>  
> -void battery_hook_unregister(struct acpi_battery_hook *hook)
> +void acpi_battery_hook_unregister(struct acpi_battery_hook *hook)
>  {
>  	mutex_lock(&hook_mutex);
>  	/*
> @@ -847,13 +847,13 @@ void battery_hook_unregister(struct acpi_battery_hook *hook)
>  	 * adding a new battery.
>  	 */
>  	if (!list_empty(&hook->list))
> -		battery_hook_unregister_unlocked(hook);
> +		acpi_battery_hook_unregister_unlocked(hook);
>  
>  	mutex_unlock(&hook_mutex);
>  }
> -EXPORT_SYMBOL_GPL(battery_hook_unregister);
> +EXPORT_SYMBOL_GPL(acpi_battery_hook_unregister);
>  
> -void battery_hook_register(struct acpi_battery_hook *hook)
> +void acpi_battery_hook_register(struct acpi_battery_hook *hook)
>  {
>  	struct acpi_battery *battery;
>  
> @@ -874,7 +874,7 @@ void battery_hook_register(struct acpi_battery_hook *hook)
>  			 * hooks.
>  			 */
>  			pr_err("hook failed to load: %s", hook->name);
> -			battery_hook_unregister_unlocked(hook);
> +			acpi_battery_hook_unregister_unlocked(hook);
>  			goto end;
>  		}
>  
> @@ -884,22 +884,22 @@ void battery_hook_register(struct acpi_battery_hook *hook)
>  end:
>  	mutex_unlock(&hook_mutex);
>  }
> -EXPORT_SYMBOL_GPL(battery_hook_register);
> +EXPORT_SYMBOL_GPL(acpi_battery_hook_register);
>  
> -static void devm_battery_hook_unregister(void *data)
> +static void devm_acpi_battery_hook_unregister(void *data)
>  {
>  	struct acpi_battery_hook *hook = data;
>  
> -	battery_hook_unregister(hook);
> +	acpi_battery_hook_unregister(hook);
>  }
>  
> -int devm_battery_hook_register(struct device *dev, struct acpi_battery_hook *hook)
> +int devm_acpi_battery_hook_register(struct device *dev, struct acpi_battery_hook *hook)
>  {
> -	battery_hook_register(hook);
> +	acpi_battery_hook_register(hook);
>  
> -	return devm_add_action_or_reset(dev, devm_battery_hook_unregister, hook);
> +	return devm_add_action_or_reset(dev, devm_acpi_battery_hook_unregister, hook);
>  }
> -EXPORT_SYMBOL_GPL(devm_battery_hook_register);
> +EXPORT_SYMBOL_GPL(devm_acpi_battery_hook_register);
>  
>  /*
>   * This function gets called right after the battery sysfs
> @@ -928,7 +928,7 @@ static void battery_hook_add_battery(struct acpi_battery *battery)
>  			 */
>  			pr_err("error in hook, unloading: %s",
>  					hook_node->name);
> -			battery_hook_unregister_unlocked(hook_node);
> +			acpi_battery_hook_unregister_unlocked(hook_node);
>  		}
>  	}
>  	mutex_unlock(&hook_mutex);
> @@ -961,7 +961,7 @@ static void __exit battery_hook_exit(void)
>  	 * need to remove the hooks.
>  	 */
>  	list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
> -		battery_hook_unregister(hook);
> +		acpi_battery_hook_unregister(hook);
>  	}
>  	mutex_destroy(&hook_mutex);
>  }
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index a65090429ca7..c274f456863c 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1681,14 +1681,14 @@ static void asus_wmi_battery_init(struct asus_wmi *asus)
>  	asus->battery_rsoc_available = false;
>  	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_RSOC)) {
>  		asus->battery_rsoc_available = true;
> -		battery_hook_register(&battery_hook);
> +		acpi_battery_hook_register(&battery_hook);
>  	}
>  }
>  
>  static void asus_wmi_battery_exit(struct asus_wmi *asus)
>  {
>  	if (asus->battery_rsoc_available)
> -		battery_hook_unregister(&battery_hook);
> +		acpi_battery_hook_unregister(&battery_hook);
>  }
>  
>  /* LEDs ***********************************************************************/
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> index 41a24e091248..3ba87bd16c9a 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -493,7 +493,7 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
>  		data->battery_hook.add_battery = ayaneo_add_battery;
>  		data->battery_hook.remove_battery = ayaneo_remove_battery;
>  		data->battery_hook.name = "Ayaneo Battery";
> -		ret = devm_battery_hook_register(&pdev->dev, &data->battery_hook);
> +		ret = devm_acpi_battery_hook_register(&pdev->dev, &data->battery_hook);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 89e85c7f7132..cad2bd06f28a 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -2446,13 +2446,13 @@ static void __init dell_battery_init(struct device *dev)
>  	battery_supported_modes = battery_get_supported_modes();
>  
>  	if (battery_supported_modes != 0)
> -		battery_hook_register(&dell_battery_hook);
> +		acpi_battery_hook_register(&dell_battery_hook);
>  }
>  
>  static void dell_battery_exit(void)
>  {
>  	if (battery_supported_modes != 0)
> -		battery_hook_unregister(&dell_battery_hook);
> +		acpi_battery_hook_unregister(&dell_battery_hook);
>  }
>  
>  static int __init dell_init(void)
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index f8903ced461b..6f0504d7519e 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -972,7 +972,7 @@ static int dell_wmi_ddv_battery_add(struct dell_wmi_ddv_data *data)
>  	data->eppid_attr.attr.mode = 0444;
>  	data->eppid_attr.show = eppid_show;
>  
> -	return devm_battery_hook_register(&data->wdev->dev, &data->hook);
> +	return devm_acpi_battery_hook_register(&data->wdev->dev, &data->hook);
>  }
>  
>  static int dell_wmi_ddv_buffer_read(struct seq_file *seq, enum dell_ddv_method method)
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index ea543deef68f..96e74c4fdb29 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -267,7 +267,7 @@ static int fujitsu_battery_charge_control_add(struct device *dev)
>  		return -ENODEV;
>  
>  	priv->charge_control_supported = true;
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
>  
>  	return 0;
>  }
> @@ -277,7 +277,7 @@ static void fujitsu_battery_charge_control_remove(struct device *dev)
>  	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
>  
>  	if (priv->charge_control_supported)
> -		battery_hook_unregister(&battery_hook);
> +		acpi_battery_hook_unregister(&battery_hook);
>  }
>  
>  /* Hardware access for LCD brightness control */
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
> index d6aaf14d66a5..8cc0e900e984 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -512,7 +512,7 @@ static void huawei_wmi_battery_setup(struct device *dev)
>  		return;
>  	}
>  
> -	battery_hook_register(&huawei_wmi_battery_hook);
> +	acpi_battery_hook_register(&huawei_wmi_battery_hook);
>  	device_create_file(dev, &dev_attr_charge_control_thresholds);
>  }
>  
> @@ -521,7 +521,7 @@ static void huawei_wmi_battery_exit(struct device *dev)
>  	struct huawei_wmi *huawei = dev_get_drvdata(dev);
>  
>  	if (huawei->battery_available) {
> -		battery_hook_unregister(&huawei_wmi_battery_hook);
> +		acpi_battery_hook_unregister(&huawei_wmi_battery_hook);
>  		device_remove_file(dev, &dev_attr_charge_control_thresholds);
>  	}
>  }
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
> index 8213524504ee..1d90d4591641 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -2197,8 +2197,8 @@ static int ideapad_check_features(struct ideapad_private *priv)
>  			priv->battery_hook.remove_battery = ideapad_battery_remove;
>  			priv->battery_hook.name = "Ideapad Battery Extension";
>  
> -			err = devm_battery_hook_register(&priv->platform_device->dev,
> -							 &priv->battery_hook);
> +			err = devm_acpi_battery_hook_register(&priv->platform_device->dev,
> +							      &priv->battery_hook);
>  			if (err)
>  				return err;
>  		}
> diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> index 1661f070c571..eb5ad18855db 100644
> --- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
> +++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> @@ -10021,13 +10021,13 @@ static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
>  					battery_quirk_table,
>  					ARRAY_SIZE(battery_quirk_table));
>  
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
>  	return 0;
>  }
>  
>  static void tpacpi_battery_exit(void)
>  {
> -	battery_hook_unregister(&battery_hook);
> +	acpi_battery_hook_unregister(&battery_hook);
>  }
>  
>  static struct ibm_struct battery_driver_data = {
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
> index fbb32bf404f2..0450634ac1dd 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -946,7 +946,7 @@ static void lwmi_om_psy_ext_init(struct lwmi_om_priv *priv)
>  	priv->battery_hook.name = "Lenovo WMI Other Battery Extension";
>  	priv->bh_registered = true;
>  
> -	battery_hook_register(&priv->battery_hook);
> +	acpi_battery_hook_register(&priv->battery_hook);
>  }
>  
>  /**
> @@ -960,7 +960,7 @@ static void lwmi_om_psy_remove(struct lwmi_om_priv *priv)
>  	if (!priv->bh_registered)
>  		return;
>  
> -	battery_hook_unregister(&priv->battery_hook);
> +	acpi_battery_hook_unregister(&priv->battery_hook);
>  	priv->bh_registered = false;
>  }
>  
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
> index 36ad1e269443..e788671307c4 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -1053,7 +1053,7 @@ static int acpi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_platform_device;
>  
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
>  
>  	return 0;
>  
> @@ -1068,7 +1068,7 @@ static void acpi_remove(struct platform_device *pdev)
>  {
>  	sysfs_remove_group(&pf_device->dev.kobj, &dev_attribute_group);
>  
> -	battery_hook_unregister(&battery_hook);
> +	acpi_battery_hook_unregister(&battery_hook);
>  	platform_device_unregister(pf_device);
>  	pf_device = NULL;
>  	platform_driver_unregister(&pf_driver);
> diff --git a/drivers/platform/x86/msi-ec.c b/drivers/platform/x86/msi-ec.c
> index 566dfc73cb67..cb30a1d5b546 100644
> --- a/drivers/platform/x86/msi-ec.c
> +++ b/drivers/platform/x86/msi-ec.c
> @@ -1428,13 +1428,13 @@ static int __init msi_ec_init(void)
>  	if (result < 0)
>  		return result;
>  
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
>  	return 0;
>  }
>  
>  static void __exit msi_ec_exit(void)
>  {
> -	battery_hook_unregister(&battery_hook);
> +	acpi_battery_hook_unregister(&battery_hook);
>  }
>  
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 34bb17fca148..318f194e72b5 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -956,7 +956,7 @@ static int oxp_platform_probe(struct platform_device *pdev)
>  		return PTR_ERR(hwdev);
>  
>  	if (oxp_psy_ext_supported()) {
> -		ret = devm_battery_hook_register(dev, &battery_hook);
> +		ret = devm_acpi_battery_hook_register(dev, &battery_hook);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform/x86/samsung-galaxybook.c
> index 99f72b204a51..a4f7dbb76214 100644
> --- a/drivers/platform/x86/samsung-galaxybook.c
> +++ b/drivers/platform/x86/samsung-galaxybook.c
> @@ -549,7 +549,8 @@ static int galaxybook_battery_threshold_init(struct samsung_galaxybook *galaxybo
>  	galaxybook->battery_hook.remove_battery = galaxybook_battery_remove;
>  	galaxybook->battery_hook.name = "Samsung Galaxy Book Battery Extension";
>  
> -	return devm_battery_hook_register(&galaxybook->platform->dev, &galaxybook->battery_hook);
> +	return devm_acpi_battery_hook_register(&galaxybook->platform->dev,
> +					       &galaxybook->battery_hook);
>  }
>  
>  /*
> diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
> index 710f3d5bf84c..43fa1dc2773c 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -1142,8 +1142,8 @@ static int __init samsung_battery_hook_init(struct samsung_laptop *samsung)
>  		samsung->battery_hook.add_battery = samsung_battery_add;
>  		samsung->battery_hook.remove_battery = samsung_battery_remove;
>  		samsung->battery_hook.name = "Samsung Battery Extension";
> -		retval = devm_battery_hook_register(&samsung->platform_device->dev,
> -						    &samsung->battery_hook);
> +		retval = devm_acpi_battery_hook_register(&samsung->platform_device->dev,
> +							 &samsung->battery_hook);
>  	}
>  
>  	return retval;
> diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
> index dd7b1b07c316..33968b61f0b2 100644
> --- a/drivers/platform/x86/system76_acpi.c
> +++ b/drivers/platform/x86/system76_acpi.c
> @@ -288,12 +288,12 @@ static struct acpi_battery_hook system76_battery_hook = {
>  
>  static void system76_battery_init(void)
>  {
> -	battery_hook_register(&system76_battery_hook);
> +	acpi_battery_hook_register(&system76_battery_hook);
>  }
>  
>  static void system76_battery_exit(void)
>  {
> -	battery_hook_unregister(&system76_battery_hook);
> +	acpi_battery_hook_unregister(&system76_battery_hook);
>  }
>  
>  // Get the airplane mode LED brightness
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index a0b8060836d0..4cc879bc267a 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -3301,7 +3301,7 @@ static void toshiba_acpi_remove(struct platform_device *pdev)
>  	}
>  
>  	if (dev->battery_charge_mode_supported)
> -		battery_hook_unregister(&battery_hook);
> +		acpi_battery_hook_unregister(&battery_hook);
>  
>  	if (toshiba_acpi)
>  		toshiba_acpi = NULL;
> @@ -3566,7 +3566,7 @@ static int toshiba_acpi_probe(struct platform_device *pdev)
>  	 * set, this must be done after toshiba_acpi is assigned.
>  	 */
>  	if (dev->battery_charge_mode_supported)
> -		battery_hook_register(&battery_hook);
> +		acpi_battery_hook_register(&battery_hook);
>  
>  	return 0;
>  
> diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platform/x86/uniwill/uniwill-acpi.c
> index 7a2eeaec4c96..d76695c2c765 100644
> --- a/drivers/platform/x86/uniwill/uniwill-acpi.c
> +++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
> @@ -2165,7 +2165,7 @@ static int uniwill_battery_init(struct uniwill_data *data)
>  	data->hook.add_battery = uniwill_add_battery;
>  	data->hook.remove_battery = uniwill_remove_battery;
>  
> -	return devm_battery_hook_register(data->dev, &data->hook);
> +	return devm_acpi_battery_hook_register(data->dev, &data->hook);
>  }
>  
>  static int uniwill_notifier_call(struct notifier_block *nb, unsigned long action, void *dummy)
> diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
> index e0f168624807..1901bbcffd73 100644
> --- a/drivers/power/supply/cros_charge-control.c
> +++ b/drivers/power/supply/cros_charge-control.c
> @@ -315,7 +315,7 @@ static int cros_chctl_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	return devm_battery_hook_register(dev, &priv->battery_hook);
> +	return devm_acpi_battery_hook_register(dev, &priv->battery_hook);
>  }
>  
>  static const struct platform_device_id cros_chctl_id[] = {
> diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> index c93f16dfb944..08c7e37996bf 100644
> --- a/include/acpi/battery.h
> +++ b/include/acpi/battery.h
> @@ -18,8 +18,9 @@ struct acpi_battery_hook {
>  	struct list_head list;
>  };
>  
> -void battery_hook_register(struct acpi_battery_hook *hook);
> -void battery_hook_unregister(struct acpi_battery_hook *hook);
> -int devm_battery_hook_register(struct device *dev, struct acpi_battery_hook *hook);
> +void acpi_battery_hook_register(struct acpi_battery_hook *hook);
> +void acpi_battery_hook_unregister(struct acpi_battery_hook *hook);
> +int devm_acpi_battery_hook_register(struct device *dev,
> +				    struct acpi_battery_hook *hook);
>  
>  #endif
> -- 
> 2.56.0

-- 
