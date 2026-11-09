Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248873;
	b=F3TsstsQpg/lAxc6u9YTdlWx2Pd2VdW2LknmhbWjIZ0FX6lPq2GWH+wz9FJG6Il1FfzC
	 /JtwG1gvZRhfA0yPercbpdEpxlwFZYlI3669lWNch29AFZlOdQY9mLD2HGP0k5X09eyO4
	 m1HV6q3p10Aa5xJtEUugj35euILzqESDW0s5rgkh5Yj78AaA7/ODomWJBjbOA0cr7EGvL
	 yNzNHMECkBS36F1tSo+DvqQ7O8WshveiUdml9DG6bVIp8W/pTHq3a2dYXklzhPReSwE3M
	 Oe91+dzFcNAWk3DQ8e9VzREfZaeW7cahBHgQKoEAP0kWh6EbQ46nNKHqSAImCZMx/MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248873;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BhvvNpjCKmujfKtZaPMXgIgpX0BeaRWvx+u17Y9mg3M=;
	b=Ia6IwtCgK6tm7ww9f1An+r4CS17bBvF+2irudC36JxQulOf3zehMYKepaOjz7Kcy2uxl
	 4W7Q4PuXdyha5pZ92JV8rYaHqsgtwH8oF00KZxb4354F7Ct+S/U7iwKvDmemQY9FxGg6C
	 9RslkBGgXnJYYWx3L6Pjjt9jeteHlozG2ebilkIhvcs1lke27wwc6DQEBQ12Y25maikgI
	 N8cQqxFrQ42Kll3ZjcMKoud5FdEBZVkQQoNksYqo0aak2MM5FHoVOiqZSibKx7ZaInJ47
	 hxbIojr0kzsy223HjnJxYkOd2kzklYO8/eEPEv20aeTsFGB5yfGITAGrhsoa2SUVKJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQw+PWIl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C242606CC40
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQw+PWIl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3181F0080D
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 18:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794248871;
	bh=BhvvNpjCKmujfKtZaPMXgIgpX0BeaRWvx+u17Y9mg3M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BQw+PWIl5m1PefFWwtZOyYMp5/rBMTBhZ3EHz8RNSjmY/z9de5mifBonEWiAtseQv
	 XvQXIhBNTA7R1u0xGrcsI+mL0dnTQ4DOuKdqgvpqB/uvI9HV8ZLEVmQ8pi3vRQegd1
	 gMy4tzDAmN64OWiIsmdBUiEu1KA2lhwsrAeBHfy9nuPjfhH6xgXjIO4QRV2SP52QDS
	 XD5DmPmhFDnedYa/UfiWx6tlAv/zoDALQaEVp4SnUEYJTRM7K+X1CuB1icBXyv8oh7
	 GYBZjtOrd14KNon7m9j2lFTAZzwYpJ/rSUHfIG+RB+TrsJ49ljH7oO3ZfXW+saDLih
	 i4smyB2M0Brfg==
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5edf97136aaso572024e0c.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 10:27:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE1PznU2EH/YjlpemRZdPK9hVB+dVI/BHGyhWnjn0NlwYzSjsCg/Q1Xiz1B59p4/gSWALoD7Cuo9Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8jZHYMsUK9cocBtrvUqkR3aH8ZInzVbzC6NR0TUBG9Td5qExr6
	Vo573r9VhteJ/4LwHfLEp9b2L/jNpIXUpDY1FxpN/zMOzDLtGgwx6nlqXCuGHMmNP5GPBk2aJev
	YsIOanRR8NMB1drOt8S7mpHhkXXfpVrU=
X-Received: by 2002:a05:6122:4b89:b0:5ea:e17d:fc73 with SMTP id
 71dfb90a1353d-5ee0cf1551dmr4265e0c.3.1794248870748; Mon, 09 Nov 2026 10:27:50
 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930222650.1883805-1-jordan@brough.org> <20260930222650.1883805-2-jordan@brough.org>
 <ar2nf4od0AJjUnLD@marvin.atrad.com.au>
