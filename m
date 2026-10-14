Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED04CEE43;
	Wed, 14 Oct 2026 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969530; cv=none; b=aow1gdgxBZ/JkPS7V8g/9iuBO/66P/oi3CR78zak55ZvD/mWMm+p7OdQfGAb8II6twI8+crXMFMPmn95yJC6Jwrl+uYaTWq2e7c4g6k4oxVOPQZrLfY0Rr6TAm2viqLw3ZSxJ2KdEfy7RDK76Zv6z/CR834i0zEdxpj7aRmA8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969530; c=relaxed/simple;
	bh=P7qbmzh1LYFrPtr7KweeJUCQFY0zP13Gu0g1VS0SicY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YWmxd3S15fa1lhjgFSmwkALG78HQDBwaVPqME/Vyf9MCM8wFU2j4DPA8ravvPF0XcmpPCGj6wLi4yfijfEhUO12VtYEGKq/TyzofGg+iNkX4ji0XT3GQQeP/9scTV4qijmL06TA/dxZHh/FTs5hqst++pRM7rRe8fnXer3Ym1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhhMsbHb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhhMsbHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791969528; x=1823505528;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=P7qbmzh1LYFrPtr7KweeJUCQFY0zP13Gu0g1VS0SicY=;
  b=MhhMsbHb2b+w4oOJFHX77zeGt5IdRgtalGfc0Jmks7kFDJppOkVvl3o+
   VijRjDwWN5S6QsAJSmDvpMOBL6WSFTTmCB2bW4epM6uzg0OdEdhgK80Wz
   eQQv3hwrD0TwlSjhtboG5louSh9oV9DHLwAYp2v1Ni0NarpPUXahosmb8
   ObQ7DtjM8EoY99X1TWLHVb/PxVknAi0KLLowA9QrC+tPG0+fkBwp1XQlF
   +e4qTkRhG7XEavlPe4soc0fCogtCuzGthoviqVePeawEj+FsHTZs/3L2J
   KAVoM12S9JVINPPSAZfnmLcTTH5vfeZthb3HmvaGt59sNFOTC7jlkrqM2
   w==;
X-CSE-ConnectionGUID: A0F6JIU3QAKboMXkHnC6tQ==
X-CSE-MsgGUID: XaQ1LnedQz6ChmhdA81WmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="596317"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="596317"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 02:18:46 -0700
X-CSE-ConnectionGUID: iupfWSW4Q86IPTvuMXtlHQ==
X-CSE-MsgGUID: anFHiJGJRC+58n1TO/Cu9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1348116"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.234])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 02:18:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 14 Oct 2026 12:18:31 +0300 (EEST)
To: Jordan Brough <jordan@brough.org>, "Rafael J. Wysocki" <rafael@kernel.org>
cc: Len Brown <lenb@kernel.org>, Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>, 
    Hans de Goede <hansg@kernel.org>, Antheas Kapenekakis <lkml@antheas.dev>, 
    Matthew Garrett <mjg59@srcf.ucam.org>, 
    =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    Armin Wolf <W_Armin@gmx.de>, Jonathan Woithe <jwoithe@just42.net>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Ike Panhc <ikepanhc@gmail.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Matan Ziv-Av <matan@svgalib.org>, Nikita Kravets <teackot@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Joshua Grisham <josh@joshuagrisham.com>, 
    Jeremy Soller <jeremy@system76.com>, 
    System76 Product Development <productdev@system76.com>, 
    Azael Avalos <coproscefalo@gmail.com>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
    Sebastian Reichel <sre@kernel.org>, linux-acpi@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    ibm-acpi-devel@lists.sourceforge.net, chrome-platform@lists.linux.dev, 
    linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ACPI: battery: add acpi_ prefix to the battery
 hook API
In-Reply-To: <20260930222650.1883805-2-jordan@brough.org>
Message-ID: <3cd06bed-83bd-425a-387b-f1d3b073cb47@linux.intel.com>
References: <20260930222650.1883805-1-jordan@brough.org> <20260930222650.1883805-2-jordan@brough.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-926118878-1791969511=:1157"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-926118878-1791969511=:1157
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 30 Sep 2026, Jordan Brough wrote:

