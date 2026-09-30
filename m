Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A403489FDE;
	Wed, 30 Sep 2026 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810394; cv=none; b=HD6Ll8XjVISoGnQL9rfDos/FQkHA0BtjPnWiFYwduN7S640YgMWOQOaWMhfJRpkVH0dR/AuIYUZBU2i5ONxRp+SlaDWBmhUaZWohdgWdJ4fNJmq4qSvNYBjWPaj2McW6dq1nMmsLxztfedDpSF5b6jPZukQjfZV8hXRdnEvwySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810394; c=relaxed/simple;
	bh=ADL0Pr0IuKzZeqDqThrl6I1h88eD+o111rjUhElCT2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmUQ8mz6Zhuv6zWRu7vtXTRXDb1DlcQi6E8DjSz45ssZ8PLEjyoNdXMsH3DBQ1u7oq41G+ESFwx6OnviyS/VeIsr1SNiLEoE5wQ3ck+f4J6NTrQXqneTAaR9QeFId9a33iBsw6xdJvfdxyHk+1U9Lm3xS6VZr6OHMHgeSH4AdqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Ju76v2SI; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Ju76v2SI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790810369; x=1791415169; i=w_armin@gmx.de;
	bh=u3/TidS+m2hRJZgnZUlFlI9i5e1Cb1OYgYvPqdqg6pU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ju76v2SIoglZOoBWoH6fQWrOLPx24CW4+YhewKCUXSKpErNnY0H4u3fm0Xpdeucb
	 dV0JBzYAhHiQTJX/20+Sf7Dhp5r01mpF9AYjj+w3vwz97kKTx0Jhw8ZJUmKCwFBAs
	 NJjRcOeN3gtv0KA5HZ3UEbJ4FTc4cqMQ0VC/WRaP4i85FpO5M/910uDk/fdi3BPfm
	 b+3FdIf7ptIsYIS/XM+vpTKZT3J0P0lzEScSQMSEret4AkD4vXZb6hYPT62sqkyQg
	 p4ZE1IWLugkDPrGQ29QL1C6pV0s1PzzfJ/2qMFG7J4IjlBr5ZQONyB3mq/ngCWjgA
	 rDsGL/05Fqjmy43WfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUnK-1wuwTK36W2-012fZA; Thu, 01
 Oct 2026 01:19:29 +0200
Message-ID: <e410c995-4dda-4477-8dfc-ac1850bb262c@gmx.de>
Date: Thu, 1 Oct 2026 01:19:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] ACPI: battery: add acpi_ prefix to the battery
 hook API
To: Jordan Brough <jordan@brough.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Antheas Kapenekakis <lkml@antheas.dev>, Matthew Garrett
 <mjg59@srcf.ucam.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Jonathan Woithe <jwoithe@just42.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>, Ike Panhc
 <ikepanhc@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Matan Ziv-Av <matan@svgalib.org>, Nikita Kravets <teackot@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Joshua Grisham <josh@joshuagrisham.com>, Jeremy Soller
 <jeremy@system76.com>, System76 Product Development
 <productdev@system76.com>, Azael Avalos <coproscefalo@gmail.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org
References: <20260930222650.1883805-1-jordan@brough.org>
 <20260930222650.1883805-2-jordan@brough.org>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260930222650.1883805-2-jordan@brough.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iv3GtM/iDIa6yKPqwZknQmhFKBO51sIdMCongu9nnUEC4VK5/rb
 kOltvYfYnwlueVANKMrHU99+5SOMS7Sax/vc3FpzQHkZdBK0QkqxpvYhjhORB92uSGoywh5
 E7FRXInRxS9l83q/E93KEBTIi5LYWKV82icH7SCQz92WLOvS4nbFqo2CoHHxgPom+eYawHC
 NmiWeK9Vz6ZLTOw64j3Wg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wz1FkosIwyU=;fTH7C/xWfYLGx+kbArZ1aQISwdA
 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

Am 01.10.26 um 00:26 schrieb Jordan Brough:

> Rename battery_hook_register(), battery_hook_unregister() and
> devm_battery_hook_register() to acpi_battery_hook_register(),
> acpi_battery_hook_unregister() and devm_acpi_battery_hook_register(), so
> that the exported ACPI battery hook API has a consistent namespace, and
> update all in-tree callers.
>
> No functional change.

For the uniwill-laptop changes:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Jordan Brough <jordan@brough.org>
> ---
>   drivers/acpi/battery.c                       | 30 ++++++++++----------
>   drivers/platform/x86/asus-wmi.c              |  4 +--
>   drivers/platform/x86/ayaneo-ec.c             |  2 +-
>   drivers/platform/x86/dell/dell-laptop.c      |  4 +--
>   drivers/platform/x86/dell/dell-wmi-ddv.c     |  2 +-
>   drivers/platform/x86/fujitsu-laptop.c        |  4 +--
>   drivers/platform/x86/huawei-wmi.c            |  4 +--
>   drivers/platform/x86/lenovo/ideapad-laptop.c |  4 +--
>   drivers/platform/x86/lenovo/thinkpad_acpi.c  |  4 +--
>   drivers/platform/x86/lenovo/wmi-other.c      |  4 +--
>   drivers/platform/x86/lg-laptop.c             |  4 +--
>   drivers/platform/x86/msi-ec.c                |  4 +--
>   drivers/platform/x86/oxpec.c                 |  2 +-
>   drivers/platform/x86/samsung-galaxybook.c    |  3 +-
>   drivers/platform/x86/samsung-laptop.c        |  4 +--
>   drivers/platform/x86/system76_acpi.c         |  4 +--
>   drivers/platform/x86/toshiba_acpi.c          |  4 +--
>   drivers/platform/x86/uniwill/uniwill-acpi.c  |  2 +-
>   drivers/power/supply/cros_charge-control.c   |  2 +-
>   include/acpi/battery.h                       |  7 +++--
>   20 files changed, 50 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 8599949f8786..306bb2088ca6 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -821,7 +821,7 @@ static LIST_HEAD(acpi_battery_list);
>   static LIST_HEAD(battery_hook_list);
>   static DEFINE_MUTEX(hook_mutex);
>  =20
> -static void battery_hook_unregister_unlocked(struct acpi_battery_hook *=
hook)
> +static void acpi_battery_hook_unregister_unlocked(struct acpi_battery_h=
ook *hook)
>   {
>   	struct acpi_battery *battery;
>  =20
> @@ -838,7 +838,7 @@ static void battery_hook_unregister_unlocked(struct =
acpi_battery_hook *hook)
>   	pr_info("hook unregistered: %s\n", hook->name);
>   }
>  =20
> -void battery_hook_unregister(struct acpi_battery_hook *hook)
> +void acpi_battery_hook_unregister(struct acpi_battery_hook *hook)
>   {
>   	mutex_lock(&hook_mutex);
>   	/*
> @@ -847,13 +847,13 @@ void battery_hook_unregister(struct acpi_battery_h=
ook *hook)
>   	 * adding a new battery.
>   	 */
>   	if (!list_empty(&hook->list))
> -		battery_hook_unregister_unlocked(hook);
> +		acpi_battery_hook_unregister_unlocked(hook);
>  =20
>   	mutex_unlock(&hook_mutex);
>   }
> -EXPORT_SYMBOL_GPL(battery_hook_unregister);
> +EXPORT_SYMBOL_GPL(acpi_battery_hook_unregister);
>  =20
> -void battery_hook_register(struct acpi_battery_hook *hook)
> +void acpi_battery_hook_register(struct acpi_battery_hook *hook)
>   {
>   	struct acpi_battery *battery;
>  =20
> @@ -874,7 +874,7 @@ void battery_hook_register(struct acpi_battery_hook =
*hook)
>   			 * hooks.
>   			 */
>   			pr_err("hook failed to load: %s", hook->name);
> -			battery_hook_unregister_unlocked(hook);
> +			acpi_battery_hook_unregister_unlocked(hook);
>   			goto end;
>   		}
>  =20
> @@ -884,22 +884,22 @@ void battery_hook_register(struct acpi_battery_hoo=
k *hook)
>   end:
>   	mutex_unlock(&hook_mutex);
>   }
> -EXPORT_SYMBOL_GPL(battery_hook_register);
> +EXPORT_SYMBOL_GPL(acpi_battery_hook_register);
>  =20
> -static void devm_battery_hook_unregister(void *data)
> +static void devm_acpi_battery_hook_unregister(void *data)
>   {
>   	struct acpi_battery_hook *hook =3D data;
>  =20
> -	battery_hook_unregister(hook);
> +	acpi_battery_hook_unregister(hook);
>   }
>  =20
> -int devm_battery_hook_register(struct device *dev, struct acpi_battery_=
hook *hook)
> +int devm_acpi_battery_hook_register(struct device *dev, struct acpi_bat=
tery_hook *hook)
>   {
> -	battery_hook_register(hook);
> +	acpi_battery_hook_register(hook);
>  =20
> -	return devm_add_action_or_reset(dev, devm_battery_hook_unregister, hoo=
k);
> +	return devm_add_action_or_reset(dev, devm_acpi_battery_hook_unregister=
, hook);
>   }
> -EXPORT_SYMBOL_GPL(devm_battery_hook_register);
> +EXPORT_SYMBOL_GPL(devm_acpi_battery_hook_register);
>  =20
>   /*
>    * This function gets called right after the battery sysfs
> @@ -928,7 +928,7 @@ static void battery_hook_add_battery(struct acpi_bat=
tery *battery)
>   			 */
>   			pr_err("error in hook, unloading: %s",
>   					hook_node->name);
> -			battery_hook_unregister_unlocked(hook_node);
> +			acpi_battery_hook_unregister_unlocked(hook_node);
>   		}
>   	}
>   	mutex_unlock(&hook_mutex);
> @@ -961,7 +961,7 @@ static void __exit battery_hook_exit(void)
>   	 * need to remove the hooks.
>   	 */
>   	list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
> -		battery_hook_unregister(hook);
> +		acpi_battery_hook_unregister(hook);
>   	}
>   	mutex_destroy(&hook_mutex);
>   }
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus=
-wmi.c
> index a65090429ca7..c274f456863c 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1681,14 +1681,14 @@ static void asus_wmi_battery_init(struct asus_wm=
i *asus)
>   	asus->battery_rsoc_available =3D false;
>   	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_RSOC)) {
>   		asus->battery_rsoc_available =3D true;
> -		battery_hook_register(&battery_hook);
> +		acpi_battery_hook_register(&battery_hook);
>   	}
>   }
>  =20
>   static void asus_wmi_battery_exit(struct asus_wmi *asus)
>   {
>   	if (asus->battery_rsoc_available)
> -		battery_hook_unregister(&battery_hook);
> +		acpi_battery_hook_unregister(&battery_hook);
>   }
>  =20
>   /* LEDs **************************************************************=
*********/
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/aya=
neo-ec.c
> index 41a24e091248..3ba87bd16c9a 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -493,7 +493,7 @@ static int ayaneo_ec_probe(struct platform_device *p=
dev)
>   		data->battery_hook.add_battery =3D ayaneo_add_battery;
>   		data->battery_hook.remove_battery =3D ayaneo_remove_battery;
>   		data->battery_hook.name =3D "Ayaneo Battery";
> -		ret =3D devm_battery_hook_register(&pdev->dev, &data->battery_hook);
> +		ret =3D devm_acpi_battery_hook_register(&pdev->dev, &data->battery_ho=
ok);
>   		if (ret)
>   			return ret;
>   	}
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/=
x86/dell/dell-laptop.c
> index 89e85c7f7132..cad2bd06f28a 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -2446,13 +2446,13 @@ static void __init dell_battery_init(struct devi=
ce *dev)
>   	battery_supported_modes =3D battery_get_supported_modes();
>  =20
>   	if (battery_supported_modes !=3D 0)
> -		battery_hook_register(&dell_battery_hook);
> +		acpi_battery_hook_register(&dell_battery_hook);
>   }
>  =20
>   static void dell_battery_exit(void)
>   {
>   	if (battery_supported_modes !=3D 0)
> -		battery_hook_unregister(&dell_battery_hook);
> +		acpi_battery_hook_unregister(&dell_battery_hook);
>   }
>  =20
>   static int __init dell_init(void)
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform=
/x86/dell/dell-wmi-ddv.c
> index f8903ced461b..6f0504d7519e 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -972,7 +972,7 @@ static int dell_wmi_ddv_battery_add(struct dell_wmi_=
ddv_data *data)
>   	data->eppid_attr.attr.mode =3D 0444;
>   	data->eppid_attr.show =3D eppid_show;
>  =20
> -	return devm_battery_hook_register(&data->wdev->dev, &data->hook);
> +	return devm_acpi_battery_hook_register(&data->wdev->dev, &data->hook);
>   }
>  =20
>   static int dell_wmi_ddv_buffer_read(struct seq_file *seq, enum dell_dd=
v_method method)
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x8=
6/fujitsu-laptop.c
> index ea543deef68f..96e74c4fdb29 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -267,7 +267,7 @@ static int fujitsu_battery_charge_control_add(struct=
 device *dev)