In-Reply-To: <ar2nf4od0AJjUnLD@marvin.atrad.com.au>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 19:27:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i2UT1QCa4cgapmtA7tVCTJgtcvNnUT5KVLQpya98nL+w@mail.gmail.com>
X-Gm-Features: AclHuK9TJ8EA6dyh6OPjNaKqSPFH5IRQFyiP23tA4UhXXA59Q33rXZkYGfEHir0
Message-ID: <CAJZ5v0i2UT1QCa4cgapmtA7tVCTJgtcvNnUT5KVLQpya98nL+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ACPI: battery: add acpi_ prefix to the battery
 hook API
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Jordan Brough <jordan@brough.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, 
	Denis Benato <denis.benato@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Antheas Kapenekakis <lkml@antheas.dev>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Armin Wolf <W_Armin@gmx.de>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Ike Panhc <ikepanhc@gmail.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matan Ziv-Av <matan@svgalib.org>, Nikita Kravets <teackot@gmail.com>, 
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>, 
	Joshua Grisham <josh@joshuagrisham.com>, Jeremy Soller <jeremy@system76.com>, 
	System76 Product Development <productdev@system76.com>, Azael Avalos <coproscefalo@gmail.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Sebastian Reichel <sre@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, 
	chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 2:22=E2=80=AFAM Jonathan Woithe <jwoithe@just42.net>=
 wrote:
>
> On Wed, Sep 30, 2026 at 04:26:33PM -0600, Jordan Brough wrote:
> > Rename battery_hook_register(), battery_hook_unregister() and
> > devm_battery_hook_register() to acpi_battery_hook_register(),
> > acpi_battery_hook_unregister() and devm_acpi_battery_hook_register(), s=
o
> > that the exported ACPI battery hook API has a consistent namespace, and
> > update all in-tree callers.
> >
> > No functional change.
>
> For the fujitsu-laptop changes:
>
>     Signed-off-by: Jonathan Woithe <jwoithe@just42.net>

This should be Acked-by, no?

Because you are not the author of anything in the patch nor a
maintainer forwarding it to me.