> Rename battery_hook_register(), battery_hook_unregister() and
> devm_battery_hook_register() to acpi_battery_hook_register(),
> acpi_battery_hook_unregister() and devm_acpi_battery_hook_register(), so
> that the exported ACPI battery hook API has a consistent namespace, and
> update all in-tree callers.
>=20
> No functional change.
>=20
> Signed-off-by: Jordan Brough <jordan@brough.org>

Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

With one known caveat! There's c72dd9994952 ("platform/x86: add Acer=20
battery control driver") in the pdx86 tree so if Rafael takes this like he=
=20
proposed in his reply to patch 2, that needs to be handled during merge.

--=20
 i.

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
>  =09struct acpi_battery *battery;
> =20
> @@ -838,7 +838,7 @@ static void battery_hook_unregister_unlocked(struct a=
cpi_battery_hook *hook)
>  =09pr_info("hook unregistered: %s\n", hook->name);
>  }
> =20
> -void battery_hook_unregister(struct acpi_battery_hook *hook)
> +void acpi_battery_hook_unregister(struct acpi_battery_hook *hook)
>  {
>  =09mutex_lock(&hook_mutex);
>  =09/*
> @@ -847,13 +847,13 @@ void battery_hook_unregister(struct acpi_battery_ho=
ok *hook)
>  =09 * adding a new battery.
>  =09 */
>  =09if (!list_empty(&hook->list))
> -=09=09battery_hook_unregister_unlocked(hook);
> +=09=09acpi_battery_hook_unregister_unlocked(hook);
> =20
>  =09mutex_unlock(&hook_mutex);
>  }
> -EXPORT_SYMBOL_GPL(battery_hook_unregister);
> +EXPORT_SYMBOL_GPL(acpi_battery_hook_unregister);
> =20
> -void battery_hook_register(struct acpi_battery_hook *hook)
> +void acpi_battery_hook_register(struct acpi_battery_hook *hook)
>  {
>  =09struct acpi_battery *battery;
> =20
> @@ -874,7 +874,7 @@ void battery_hook_register(struct acpi_battery_hook *=
hook)
>  =09=09=09 * hooks.
>  =09=09=09 */
>  =09=09=09pr_err("hook failed to load: %s", hook->name);
> -=09=09=09battery_hook_unregister_unlocked(hook);
> +=09=09=09acpi_battery_hook_unregister_unlocked(hook);
>  =09=09=09goto end;
>  =09=09}
> =20
> @@ -884,22 +884,22 @@ void battery_hook_register(struct acpi_battery_hook=
 *hook)
>  end:
>  =09mutex_unlock(&hook_mutex);
>  }
> -EXPORT_SYMBOL_GPL(battery_hook_register);
> +EXPORT_SYMBOL_GPL(acpi_battery_hook_register);
> =20
> -static void devm_battery_hook_unregister(void *data)
> +static void devm_acpi_battery_hook_unregister(void *data)
>  {
>  =09struct acpi_battery_hook *hook =3D data;
> =20
> -=09battery_hook_unregister(hook);
> +=09acpi_battery_hook_unregister(hook);
>  }
> =20
> -int devm_battery_hook_register(struct device *dev, struct acpi_battery_h=
ook *hook)
> +int devm_acpi_battery_hook_register(struct device *dev, struct acpi_batt=
ery_hook *hook)
>  {
> -=09battery_hook_register(hook);
> +=09acpi_battery_hook_register(hook);
> =20
> -=09return devm_add_action_or_reset(dev, devm_battery_hook_unregister, ho=
ok);
> +=09return devm_add_action_or_reset(dev, devm_acpi_battery_hook_unregiste=
r, hook);
>  }
> -EXPORT_SYMBOL_GPL(devm_battery_hook_register);
> +EXPORT_SYMBOL_GPL(devm_acpi_battery_hook_register);
> =20
>  /*
>   * This function gets called right after the battery sysfs
> @@ -928,7 +928,7 @@ static void battery_hook_add_battery(struct acpi_batt=
ery *battery)
>  =09=09=09 */
>  =09=09=09pr_err("error in hook, unloading: %s",
>  =09=09=09=09=09hook_node->name);
> -=09=09=09battery_hook_unregister_unlocked(hook_node);
> +=09=09=09acpi_battery_hook_unregister_unlocked(hook_node);
>  =09=09}
>  =09}
>  =09mutex_unlock(&hook_mutex);
> @@ -961,7 +961,7 @@ static void __exit battery_hook_exit(void)
>  =09 * need to remove the hooks.
>  =09 */
>  =09list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
> -=09=09battery_hook_unregister(hook);
> +=09=09acpi_battery_hook_unregister(hook);
>  =09}
>  =09mutex_destroy(&hook_mutex);
>  }
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index a65090429ca7..c274f456863c 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1681,14 +1681,14 @@ static void asus_wmi_battery_init(struct asus_wmi=
 *asus)
