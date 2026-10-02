Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A00315D5D;
	Fri,  2 Oct 2026 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983588; cv=pass; b=DmFuH8BWQWz0KmpnKjEwAc9YHy45UfCvJWEhegcO3Du0Gmed6m3246SHlzbWDZa1PPobkgPpECAu8fwC2lBd+cuxSA5eQxquePvQgOzgDh8YlcrT1Reuse7u0MPgMZPGk6ixe73QUxw/csG9W+BQjCCQIav1FH0Av/YkOICNjVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983588; c=relaxed/simple;
	bh=gKymZsIJNb/FoIKqSdcZ9Z9/EmrBHoC5XipCMSoFfHQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=difrVAEhzp8L5JY2yI7PFatI9cJbVUPryYBsJC7YX0MGyTYhmhP+4KfNIHSRqAieMCA0dASNZueWJm846xKN2Qx2f2Akru3LfHDFuZeWfKPDHhGTnt6acA2FmPhOetmrFJVng7rdw4Dp+Od5lmJI8Iy6zRHME1PQurIy4aPJOJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=j5xzp8QJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="j5xzp8QJ"
ARC-Seal: i=1; a=rsa-sha256; t=1790983483; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XxPfGM9ePOQ6b3IV77MpKu8x1L+cLirPHP51XbCfS6YIlEMQ1YMvTMy4GFmC/pTkEsA+cLv+1xF9pF2JKF8XUKNZK7XzN383Sxhn4aOooe/dp8nHgOgubR4HksPi54aa6Nx+bHWHlWvnFJifPTVokclUbh7Tc8amVm4lvwE+gBM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790983483; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Mfyyz919CHXREcgpqVsKoI+iXWLO//Y7t++PReLvqns=; 
	b=nRFYd9SyyhDNpJdMzgW8PzGFkuuponLFP7GhI8ALlePdrUI6XjbnFEiE9waPwlWXQFMkV4DPiD8CNtl/ObD42/y6TlbZFRj8dg2IXXt+g8zbJnW/viFR3wnT62MOfcH31CKbK3MXoCuMXT/HoMlpehL5uUKeYlLicS0DSIKAhkg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790983483;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=Mfyyz919CHXREcgpqVsKoI+iXWLO//Y7t++PReLvqns=;
	b=j5xzp8QJz47OQkGhjg1mTGzL+p42zUwDpvAmvXVW8rVdMGDXRuLAB9Ntu98R6A+E
	Q67EKoVOc2VNYMJaEz0+5UulDIZ0gq1tllb/hIcMTyHY7PDROZoAoLafma9u57vn+My
	Ozpf977TKUe79BD7lMY6tRvKt7aaWIuxPvP5XStJA2aL8w/jEY/nqrciVe/MzlWU497
	pZ5766N9W3S8NvzMTD9kMURvJn47UjHbmBLB+0UmGnEApDbAHoWlTtHLllylTX8mbnI
	r+NkwL+H4oad/w/XN5yEjJu49fDNStOqIrPS1NJ8h7amZOKq/yhEZlj5WzujAiTHtmz
	uue0HZtGbQ==
Received: by smtp.zohomail.com with SMTPS id 1790983481201821.7695851218114;
	Fri, 2 Oct 2026 16:24:41 -0700 (PDT)
Message-ID: <b7c5c55ba49c852234603702ef3c55fc8ba6939f.camel@rong.moe>
Subject: Re: [PATCH v3 1/3] ACPI: battery: add acpi_ prefix to the battery
 hook API