> > Signed-off-by: Jordan Brough <jordan@brough.org>
> > ---
> >  drivers/acpi/battery.c                       | 30 ++++++++++----------
> >  drivers/platform/x86/asus-wmi.c              |  4 +--
> >  drivers/platform/x86/ayaneo-ec.c             |  2 +-
> >  drivers/platform/x86/dell/dell-laptop.c      |  4 +--
> >  drivers/platform/x86/dell/dell-wmi-ddv.c     |  2 +-
> >  drivers/platform/x86/fujitsu-laptop.c        |  4 +--
> >  drivers/platform/x86/huawei-wmi.c            |  4 +--
> >  drivers/platform/x86/lenovo/ideapad-laptop.c |  4 +--
> >  drivers/platform/x86/lenovo/thinkpad_acpi.c  |  4 +--
> >  drivers/platform/x86/lenovo/wmi-other.c      |  4 +--
> >  drivers/platform/x86/lg-laptop.c             |  4 +--
> >  drivers/platform/x86/msi-ec.c                |  4 +--
> >  drivers/platform/x86/oxpec.c                 |  2 +-
> >  drivers/platform/x86/samsung-galaxybook.c    |  3 +-
> >  drivers/platform/x86/samsung-laptop.c        |  4 +--
> >  drivers/platform/x86/system76_acpi.c         |  4 +--
> >  drivers/platform/x86/toshiba_acpi.c          |  4 +--
> >  drivers/platform/x86/uniwill/uniwill-acpi.c  |  2 +-
> >  drivers/power/supply/cros_charge-control.c   |  2 +-
> >  include/acpi/battery.h                       |  7 +++--
> >  20 files changed, 50 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index 8599949f8786..306bb2088ca6 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -821,7 +821,7 @@ static LIST_HEAD(acpi_battery_list);
> >  static LIST_HEAD(battery_hook_list);
> >  static DEFINE_MUTEX(hook_mutex);
> >
> > -static void battery_hook_unregister_unlocked(struct acpi_battery_hook =
*hook)
> > +static void acpi_battery_hook_unregister_unlocked(struct acpi_battery_=
hook *hook)
> >  {
> >       struct acpi_battery *battery;
> >
> > @@ -838,7 +838,7 @@ static void battery_hook_unregister_unlocked(struct=
 acpi_battery_hook *hook)
> >       pr_info("hook unregistered: %s\n", hook->name);
> >  }
> >
> > -void battery_hook_unregister(struct acpi_battery_hook *hook)
> > +void acpi_battery_hook_unregister(struct acpi_battery_hook *hook)
> >  {
> >       mutex_lock(&hook_mutex);
> >       /*
> > @@ -847,13 +847,13 @@ void battery_hook_unregister(struct acpi_battery_=
hook *hook)
> >        * adding a new battery.
> >        */
> >       if (!list_empty(&hook->list))
> > -             battery_hook_unregister_unlocked(hook);
> > +             acpi_battery_hook_unregister_unlocked(hook);
> >
> >       mutex_unlock(&hook_mutex);
> >  }
> > -EXPORT_SYMBOL_GPL(battery_hook_unregister);
> > +EXPORT_SYMBOL_GPL(acpi_battery_hook_unregister);
> >
> > -void battery_hook_register(struct acpi_battery_hook *hook)
> > +void acpi_battery_hook_register(struct acpi_battery_hook *hook)
> >  {
> >       struct acpi_battery *battery;
> >
> > @@ -874,7 +874,7 @@ void battery_hook_register(struct acpi_battery_hook=
 *hook)
> >                        * hooks.
> >                        */
> >                       pr_err("hook failed to load: %s", hook->name);
> > -                     battery_hook_unregister_unlocked(hook);
> > +                     acpi_battery_hook_unregister_unlocked(hook);
> >                       goto end;
> >               }
> >
> > @@ -884,22 +884,22 @@ void battery_hook_register(struct acpi_battery_ho=
ok *hook)
> >  end:
> >       mutex_unlock(&hook_mutex);
> >  }
> > -EXPORT_SYMBOL_GPL(battery_hook_register);
> > +EXPORT_SYMBOL_GPL(acpi_battery_hook_register);
> >
> > -static void devm_battery_hook_unregister(void *data)
> > +static void devm_acpi_battery_hook_unregister(void *data)
> >  {
> >       struct acpi_battery_hook *hook =3D data;
> >
> > -     battery_hook_unregister(hook);
> > +     acpi_battery_hook_unregister(hook);
> >  }
> >
> > -int devm_battery_hook_register(struct device *dev, struct acpi_battery=
_hook *hook)
> > +int devm_acpi_battery_hook_register(struct device *dev, struct acpi_ba=
ttery_hook *hook)
> >  {
> > -     battery_hook_register(hook);
> > +     acpi_battery_hook_register(hook);
> >
> > -     return devm_add_action_or_reset(dev, devm_battery_hook_unregister=
, hook);
> > +     return devm_add_action_or_reset(dev, devm_acpi_battery_hook_unreg=
ister, hook);
> >  }
> > -EXPORT_SYMBOL_GPL(devm_battery_hook_register);
> > +EXPORT_SYMBOL_GPL(devm_acpi_battery_hook_register);
> >
> >  /*
> >   * This function gets called right after the battery sysfs
> > @@ -928,7 +928,7 @@ static void battery_hook_add_battery(struct acpi_ba=
ttery *battery)
> >                        */
> >                       pr_err("error in hook, unloading: %s",
> >                                       hook_node->name);
> > -                     battery_hook_unregister_unlocked(hook_node);
> > +                     acpi_battery_hook_unregister_unlocked(hook_node);
> >               }
> >       }
> >       mutex_unlock(&hook_mutex);
> > @@ -961,7 +961,7 @@ static void __exit battery_hook_exit(void)
> >        * need to remove the hooks.
> >        */
> >       list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
> > -             battery_hook_unregister(hook);
> > +             acpi_battery_hook_unregister(hook);
> >       }
> >       mutex_destroy(&hook_mutex);
> >  }
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asu=
s-wmi.c
> > index a65090429ca7..c274f456863c 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -1681,14 +1681,14 @@ static void asus_wmi_battery_init(struct asus_w=
mi *asus)
> >       asus->battery_rsoc_available =3D false;
> >       if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_RSOC)) {
> >               asus->battery_rsoc_available =3D true;
> > -             battery_hook_register(&battery_hook);
> > +             acpi_battery_hook_register(&battery_hook);
> >       }
> >  }
> >
> >  static void asus_wmi_battery_exit(struct asus_wmi *asus)
> >  {
> >       if (asus->battery_rsoc_available)
> > -             battery_hook_unregister(&battery_hook);
> > +             acpi_battery_hook_unregister(&battery_hook);
> >  }
> >
> >  /* LEDs **************************************************************=
*********/
> > diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ay=
aneo-ec.c
> > index 41a24e091248..3ba87bd16c9a 100644
> > --- a/drivers/platform/x86/ayaneo-ec.c
> > +++ b/drivers/platform/x86/ayaneo-ec.c
> > @@ -493,7 +493,7 @@ static int ayaneo_ec_probe(struct platform_device *=
pdev)
> >               data->battery_hook.add_battery =3D ayaneo_add_battery;
> >               data->battery_hook.remove_battery =3D ayaneo_remove_batte=
ry;
> >               data->battery_hook.name =3D "Ayaneo Battery";
> > -             ret =3D devm_battery_hook_register(&pdev->dev, &data->bat=
tery_hook);
> > +             ret =3D devm_acpi_battery_hook_register(&pdev->dev, &data=
->battery_hook);
> >               if (ret)
> >                       return ret;
> >       }
> > diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform=
/x86/dell/dell-laptop.c
> > index 89e85c7f7132..cad2bd06f28a 100644
> > --- a/drivers/platform/x86/dell/dell-laptop.c
> > +++ b/drivers/platform/x86/dell/dell-laptop.c
> > @@ -2446,13 +2446,13 @@ static void __init dell_battery_init(struct dev=
ice *dev)
> >       battery_supported_modes =3D battery_get_supported_modes();
> >
> >       if (battery_supported_modes !=3D 0)
> > -             battery_hook_register(&dell_battery_hook);
> > +             acpi_battery_hook_register(&dell_battery_hook);
> >  }
> >
> >  static void dell_battery_exit(void)
> >  {
> >       if (battery_supported_modes !=3D 0)
> > -             battery_hook_unregister(&dell_battery_hook);
> > +             acpi_battery_hook_unregister(&dell_battery_hook);
> >  }
> >
> >  static int __init dell_init(void)
> > diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platfor=
m/x86/dell/dell-wmi-ddv.c
> > index f8903ced461b..6f0504d7519e 100644
> > --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> > +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> > @@ -972,7 +972,7 @@ static int dell_wmi_ddv_battery_add(struct dell_wmi=
_ddv_data *data)
> >       data->eppid_attr.attr.mode =3D 0444;
> >       data->eppid_attr.show =3D eppid_show;
> >
> > -     return devm_battery_hook_register(&data->wdev->dev, &data->hook);
> > +     return devm_acpi_battery_hook_register(&data->wdev->dev, &data->h=
ook);
> >  }
> >
> >  static int dell_wmi_ddv_buffer_read(struct seq_file *seq, enum dell_dd=
v_method method)
> > diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x=
86/fujitsu-laptop.c
> > index ea543deef68f..96e74c4fdb29 100644
> > --- a/drivers/platform/x86/fujitsu-laptop.c
> > +++ b/drivers/platform/x86/fujitsu-laptop.c
> > @@ -267,7 +267,7 @@ static int fujitsu_battery_charge_control_add(struc=
t device *dev)
> >               return -ENODEV;
> >
> >       priv->charge_control_supported =3D true;
> > -     battery_hook_register(&battery_hook);
> > +     acpi_battery_hook_register(&battery_hook);
> >
> >       return 0;
> >  }
> > @@ -277,7 +277,7 @@ static void fujitsu_battery_charge_control_remove(s=
truct device *dev)
> >       struct fujitsu_laptop *priv =3D dev_get_drvdata(dev);
> >
> >       if (priv->charge_control_supported)
> > -             battery_hook_unregister(&battery_hook);
> > +             acpi_battery_hook_unregister(&battery_hook);
> >  }
> >
> >  /* Hardware access for LCD brightness control */
> > diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/h=
uawei-wmi.c
> > index d6aaf14d66a5..8cc0e900e984 100644
> > --- a/drivers/platform/x86/huawei-wmi.c
> > +++ b/drivers/platform/x86/huawei-wmi.c
> > @@ -512,7 +512,7 @@ static void huawei_wmi_battery_setup(struct device =
*dev)
> >               return;
> >       }
> >
> > -     battery_hook_register(&huawei_wmi_battery_hook);
> > +     acpi_battery_hook_register(&huawei_wmi_battery_hook);
> >       device_create_file(dev, &dev_attr_charge_control_thresholds);
> >  }
> >
> > @@ -521,7 +521,7 @@ static void huawei_wmi_battery_exit(struct device *=
dev)
> >       struct huawei_wmi *huawei =3D dev_get_drvdata(dev);
> >
> >       if (huawei->battery_available) {
> > -             battery_hook_unregister(&huawei_wmi_battery_hook);
> > +             acpi_battery_hook_unregister(&huawei_wmi_battery_hook);
> >               device_remove_file(dev, &dev_attr_charge_control_threshol=
ds);
> >       }
> >  }
> > diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/pla=
tform/x86/lenovo/ideapad-laptop.c
> > index 8213524504ee..1d90d4591641 100644
> > --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> > +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> > @@ -2197,8 +2197,8 @@ static int ideapad_check_features(struct ideapad_=
private *priv)
> >                       priv->battery_hook.remove_battery =3D ideapad_bat=
tery_remove;
> >                       priv->battery_hook.name =3D "Ideapad Battery Exte=
nsion";
> >
> > -                     err =3D devm_battery_hook_register(&priv->platfor=
m_device->dev,
> > -                                                      &priv->battery_h=
ook);
> > +                     err =3D devm_acpi_battery_hook_register(&priv->pl=
atform_device->dev,
> > +                                                           &priv->batt=
ery_hook);
> >                       if (err)
> >                               return err;
> >               }
> > diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/plat=
form/x86/lenovo/thinkpad_acpi.c
> > index 1661f070c571..eb5ad18855db 100644
> > --- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> > @@ -10021,13 +10021,13 @@ static int __init tpacpi_battery_init(struct =
ibm_init_struct *ibm)
> >                                       battery_quirk_table,
> >                                       ARRAY_SIZE(battery_quirk_table));
> >
> > -     battery_hook_register(&battery_hook);
> > +     acpi_battery_hook_register(&battery_hook);
> >       return 0;
> >  }
> >
> >  static void tpacpi_battery_exit(void)
> >  {
> > -     battery_hook_unregister(&battery_hook);
> > +     acpi_battery_hook_unregister(&battery_hook);
> >  }
> >
> >  static struct ibm_struct battery_driver_data =3D {
> > diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform=
/x86/lenovo/wmi-other.c
> > index fbb32bf404f2..0450634ac1dd 100644
> > --- a/drivers/platform/x86/lenovo/wmi-other.c
> > +++ b/drivers/platform/x86/lenovo/wmi-other.c
> > @@ -946,7 +946,7 @@ static void lwmi_om_psy_ext_init(struct lwmi_om_pri=
v *priv)
> >       priv->battery_hook.name =3D "Lenovo WMI Other Battery Extension";
> >       priv->bh_registered =3D true;
> >
> > -     battery_hook_register(&priv->battery_hook);
> > +     acpi_battery_hook_register(&priv->battery_hook);
> >  }
> >
> >  /**
> > @@ -960,7 +960,7 @@ static void lwmi_om_psy_remove(struct lwmi_om_priv =
*priv)
> >       if (!priv->bh_registered)
> >               return;
> >
> > -     battery_hook_unregister(&priv->battery_hook);
> > +     acpi_battery_hook_unregister(&priv->battery_hook);
> >       priv->bh_registered =3D false;
> >  }
> >
> > diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg=
-laptop.c
> > index 36ad1e269443..e788671307c4 100644
> > --- a/drivers/platform/x86/lg-laptop.c
> > +++ b/drivers/platform/x86/lg-laptop.c
> > @@ -1053,7 +1053,7 @@ static int acpi_probe(struct platform_device *pde=
v)
> >       if (ret)
> >               goto out_platform_device;
> >
> > -     battery_hook_register(&battery_hook);
> > +     acpi_battery_hook_register(&battery_hook);
> >
> >       return 0;
> >
> > @@ -1068,7 +1068,7 @@ static void acpi_remove(struct platform_device *p=
dev)
> >  {
> >       sysfs_remove_group(&pf_device->dev.kobj, &dev_attribute_group);
> >
> > -     battery_hook_unregister(&battery_hook);
> > +     acpi_battery_hook_unregister(&battery_hook);
> >       platform_device_unregister(pf_device);
> >       pf_device =3D NULL;
> >       platform_driver_unregister(&pf_driver);
> > diff --git a/drivers/platform/x86/msi-ec.c b/drivers/platform/x86/msi-e=
c.c
> > index 566dfc73cb67..cb30a1d5b546 100644
> > --- a/drivers/platform/x86/msi-ec.c
> > +++ b/drivers/platform/x86/msi-ec.c
> > @@ -1428,13 +1428,13 @@ static int __init msi_ec_init(void)
> >       if (result < 0)
> >               return result;
> >
> > -     battery_hook_register(&battery_hook);
> > +     acpi_battery_hook_register(&battery_hook);
> >       return 0;
> >  }
> >
> >  static void __exit msi_ec_exit(void)
> >  {
> > -     battery_hook_unregister(&battery_hook);
> > +     acpi_battery_hook_unregister(&battery_hook);
> >  }
> >
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.=
c
> > index 34bb17fca148..318f194e72b5 100644
> > --- a/drivers/platform/x86/oxpec.c
> > +++ b/drivers/platform/x86/oxpec.c
> > @@ -956,7 +956,7 @@ static int oxp_platform_probe(struct platform_devic=
e *pdev)
> >               return PTR_ERR(hwdev);
> >
> >       if (oxp_psy_ext_supported()) {
> > -             ret =3D devm_battery_hook_register(dev, &battery_hook);
> > +             ret =3D devm_acpi_battery_hook_register(dev, &battery_hoo=
k);
> >               if (ret)
> >                       return ret;
> >       }
> > diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platfo=
rm/x86/samsung-galaxybook.c
> > index 99f72b204a51..a4f7dbb76214 100644
> > --- a/drivers/platform/x86/samsung-galaxybook.c
> > +++ b/drivers/platform/x86/samsung-galaxybook.c
> > @@ -549,7 +549,8 @@ static int galaxybook_battery_threshold_init(struct=
 samsung_galaxybook *galaxybo
> >       galaxybook->battery_hook.remove_battery =3D galaxybook_battery_re=
move;
> >       galaxybook->battery_hook.name =3D "Samsung Galaxy Book Battery Ex=
tension";
> >
> > -     return devm_battery_hook_register(&galaxybook->platform->dev, &ga=
laxybook->battery_hook);
> > +     return devm_acpi_battery_hook_register(&galaxybook->platform->dev=
,
> > +                                            &galaxybook->battery_hook)=
;
> >  }
> >
> >  /*
> > diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x=
86/samsung-laptop.c
> > index 710f3d5bf84c..43fa1dc2773c 100644
> > --- a/drivers/platform/x86/samsung-laptop.c
> > +++ b/drivers/platform/x86/samsung-laptop.c
> > @@ -1142,8 +1142,8 @@ static int __init samsung_battery_hook_init(struc=
t samsung_laptop *samsung)
> >               samsung->battery_hook.add_battery =3D samsung_battery_add=
;
> >               samsung->battery_hook.remove_battery =3D samsung_battery_=
remove;
> >               samsung->battery_hook.name =3D "Samsung Battery Extension=
";
> > -             retval =3D devm_battery_hook_register(&samsung->platform_=
device->dev,
> > -                                                 &samsung->battery_hoo=
k);
> > +             retval =3D devm_acpi_battery_hook_register(&samsung->plat=
form_device->dev,
> > +                                                      &samsung->batter=
y_hook);
> >       }
> >
> >       return retval;
> > diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x8=
6/system76_acpi.c
> > index dd7b1b07c316..33968b61f0b2 100644
> > --- a/drivers/platform/x86/system76_acpi.c
> > +++ b/drivers/platform/x86/system76_acpi.c
> > @@ -288,12 +288,12 @@ static struct acpi_battery_hook system76_battery_=
hook =3D {
> >
> >  static void system76_battery_init(void)
> >  {
> > -     battery_hook_register(&system76_battery_hook);
> > +     acpi_battery_hook_register(&system76_battery_hook);
> >  }
> >
> >  static void system76_battery_exit(void)
> >  {
> > -     battery_hook_unregister(&system76_battery_hook);
> > +     acpi_battery_hook_unregister(&system76_battery_hook);
> >  }
> >
> >  // Get the airplane mode LED brightness
> > diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86=
/toshiba_acpi.c
> > index a0b8060836d0..4cc879bc267a 100644
> > --- a/drivers/platform/x86/toshiba_acpi.c
> > +++ b/drivers/platform/x86/toshiba_acpi.c
> > @@ -3301,7 +3301,7 @@ static void toshiba_acpi_remove(struct platform_d=
evice *pdev)
> >       }
> >
> >       if (dev->battery_charge_mode_supported)
> > -             battery_hook_unregister(&battery_hook);
> > +             acpi_battery_hook_unregister(&battery_hook);
> >
> >       if (toshiba_acpi)
> >               toshiba_acpi =3D NULL;
> > @@ -3566,7 +3566,7 @@ static int toshiba_acpi_probe(struct platform_dev=
ice *pdev)
> >        * set, this must be done after toshiba_acpi is assigned.
> >        */
> >       if (dev->battery_charge_mode_supported)
> > -             battery_hook_register(&battery_hook);
> > +             acpi_battery_hook_register(&battery_hook);
> >
> >       return 0;
> >
> > diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/plat=
form/x86/uniwill/uniwill-acpi.c
> > index 7a2eeaec4c96..d76695c2c765 100644
> > --- a/drivers/platform/x86/uniwill/uniwill-acpi.c
> > +++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
> > @@ -2165,7 +2165,7 @@ static int uniwill_battery_init(struct uniwill_da=
ta *data)
> >       data->hook.add_battery =3D uniwill_add_battery;
> >       data->hook.remove_battery =3D uniwill_remove_battery;
> >
> > -     return devm_battery_hook_register(data->dev, &data->hook);
> > +     return devm_acpi_battery_hook_register(data->dev, &data->hook);
> >  }
> >
> >  static int uniwill_notifier_call(struct notifier_block *nb, unsigned l=
ong action, void *dummy)
> > diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power=
/supply/cros_charge-control.c
> > index e0f168624807..1901bbcffd73 100644
> > --- a/drivers/power/supply/cros_charge-control.c
> > +++ b/drivers/power/supply/cros_charge-control.c
> > @@ -315,7 +315,7 @@ static int cros_chctl_probe(struct platform_device =
*pdev)
> >       if (ret < 0)
> >               return ret;
> >
> > -     return devm_battery_hook_register(dev, &priv->battery_hook);
> > +     return devm_acpi_battery_hook_register(dev, &priv->battery_hook);
> >  }
> >
> >  static const struct platform_device_id cros_chctl_id[] =3D {
> > diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> > index c93f16dfb944..08c7e37996bf 100644
> > --- a/include/acpi/battery.h
> > +++ b/include/acpi/battery.h
> > @@ -18,8 +18,9 @@ struct acpi_battery_hook {
> >       struct list_head list;
> >  };
> >
> > -void battery_hook_register(struct acpi_battery_hook *hook);
> > -void battery_hook_unregister(struct acpi_battery_hook *hook);
> > -int devm_battery_hook_register(struct device *dev, struct acpi_battery=
_hook *hook);
> > +void acpi_battery_hook_register(struct acpi_battery_hook *hook);
> > +void acpi_battery_hook_unregister(struct acpi_battery_hook *hook);
> > +int devm_acpi_battery_hook_register(struct device *dev,
> > +                                 struct acpi_battery_hook *hook);
> >
> >  #endif
> > --
> > 2.56.0
>
> --