>  =09asus->battery_rsoc_available =3D false;
>  =09if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_RSOC)) {
>  =09=09asus->battery_rsoc_available =3D true;
> -=09=09battery_hook_register(&battery_hook);
> +=09=09acpi_battery_hook_register(&battery_hook);
>  =09}
>  }
> =20
>  static void asus_wmi_battery_exit(struct asus_wmi *asus)
>  {
>  =09if (asus->battery_rsoc_available)
> -=09=09battery_hook_unregister(&battery_hook);
> +=09=09acpi_battery_hook_unregister(&battery_hook);
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
>  =09=09data->battery_hook.add_battery =3D ayaneo_add_battery;
>  =09=09data->battery_hook.remove_battery =3D ayaneo_remove_battery;
>  =09=09data->battery_hook.name =3D "Ayaneo Battery";
> -=09=09ret =3D devm_battery_hook_register(&pdev->dev, &data->battery_hook=
);
> +=09=09ret =3D devm_acpi_battery_hook_register(&pdev->dev, &data->battery=
_hook);
>  =09=09if (ret)
>  =09=09=09return ret;
>  =09}
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x=
86/dell/dell-laptop.c
> index 89e85c7f7132..cad2bd06f28a 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -2446,13 +2446,13 @@ static void __init dell_battery_init(struct devic=
e *dev)
>  =09battery_supported_modes =3D battery_get_supported_modes();
> =20
>  =09if (battery_supported_modes !=3D 0)
> -=09=09battery_hook_register(&dell_battery_hook);
> +=09=09acpi_battery_hook_register(&dell_battery_hook);
>  }
> =20
>  static void dell_battery_exit(void)
>  {
>  =09if (battery_supported_modes !=3D 0)
> -=09=09battery_hook_unregister(&dell_battery_hook);
> +=09=09acpi_battery_hook_unregister(&dell_battery_hook);
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
>  =09data->eppid_attr.attr.mode =3D 0444;
>  =09data->eppid_attr.show =3D eppid_show;
> =20
> -=09return devm_battery_hook_register(&data->wdev->dev, &data->hook);
> +=09return devm_acpi_battery_hook_register(&data->wdev->dev, &data->hook)=
;
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
>  =09=09return -ENODEV;
> =20
>  =09priv->charge_control_supported =3D true;
> -=09battery_hook_register(&battery_hook);
> +=09acpi_battery_hook_register(&battery_hook);
> =20
>  =09return 0;
>  }
> @@ -277,7 +277,7 @@ static void fujitsu_battery_charge_control_remove(str=
uct device *dev)
>  =09struct fujitsu_laptop *priv =3D dev_get_drvdata(dev);
> =20
>  =09if (priv->charge_control_supported)
> -=09=09battery_hook_unregister(&battery_hook);
> +=09=09acpi_battery_hook_unregister(&battery_hook);
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
>  =09=09return;
>  =09}
> =20
> -=09battery_hook_register(&huawei_wmi_battery_hook);
> +=09acpi_battery_hook_register(&huawei_wmi_battery_hook);
>  =09device_create_file(dev, &dev_attr_charge_control_thresholds);
>  }
> =20
> @@ -521,7 +521,7 @@ static void huawei_wmi_battery_exit(struct device *de=
v)
>  =09struct huawei_wmi *huawei =3D dev_get_drvdata(dev);
> =20
>  =09if (huawei->battery_available) {
> -=09=09battery_hook_unregister(&huawei_wmi_battery_hook);
> +=09=09acpi_battery_hook_unregister(&huawei_wmi_battery_hook);
>  =09=09device_remove_file(dev, &dev_attr_charge_control_thresholds);
>  =09}
>  }
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platf=
orm/x86/lenovo/ideapad-laptop.c
> index 8213524504ee..1d90d4591641 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -2197,8 +2197,8 @@ static int ideapad_check_features(struct ideapad_pr=
ivate *priv)
>  =09=09=09priv->battery_hook.remove_battery =3D ideapad_battery_remove;
>  =09=09=09priv->battery_hook.name =3D "Ideapad Battery Extension";
> =20
> -=09=09=09err =3D devm_battery_hook_register(&priv->platform_device->dev,
> -=09=09=09=09=09=09=09 &priv->battery_hook);
> +=09=09=09err =3D devm_acpi_battery_hook_register(&priv->platform_device-=
>dev,
> +=09=09=09=09=09=09=09      &priv->battery_hook);
>  =09=09=09if (err)
>  =09=09=09=09return err;
>  =09=09}
> diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platfo=
rm/x86/lenovo/thinkpad_acpi.c
> index 1661f070c571..eb5ad18855db 100644
> --- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
> +++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> @@ -10021,13 +10021,13 @@ static int __init tpacpi_battery_init(struct ib=
m_init_struct *ibm)
>  =09=09=09=09=09battery_quirk_table,
>  =09=09=09=09=09ARRAY_SIZE(battery_quirk_table));
> =20
> -=09battery_hook_register(&battery_hook);
> +=09acpi_battery_hook_register(&battery_hook);
>  =09return 0;
>  }
> =20
>  static void tpacpi_battery_exit(void)
>  {
> -=09battery_hook_unregister(&battery_hook);
> +=09acpi_battery_hook_unregister(&battery_hook);
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
>  =09priv->battery_hook.name =3D "Lenovo WMI Other Battery Extension";
>  =09priv->bh_registered =3D true;
> =20
> -=09battery_hook_register(&priv->battery_hook);
> +=09acpi_battery_hook_register(&priv->battery_hook);
>  }
> =20
>  /**
> @@ -960,7 +960,7 @@ static void lwmi_om_psy_remove(struct lwmi_om_priv *p=
riv)
>  =09if (!priv->bh_registered)
>  =09=09return;
> =20
> -=09battery_hook_unregister(&priv->battery_hook);
> +=09acpi_battery_hook_unregister(&priv->battery_hook);
>  =09priv->bh_registered =3D false;
>  }
> =20
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-l=
aptop.c
> index 36ad1e269443..e788671307c4 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -1053,7 +1053,7 @@ static int acpi_probe(struct platform_device *pdev)
>  =09if (ret)
>  =09=09goto out_platform_device;
> =20
> -=09battery_hook_register(&battery_hook);
> +=09acpi_battery_hook_register(&battery_hook);
> =20
>  =09return 0;
> =20
> @@ -1068,7 +1068,7 @@ static void acpi_remove(struct platform_device *pde=
v)
>  {
>  =09sysfs_remove_group(&pf_device->dev.kobj, &dev_attribute_group);
> =20
> -=09battery_hook_unregister(&battery_hook);
> +=09acpi_battery_hook_unregister(&battery_hook);
>  =09platform_device_unregister(pf_device);
>  =09pf_device =3D NULL;
>  =09platform_driver_unregister(&pf_driver);
> diff --git a/drivers/platform/x86/msi-ec.c b/drivers/platform/x86/msi-ec.=
c
> index 566dfc73cb67..cb30a1d5b546 100644
> --- a/drivers/platform/x86/msi-ec.c
> +++ b/drivers/platform/x86/msi-ec.c
> @@ -1428,13 +1428,13 @@ static int __init msi_ec_init(void)
>  =09if (result < 0)
>  =09=09return result;
> =20
> -=09battery_hook_register(&battery_hook);
> +=09acpi_battery_hook_register(&battery_hook);
>  =09return 0;
>  }
> =20
>  static void __exit msi_ec_exit(void)
>  {
> -=09battery_hook_unregister(&battery_hook);
> +=09acpi_battery_hook_unregister(&battery_hook);
>  }
> =20
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 34bb17fca148..318f194e72b5 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -956,7 +956,7 @@ static int oxp_platform_probe(struct platform_device =
*pdev)
>  =09=09return PTR_ERR(hwdev);
> =20
>  =09if (oxp_psy_ext_supported()) {
> -=09=09ret =3D devm_battery_hook_register(dev, &battery_hook);
> +=09=09ret =3D devm_acpi_battery_hook_register(dev, &battery_hook);
>  =09=09if (ret)
>  =09=09=09return ret;
>  =09}
> diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform=
/x86/samsung-galaxybook.c
> index 99f72b204a51..a4f7dbb76214 100644
> --- a/drivers/platform/x86/samsung-galaxybook.c
> +++ b/drivers/platform/x86/samsung-galaxybook.c
> @@ -549,7 +549,8 @@ static int galaxybook_battery_threshold_init(struct s=
amsung_galaxybook *galaxybo
>  =09galaxybook->battery_hook.remove_battery =3D galaxybook_battery_remove=
;
>  =09galaxybook->battery_hook.name =3D "Samsung Galaxy Book Battery Extens=
ion";
> =20
> -=09return devm_battery_hook_register(&galaxybook->platform->dev, &galaxy=
book->battery_hook);
> +=09return devm_acpi_battery_hook_register(&galaxybook->platform->dev,
> +=09=09=09=09=09       &galaxybook->battery_hook);
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
>  =09=09samsung->battery_hook.add_battery =3D samsung_battery_add;
>  =09=09samsung->battery_hook.remove_battery =3D samsung_battery_remove;
>  =09=09samsung->battery_hook.name =3D "Samsung Battery Extension";
> -=09=09retval =3D devm_battery_hook_register(&samsung->platform_device->d=
ev,
> -=09=09=09=09=09=09    &samsung->battery_hook);
> +=09=09retval =3D devm_acpi_battery_hook_register(&samsung->platform_devi=
ce->dev,
> +=09=09=09=09=09=09=09 &samsung->battery_hook);
>  =09}
> =20
>  =09return retval;
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
> -=09battery_hook_register(&system76_battery_hook);
> +=09acpi_battery_hook_register(&system76_battery_hook);
>  }
> =20
>  static void system76_battery_exit(void)
>  {
> -=09battery_hook_unregister(&system76_battery_hook);
> +=09acpi_battery_hook_unregister(&system76_battery_hook);
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
>  =09}
> =20
>  =09if (dev->battery_charge_mode_supported)
> -=09=09battery_hook_unregister(&battery_hook);
> +=09=09acpi_battery_hook_unregister(&battery_hook);
> =20
>  =09if (toshiba_acpi)
>  =09=09toshiba_acpi =3D NULL;
> @@ -3566,7 +3566,7 @@ static int toshiba_acpi_probe(struct platform_devic=
e *pdev)
>  =09 * set, this must be done after toshiba_acpi is assigned.
>  =09 */
>  =09if (dev->battery_charge_mode_supported)
> -=09=09battery_hook_register(&battery_hook);
> +=09=09acpi_battery_hook_register(&battery_hook);
> =20
>  =09return 0;
> =20
> diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platfo=
rm/x86/uniwill/uniwill-acpi.c
> index 7a2eeaec4c96..d76695c2c765 100644
> --- a/drivers/platform/x86/uniwill/uniwill-acpi.c
> +++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
> @@ -2165,7 +2165,7 @@ static int uniwill_battery_init(struct uniwill_data=
 *data)