From: Rong Zhang <i@rong.moe>
To: Jordan Brough <jordan@brough.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>, Corentin Chary
 <corentin.chary@gmail.com>, "Luke D. Jones"	 <luke@ljones.dev>, Denis
 Benato <denis.benato@linux.dev>, Hans de Goede	 <hansg@kernel.org>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?=	 <ilpo.jarvinen@linux.intel.com>, Antheas
 Kapenekakis <lkml@antheas.dev>,  Matthew Garrett <mjg59@srcf.ucam.org>,
 Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>, Armin Wolf
 <W_Armin@gmx.de>,  Jonathan Woithe <jwoithe@just42.net>, Mark Pearson
 <mpearson-lenovo@squebb.ca>, "Derek J. Clark"	 <derekjohn.clark@gmail.com>,
 Ike Panhc <ikepanhc@gmail.com>, Henrique de Moraes Holschuh	
 <hmh@hmh.eng.br>, Matan Ziv-Av <matan@svgalib.org>, Nikita Kravets	
 <teackot@gmail.com>, =?ISO-8859-1?Q?Joaqu=EDn?= Ignacio
 =?ISO-8859-1?Q?Aramend=EDa?=	 <samsagax@gmail.com>, Joshua Grisham
 <josh@joshuagrisham.com>, Jeremy Soller	 <jeremy@system76.com>, System76
 Product Development <productdev@system76.com>,  Azael Avalos
 <coproscefalo@gmail.com>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <linux@weissschuh.net>,  Benson Leung <bleung@chromium.org>, Guenter Roeck
 <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, 
	chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org
In-Reply-To: <20260930222650.1883805-2-jordan@brough.org>
References: <20260930222650.1883805-1-jordan@brough.org>
	 <20260930222650.1883805-2-jordan@brough.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 07:19:27 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Jordan,

On Wed, 2026-09-30 at 16:26 -0600, Jordan Brough wrote:
> Rename battery_hook_register(), battery_hook_unregister() and
> devm_battery_hook_register() to acpi_battery_hook_register(),
> acpi_battery_hook_unregister() and devm_acpi_battery_hook_register(), so
> that the exported ACPI battery hook API has a consistent namespace, and
> update all in-tree callers.
>=20
> No functional change.
>=20
> Signed-off-by: Jordan Brough <jordan@brough.org>

For the ideapad-laptop changes:

   Reviewed-by: Rong Zhang <i@rong.moe>

Thanks,
Rong

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
>=20
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 8599949f8786..306bb2088ca6 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -821,7 +821,7 @@ static LIST_HEAD(acpi_battery_list);
>  static LIST_HEAD(battery_hook_list);
>  static DEFINE_MUTEX(hook_mutex);
> =20
> -static void battery_hook_unregister_unlocked(struct acpi_battery_hook *h=
ook)
> +static void acpi_battery_hook_unregister_unlocked(struct acpi_battery_ho=
ok *hook)
>  {
>  	struct acpi_battery *battery;
> =20
> @@ -838,7 +838,7 @@ static void battery_hook_unregister_unlocked(struct a=
cpi_battery_hook *hook)
>  	pr_info("hook unregistered: %s\n", hook->name);
>  }
> =20
> -void battery_hook_unregister(struct acpi_battery_hook *hook)
> +void acpi_battery_hook_unregister(struct acpi_battery_hook *hook)
>  {
>  	mutex_lock(&hook_mutex);
>  	/*
> @@ -847,13 +847,13 @@ void battery_hook_unregister(struct acpi_battery_ho=
ok *hook)
>  	 * adding a new battery.
>  	 */
>  	if (!list_empty(&hook->list))
> -		battery_hook_unregister_unlocked(hook);
> +		acpi_battery_hook_unregister_unlocked(hook);
> =20
>  	mutex_unlock(&hook_mutex);
>  }
> -EXPORT_SYMBOL_GPL(battery_hook_unregister);
> +EXPORT_SYMBOL_GPL(acpi_battery_hook_unregister);
> =20
> -void battery_hook_register(struct acpi_battery_hook *hook)
> +void acpi_battery_hook_register(struct acpi_battery_hook *hook)
>  {
>  	struct acpi_battery *battery;
> =20
> @@ -874,7 +874,7 @@ void battery_hook_register(struct acpi_battery_hook *=
hook)
>  			 * hooks.
>  			 */
>  			pr_err("hook failed to load: %s", hook->name);
> -			battery_hook_unregister_unlocked(hook);
> +			acpi_battery_hook_unregister_unlocked(hook);
>  			goto end;
>  		}
> =20
> @@ -884,22 +884,22 @@ void battery_hook_register(struct acpi_battery_hook=
 *hook)