>   		return -ENODEV;
>  =20
>   	priv->charge_control_supported =3D true;
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
>  =20
>   	return 0;
>   }
> @@ -277,7 +277,7 @@ static void fujitsu_battery_charge_control_remove(st=
ruct device *dev)
>   	struct fujitsu_laptop *priv =3D dev_get_drvdata(dev);
>  =20
>   	if (priv->charge_control_supported)
> -		battery_hook_unregister(&battery_hook);
> +		acpi_battery_hook_unregister(&battery_hook);
>   }
>  =20
>   /* Hardware access for LCD brightness control */
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/hu=
awei-wmi.c
> index d6aaf14d66a5..8cc0e900e984 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -512,7 +512,7 @@ static void huawei_wmi_battery_setup(struct device *=
dev)
>   		return;
>   	}
>  =20
> -	battery_hook_register(&huawei_wmi_battery_hook);
> +	acpi_battery_hook_register(&huawei_wmi_battery_hook);
>   	device_create_file(dev, &dev_attr_charge_control_thresholds);
>   }
>  =20
> @@ -521,7 +521,7 @@ static void huawei_wmi_battery_exit(struct device *d=
ev)
>   	struct huawei_wmi *huawei =3D dev_get_drvdata(dev);
>  =20
>   	if (huawei->battery_available) {
> -		battery_hook_unregister(&huawei_wmi_battery_hook);
> +		acpi_battery_hook_unregister(&huawei_wmi_battery_hook);
>   		device_remove_file(dev, &dev_attr_charge_control_thresholds);
>   	}
>   }
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/plat=
form/x86/lenovo/ideapad-laptop.c
> index 8213524504ee..1d90d4591641 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -2197,8 +2197,8 @@ static int ideapad_check_features(struct ideapad_p=
rivate *priv)
>   			priv->battery_hook.remove_battery =3D ideapad_battery_remove;
>   			priv->battery_hook.name =3D "Ideapad Battery Extension";
>  =20
> -			err =3D devm_battery_hook_register(&priv->platform_device->dev,
> -							 &priv->battery_hook);
> +			err =3D devm_acpi_battery_hook_register(&priv->platform_device->dev,
> +							      &priv->battery_hook);
>   			if (err)
>   				return err;
>   		}
> diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platf=
orm/x86/lenovo/thinkpad_acpi.c
> index 1661f070c571..eb5ad18855db 100644
> --- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
> +++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> @@ -10021,13 +10021,13 @@ static int __init tpacpi_battery_init(struct i=
bm_init_struct *ibm)
>   					battery_quirk_table,
>   					ARRAY_SIZE(battery_quirk_table));
>  =20
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
>   	return 0;
>   }
>  =20
>   static void tpacpi_battery_exit(void)
>   {
> -	battery_hook_unregister(&battery_hook);
> +	acpi_battery_hook_unregister(&battery_hook);
>   }
>  =20
>   static struct ibm_struct battery_driver_data =3D {
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/=
x86/lenovo/wmi-other.c
> index fbb32bf404f2..0450634ac1dd 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -946,7 +946,7 @@ static void lwmi_om_psy_ext_init(struct lwmi_om_priv=
 *priv)
>   	priv->battery_hook.name =3D "Lenovo WMI Other Battery Extension";
>   	priv->bh_registered =3D true;
>  =20
> -	battery_hook_register(&priv->battery_hook);
> +	acpi_battery_hook_register(&priv->battery_hook);
>   }
>  =20
>   /**
> @@ -960,7 +960,7 @@ static void lwmi_om_psy_remove(struct lwmi_om_priv *=
priv)
>   	if (!priv->bh_registered)
>   		return;
>  =20
> -	battery_hook_unregister(&priv->battery_hook);
> +	acpi_battery_hook_unregister(&priv->battery_hook);
>   	priv->bh_registered =3D false;
>   }
>  =20
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-=
laptop.c
> index 36ad1e269443..e788671307c4 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -1053,7 +1053,7 @@ static int acpi_probe(struct platform_device *pdev=
)
>   	if (ret)
>   		goto out_platform_device;
>  =20
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
>  =20
>   	return 0;
>  =20
> @@ -1068,7 +1068,7 @@ static void acpi_remove(struct platform_device *pd=
ev)
>   {
>   	sysfs_remove_group(&pf_device->dev.kobj, &dev_attribute_group);
>  =20
> -	battery_hook_unregister(&battery_hook);
> +	acpi_battery_hook_unregister(&battery_hook);
>   	platform_device_unregister(pf_device);
>   	pf_device =3D NULL;
>   	platform_driver_unregister(&pf_driver);
> diff --git a/drivers/platform/x86/msi-ec.c b/drivers/platform/x86/msi-ec=
.c
> index 566dfc73cb67..cb30a1d5b546 100644
> --- a/drivers/platform/x86/msi-ec.c
> +++ b/drivers/platform/x86/msi-ec.c
> @@ -1428,13 +1428,13 @@ static int __init msi_ec_init(void)
>   	if (result < 0)
>   		return result;
>  =20
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
>   	return 0;
>   }
>  =20
>   static void __exit msi_ec_exit(void)
>   {
> -	battery_hook_unregister(&battery_hook);
> +	acpi_battery_hook_unregister(&battery_hook);
>   }
>  =20
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 34bb17fca148..318f194e72b5 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -956,7 +956,7 @@ static int oxp_platform_probe(struct platform_device=
 *pdev)
>   		return PTR_ERR(hwdev);
>  =20
>   	if (oxp_psy_ext_supported()) {
> -		ret =3D devm_battery_hook_register(dev, &battery_hook);
> +		ret =3D devm_acpi_battery_hook_register(dev, &battery_hook);
>   		if (ret)
>   			return ret;
>   	}
> diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platfor=
m/x86/samsung-galaxybook.c
> index 99f72b204a51..a4f7dbb76214 100644
> --- a/drivers/platform/x86/samsung-galaxybook.c
> +++ b/drivers/platform/x86/samsung-galaxybook.c
> @@ -549,7 +549,8 @@ static int galaxybook_battery_threshold_init(struct =
samsung_galaxybook *galaxybo
>   	galaxybook->battery_hook.remove_battery =3D galaxybook_battery_remove=
;
>   	galaxybook->battery_hook.name =3D "Samsung Galaxy Book Battery Extens=
ion";
>  =20
> -	return devm_battery_hook_register(&galaxybook->platform->dev, &galaxyb=
ook->battery_hook);
> +	return devm_acpi_battery_hook_register(&galaxybook->platform->dev,
> +					       &galaxybook->battery_hook);
>   }
>  =20
>   /*
> diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x8=
6/samsung-laptop.c
> index 710f3d5bf84c..43fa1dc2773c 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -1142,8 +1142,8 @@ static int __init samsung_battery_hook_init(struct=
 samsung_laptop *samsung)
>   		samsung->battery_hook.add_battery =3D samsung_battery_add;
>   		samsung->battery_hook.remove_battery =3D samsung_battery_remove;
>   		samsung->battery_hook.name =3D "Samsung Battery Extension";
> -		retval =3D devm_battery_hook_register(&samsung->platform_device->dev,
> -						    &samsung->battery_hook);
> +		retval =3D devm_acpi_battery_hook_register(&samsung->platform_device-=
>dev,
> +							 &samsung->battery_hook);
>   	}
>  =20
>   	return retval;
> diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86=
/system76_acpi.c
> index dd7b1b07c316..33968b61f0b2 100644
> --- a/drivers/platform/x86/system76_acpi.c
> +++ b/drivers/platform/x86/system76_acpi.c
> @@ -288,12 +288,12 @@ static struct acpi_battery_hook system76_battery_h=
ook =3D {
>  =20
>   static void system76_battery_init(void)
>   {
> -	battery_hook_register(&system76_battery_hook);
> +	acpi_battery_hook_register(&system76_battery_hook);
>   }
>  =20
>   static void system76_battery_exit(void)
>   {
> -	battery_hook_unregister(&system76_battery_hook);
> +	acpi_battery_hook_unregister(&system76_battery_hook);
>   }
>  =20
>   // Get the airplane mode LED brightness
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/=
toshiba_acpi.c
> index a0b8060836d0..4cc879bc267a 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -3301,7 +3301,7 @@ static void toshiba_acpi_remove(struct platform_de=
vice *pdev)
>   	}
>  =20
>   	if (dev->battery_charge_mode_supported)
> -		battery_hook_unregister(&battery_hook);
> +		acpi_battery_hook_unregister(&battery_hook);
>  =20
>   	if (toshiba_acpi)
>   		toshiba_acpi =3D NULL;
> @@ -3566,7 +3566,7 @@ static int toshiba_acpi_probe(struct platform_devi=
ce *pdev)
>   	 * set, this must be done after toshiba_acpi is assigned.
>   	 */
>   	if (dev->battery_charge_mode_supported)
> -		battery_hook_register(&battery_hook);
> +		acpi_battery_hook_register(&battery_hook);
>  =20
>   	return 0;
>  =20
> diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platf=
orm/x86/uniwill/uniwill-acpi.c
> index 7a2eeaec4c96..d76695c2c765 100644
> --- a/drivers/platform/x86/uniwill/uniwill-acpi.c
> +++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
> @@ -2165,7 +2165,7 @@ static int uniwill_battery_init(struct uniwill_dat=
a *data)
>   	data->hook.add_battery =3D uniwill_add_battery;
>   	data->hook.remove_battery =3D uniwill_remove_battery;
>  =20
> -	return devm_battery_hook_register(data->dev, &data->hook);
> +	return devm_acpi_battery_hook_register(data->dev, &data->hook);
>   }
>  =20
>   static int uniwill_notifier_call(struct notifier_block *nb, unsigned l=
ong action, void *dummy)
> diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/=
supply/cros_charge-control.c
> index e0f168624807..1901bbcffd73 100644
> --- a/drivers/power/supply/cros_charge-control.c
> +++ b/drivers/power/supply/cros_charge-control.c
> @@ -315,7 +315,7 @@ static int cros_chctl_probe(struct platform_device *=
pdev)
>   	if (ret < 0)
>   		return ret;
>  =20
> -	return devm_battery_hook_register(dev, &priv->battery_hook);
> +	return devm_acpi_battery_hook_register(dev, &priv->battery_hook);
>   }
>  =20
>   static const struct platform_device_id cros_chctl_id[] =3D {
> diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> index c93f16dfb944..08c7e37996bf 100644
> --- a/include/acpi/battery.h
> +++ b/include/acpi/battery.h
> @@ -18,8 +18,9 @@ struct acpi_battery_hook {
>   	struct list_head list;
>   };
>  =20
> -void battery_hook_register(struct acpi_battery_hook *hook);
> -void battery_hook_unregister(struct acpi_battery_hook *hook);
> -int devm_battery_hook_register(struct device *dev, struct acpi_battery_=
hook *hook);
> +void acpi_battery_hook_register(struct acpi_battery_hook *hook);
> +void acpi_battery_hook_unregister(struct acpi_battery_hook *hook);
> +int devm_acpi_battery_hook_register(struct device *dev,
> +				    struct acpi_battery_hook *hook);
>  =20
>   #endif