>  =09data->hook.add_battery =3D uniwill_add_battery;
>  =09data->hook.remove_battery =3D uniwill_remove_battery;
> =20
> -=09return devm_battery_hook_register(data->dev, &data->hook);
> +=09return devm_acpi_battery_hook_register(data->dev, &data->hook);
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
>  =09if (ret < 0)
>  =09=09return ret;
> =20
> -=09return devm_battery_hook_register(dev, &priv->battery_hook);
> +=09return devm_acpi_battery_hook_register(dev, &priv->battery_hook);
>  }
> =20
>  static const struct platform_device_id cros_chctl_id[] =3D {
> diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> index c93f16dfb944..08c7e37996bf 100644
> --- a/include/acpi/battery.h
> +++ b/include/acpi/battery.h
> @@ -18,8 +18,9 @@ struct acpi_battery_hook {
>  =09struct list_head list;
>  };
> =20
> -void battery_hook_register(struct acpi_battery_hook *hook);
> -void battery_hook_unregister(struct acpi_battery_hook *hook);
> -int devm_battery_hook_register(struct device *dev, struct acpi_battery_h=
ook *hook);
> +void acpi_battery_hook_register(struct acpi_battery_hook *hook);
> +void acpi_battery_hook_unregister(struct acpi_battery_hook *hook);
> +int devm_acpi_battery_hook_register(struct device *dev,
> +=09=09=09=09    struct acpi_battery_hook *hook);
> =20
>  #endif
>=20
--8323328-926118878-1791969511=:1157--