>  end:
>  	mutex_unlock(&hook_mutex);
>  }
> -EXPORT_SYMBOL_GPL(battery_hook_register);
> +EXPORT_SYMBOL_GPL(acpi_battery_hook_register);
> =20
> -static void devm_battery_hook_unregister(void *data)
> +static void devm_acpi_battery_hook_unregister(void *data)
>  {
>  	struct acpi_battery_hook *hook =3D data;
> =20
> -	battery_hook_unregister(hook);
> +	acpi_battery_hook_unregister(hook);
>  }
> =20
> -int devm_battery_hook_register(struct device *dev, struct acpi_battery_h=
ook *hook)
> +int devm_acpi_battery_hook_register(struct device *dev, struct acpi_batt=
ery_hook *hook)
>  {
> -	battery_hook_register(hook);
> +	acpi_battery_hook_register(hook);
> =20
> -	return devm_add_action_or_reset(dev, devm_battery_hook_unregister, hook=
);
> +	return devm_add_action_or_reset(dev, devm_acpi_battery_hook_unregister,=
 hook);
>  }
> -EXPORT_SYMBOL_GPL(devm_battery_hook_register);
> +EXPORT_SYMBOL_GPL(devm_acpi_battery_hook_register);
> =20
>  /*
>   * This function gets called right after the battery sysfs
> @@ -928,7 +928,7 @@ static void battery_hook_add_battery(struct acpi_batt=
ery *battery)
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
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index a65090429ca7..c274f456863c 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1681,14 +1681,14 @@ static void asus_wmi_battery_init(struct asus_wmi=
 *asus)
>  	asus->battery_rsoc_available =3D false;
>  	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_RSOC)) {
>  		asus->battery_rsoc_available =3D true;
> -		battery_hook_register(&battery_hook);
> +		acpi_battery_hook_register(&battery_hook);
>  	}
>  }
> =20
>  static void asus_wmi_battery_exit(struct asus_wmi *asus)
>  {
>  	if (asus->battery_rsoc_available)
> -		battery_hook_unregister(&battery_hook);
> +		acpi_battery_hook_unregister(&battery_hook);
>  }
> =20
>  /* LEDs ****************************************************************=
*******/
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayan=
eo-ec.c
> index 41a24e091248..3ba87bd16c9a 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -493,7 +493,7 @@ static int ayaneo_ec_probe(struct platform_device *pd=
ev)
>  		data->battery_hook.add_battery =3D ayaneo_add_battery;
>  		data->battery_hook.remove_battery =3D ayaneo_remove_battery;
>  		data->battery_hook.name =3D "Ayaneo Battery";
> -		ret =3D devm_battery_hook_register(&pdev->dev, &data->battery_hook);
> +		ret =3D devm_acpi_battery_hook_register(&pdev->dev, &data->battery_hoo=
k);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x=
86/dell/dell-laptop.c
> index 89e85c7f7132..cad2bd06f28a 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -2446,13 +2446,13 @@ static void __init dell_battery_init(struct devic=
e *dev)
>  	battery_supported_modes =3D battery_get_supported_modes();
> =20
>  	if (battery_supported_modes !=3D 0)
> -		battery_hook_register(&dell_battery_hook);
> +		acpi_battery_hook_register(&dell_battery_hook);
>  }
> =20
>  static void dell_battery_exit(void)
>  {
>  	if (battery_supported_modes !=3D 0)
> -		battery_hook_unregister(&dell_battery_hook);
> +		acpi_battery_hook_unregister(&dell_battery_hook);
>  }
> =20
>  static int __init dell_init(void)
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/=
x86/dell/dell-wmi-ddv.c
> index f8903ced461b..6f0504d7519e 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -972,7 +972,7 @@ static int dell_wmi_ddv_battery_add(struct dell_wmi_d=
dv_data *data)
>  	data->eppid_attr.attr.mode =3D 0444;
>  	data->eppid_attr.show =3D eppid_show;
> =20
> -	return devm_battery_hook_register(&data->wdev->dev, &data->hook);
> +	return devm_acpi_battery_hook_register(&data->wdev->dev, &data->hook);
>  }
> =20
>  static int dell_wmi_ddv_buffer_read(struct seq_file *seq, enum dell_ddv_=
method method)
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86=
/fujitsu-laptop.c
> index ea543deef68f..96e74c4fdb29 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -267,7 +267,7 @@ static int fujitsu_battery_charge_control_add(struct =
device *dev)
>  		return -ENODEV;
> =20
>  	priv->charge_control_supported =3D true;
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
> =20
>  	return 0;
>  }
> @@ -277,7 +277,7 @@ static void fujitsu_battery_charge_control_remove(str=
uct device *dev)
>  	struct fujitsu_laptop *priv =3D dev_get_drvdata(dev);
> =20
>  	if (priv->charge_control_supported)
> -		battery_hook_unregister(&battery_hook);
> +		acpi_battery_hook_unregister(&battery_hook);
>  }
> =20
>  /* Hardware access for LCD brightness control */
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/hua=
wei-wmi.c
> index d6aaf14d66a5..8cc0e900e984 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -512,7 +512,7 @@ static void huawei_wmi_battery_setup(struct device *d=
ev)
>  		return;
>  	}
> =20
> -	battery_hook_register(&huawei_wmi_battery_hook);
> +	acpi_battery_hook_register(&huawei_wmi_battery_hook);
>  	device_create_file(dev, &dev_attr_charge_control_thresholds);
>  }
> =20
> @@ -521,7 +521,7 @@ static void huawei_wmi_battery_exit(struct device *de=
v)
>  	struct huawei_wmi *huawei =3D dev_get_drvdata(dev);
> =20
>  	if (huawei->battery_available) {
> -		battery_hook_unregister(&huawei_wmi_battery_hook);
> +		acpi_battery_hook_unregister(&huawei_wmi_battery_hook);
>  		device_remove_file(dev, &dev_attr_charge_control_thresholds);
>  	}
>  }
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platf=
orm/x86/lenovo/ideapad-laptop.c
> index 8213524504ee..1d90d4591641 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -2197,8 +2197,8 @@ static int ideapad_check_features(struct ideapad_pr=
ivate *priv)
>  			priv->battery_hook.remove_battery =3D ideapad_battery_remove;
>  			priv->battery_hook.name =3D "Ideapad Battery Extension";
> =20
> -			err =3D devm_battery_hook_register(&priv->platform_device->dev,
> -							 &priv->battery_hook);
> +			err =3D devm_acpi_battery_hook_register(&priv->platform_device->dev,
> +							      &priv->battery_hook);
>  			if (err)
>  				return err;
>  		}
> diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platfo=
rm/x86/lenovo/thinkpad_acpi.c
> index 1661f070c571..eb5ad18855db 100644
> --- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
> +++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> @@ -10021,13 +10021,13 @@ static int __init tpacpi_battery_init(struct ib=
m_init_struct *ibm)
>  					battery_quirk_table,
>  					ARRAY_SIZE(battery_quirk_table));
> =20
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
>  	return 0;
>  }
> =20
>  static void tpacpi_battery_exit(void)
>  {
> -	battery_hook_unregister(&battery_hook);
> +	acpi_battery_hook_unregister(&battery_hook);
>  }
> =20
>  static struct ibm_struct battery_driver_data =3D {
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x=
86/lenovo/wmi-other.c
> index fbb32bf404f2..0450634ac1dd 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -946,7 +946,7 @@ static void lwmi_om_psy_ext_init(struct lwmi_om_priv =
*priv)
>  	priv->battery_hook.name =3D "Lenovo WMI Other Battery Extension";
>  	priv->bh_registered =3D true;
> =20
> -	battery_hook_register(&priv->battery_hook);
> +	acpi_battery_hook_register(&priv->battery_hook);
>  }
> =20
>  /**
> @@ -960,7 +960,7 @@ static void lwmi_om_psy_remove(struct lwmi_om_priv *p=
riv)
>  	if (!priv->bh_registered)
>  		return;
> =20
> -	battery_hook_unregister(&priv->battery_hook);
> +	acpi_battery_hook_unregister(&priv->battery_hook);
>  	priv->bh_registered =3D false;
>  }
> =20
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-l=
aptop.c
> index 36ad1e269443..e788671307c4 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -1053,7 +1053,7 @@ static int acpi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_platform_device;
> =20
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
> =20
>  	return 0;
> =20
> @@ -1068,7 +1068,7 @@ static void acpi_remove(struct platform_device *pde=
v)
>  {
>  	sysfs_remove_group(&pf_device->dev.kobj, &dev_attribute_group);
> =20
> -	battery_hook_unregister(&battery_hook);
> +	acpi_battery_hook_unregister(&battery_hook);
>  	platform_device_unregister(pf_device);
>  	pf_device =3D NULL;
>  	platform_driver_unregister(&pf_driver);
> diff --git a/drivers/platform/x86/msi-ec.c b/drivers/platform/x86/msi-ec.=
c
> index 566dfc73cb67..cb30a1d5b546 100644
> --- a/drivers/platform/x86/msi-ec.c
> +++ b/drivers/platform/x86/msi-ec.c
> @@ -1428,13 +1428,13 @@ static int __init msi_ec_init(void)
>  	if (result < 0)
>  		return result;
> =20
> -	battery_hook_register(&battery_hook);
> +	acpi_battery_hook_register(&battery_hook);
>  	return 0;
>  }
> =20
>  static void __exit msi_ec_exit(void)
>  {
> -	battery_hook_unregister(&battery_hook);
> +	acpi_battery_hook_unregister(&battery_hook);
>  }
> =20
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 34bb17fca148..318f194e72b5 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -956,7 +956,7 @@ static int oxp_platform_probe(struct platform_device =
*pdev)
>  		return PTR_ERR(hwdev);
> =20
>  	if (oxp_psy_ext_supported()) {
> -		ret =3D devm_battery_hook_register(dev, &battery_hook);
> +		ret =3D devm_acpi_battery_hook_register(dev, &battery_hook);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform=
/x86/samsung-galaxybook.c
> index 99f72b204a51..a4f7dbb76214 100644
> --- a/drivers/platform/x86/samsung-galaxybook.c
> +++ b/drivers/platform/x86/samsung-galaxybook.c
> @@ -549,7 +549,8 @@ static int galaxybook_battery_threshold_init(struct s=
amsung_galaxybook *galaxybo
>  	galaxybook->battery_hook.remove_battery =3D galaxybook_battery_remove;
>  	galaxybook->battery_hook.name =3D "Samsung Galaxy Book Battery Extensio=
n";
> =20
> -	return devm_battery_hook_register(&galaxybook->platform->dev, &galaxybo=
ok->battery_hook);
> +	return devm_acpi_battery_hook_register(&galaxybook->platform->dev,
> +					       &galaxybook->battery_hook);
>  }
> =20
>  /*
> diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86=
/samsung-laptop.c
> index 710f3d5bf84c..43fa1dc2773c 100644
> --- a/drivers/platform/x86/samsung-laptop.c
> +++ b/drivers/platform/x86/samsung-laptop.c
> @@ -1142,8 +1142,8 @@ static int __init samsung_battery_hook_init(struct =
samsung_laptop *samsung)
>  		samsung->battery_hook.add_battery =3D samsung_battery_add;
>  		samsung->battery_hook.remove_battery =3D samsung_battery_remove;
>  		samsung->battery_hook.name =3D "Samsung Battery Extension";
> -		retval =3D devm_battery_hook_register(&samsung->platform_device->dev,
> -						    &samsung->battery_hook);
> +		retval =3D devm_acpi_battery_hook_register(&samsung->platform_device->=
dev,
> +							 &samsung->battery_hook);
>  	}
> =20
>  	return retval;
> diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/=
system76_acpi.c
> index dd7b1b07c316..33968b61f0b2 100644
> --- a/drivers/platform/x86/system76_acpi.c
> +++ b/drivers/platform/x86/system76_acpi.c
> @@ -288,12 +288,12 @@ static struct acpi_battery_hook system76_battery_ho=
ok =3D {
> =20
>  static void system76_battery_init(void)
>  {
> -	battery_hook_register(&system76_battery_hook);
> +	acpi_battery_hook_register(&system76_battery_hook);
>  }
> =20
>  static void system76_battery_exit(void)
>  {
> -	battery_hook_unregister(&system76_battery_hook);
> +	acpi_battery_hook_unregister(&system76_battery_hook);
>  }
> =20
>  // Get the airplane mode LED brightness
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/t=
oshiba_acpi.c
> index a0b8060836d0..4cc879bc267a 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -3301,7 +3301,7 @@ static void toshiba_acpi_remove(struct platform_dev=
ice *pdev)
>  	}
> =20
>  	if (dev->battery_charge_mode_supported)
> -		battery_hook_unregister(&battery_hook);
> +		acpi_battery_hook_unregister(&battery_hook);
> =20
>  	if (toshiba_acpi)
>  		toshiba_acpi =3D NULL;
> @@ -3566,7 +3566,7 @@ static int toshiba_acpi_probe(struct platform_devic=
e *pdev)
>  	 * set, this must be done after toshiba_acpi is assigned.
>  	 */
>  	if (dev->battery_charge_mode_supported)
> -		battery_hook_register(&battery_hook);
> +		acpi_battery_hook_register(&battery_hook);
> =20
>  	return 0;
> =20
> diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platfo=
rm/x86/uniwill/uniwill-acpi.c
> index 7a2eeaec4c96..d76695c2c765 100644
> --- a/drivers/platform/x86/uniwill/uniwill-acpi.c
> +++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
> @@ -2165,7 +2165,7 @@ static int uniwill_battery_init(struct uniwill_data=
 *data)
>  	data->hook.add_battery =3D uniwill_add_battery;
>  	data->hook.remove_battery =3D uniwill_remove_battery;
> =20
> -	return devm_battery_hook_register(data->dev, &data->hook);
> +	return devm_acpi_battery_hook_register(data->dev, &data->hook);
>  }
> =20
>  static int uniwill_notifier_call(struct notifier_block *nb, unsigned lon=
g action, void *dummy)
> diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/s=
upply/cros_charge-control.c
> index e0f168624807..1901bbcffd73 100644
> --- a/drivers/power/supply/cros_charge-control.c
> +++ b/drivers/power/supply/cros_charge-control.c
> @@ -315,7 +315,7 @@ static int cros_chctl_probe(struct platform_device *p=
dev)
>  	if (ret < 0)
>  		return ret;
> =20
> -	return devm_battery_hook_register(dev, &priv->battery_hook);
> +	return devm_acpi_battery_hook_register(dev, &priv->battery_hook);
>  }
> =20
>  static const struct platform_device_id cros_chctl_id[] =3D {
> diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> index c93f16dfb944..08c7e37996bf 100644
> --- a/include/acpi/battery.h
> +++ b/include/acpi/battery.h
> @@ -18,8 +18,9 @@ struct acpi_battery_hook {
>  	struct list_head list;
>  };
> =20
> -void battery_hook_register(struct acpi_battery_hook *hook);
> -void battery_hook_unregister(struct acpi_battery_hook *hook);
> -int devm_battery_hook_register(struct device *dev, struct acpi_battery_h=
ook *hook);
> +void acpi_battery_hook_register(struct acpi_battery_hook *hook);
> +void acpi_battery_hook_unregister(struct acpi_battery_hook *hook);
> +int devm_acpi_battery_hook_register(struct device *dev,
> +				    struct acpi_battery_hook *hook);
> =20
>  #endif
