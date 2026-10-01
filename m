Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D404F389460
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790817298; cv=none; b=tY1XuQJLHJ9Z8tmJXpOYk4JpGxpuWlhTMZWTffdP2A8OxQmmcieNu7sKVikh4EQgxWDEKuI9kbXth0QBDscx9fXoyUxajo777aB/Qc45mb87KyLZ5POOcTf2JF3aMXboQ90jBSpsRNx5O2NZfDb+vmuWgEsbBfjnUHHiLtpxYiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790817298; c=relaxed/simple;
	bh=yMM0M3vD9jCGcrGlH53+Mw2mLb9iUV1gkUzbQlpLxNY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MuJxM5OLt3a8wOC8hfu4dnT7Hu3ousl+QI6g+kKuMaacsYXqH9Cm7J1DukIz+0k5gSUTpGrgZ4DLjvqaUd0OetE5mXafHe/Lq61aMYSEQ4rPN5kOhSKGbqmzOYsG3NpFam7+Z8b/MfNV955ZCIQep5wE+6xL5zku1HEgSzuxPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rxr5wEXq; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rxr5wEXq"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a156f4so3448958eec.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 18:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790817292; x=1791422092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aNL2BQ1Px9PeoTOl0fe3Esu/NbQrt+58N+/EFBAhznk=;
        b=Rxr5wEXqDck1YoUvj+WgtheoW3kYDNK80TRiNC26KuUUvXfnPfwSAB8d0/rpaOQ4tt
         XQyOwDCp8DWMGxonUxtLoGdYkJeZo6HReQsM4TRUIuWD8VfH/wC6MCykOHM4kZ2z7ClL
         MC4Jvmc4pVp5doRTL005DPavZctofBZGm2MVrYC1c+57Eykn9Mdu+j4gnOrf8a3badtA
         vSPpAtnnAZjZm52PnjIx/nSxnAl+T7tJItQcQXLMqy2V7xaw+XdvMz+qfGm2kuZPXFFW
         JyeThfv/w2TvyCOkJfaB9xsWkXx981oxLOZ53glwfd+yka5wB2hVM/3r08PoZPT0wJAX
         o/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790817292; x=1791422092;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aNL2BQ1Px9PeoTOl0fe3Esu/NbQrt+58N+/EFBAhznk=;
        b=k+9m/Bz7Elrf5FGCZX9oYD+UWMmSoXLZ8L8aS72jhX/XdvoFKVo9IKyArKeWl30WlY
         UIP2GvPso//U5oMLzz0I3opqKFNJJAbjL+0Ohz9uhEknYHu9v9dTbXCyWF1ridx981d0
         Ct9qqh31uCzJc6blpsTfdV9rSPAZJOnTb3bfZ4ocpRPqcdoUAxLydghz2DjIANyWtr1X
         zx4VL6tthnKZoGNR90MuNmSYUa1DhPN0hg1HLxTgq+XdtYURE7Fea+9AnPOvVh3CqOXK
         CeOGP5tr6yHXmodYIBfqyAsILNqbfHyeW8Ckv14u5P5XRE6WvaMGno9i3PqnMn8fh0AW
         mIQw==
X-Forwarded-Encrypted: i=1; AKwUvBzlFtnzuuHIcAaKpVr55UD18XrFlsoLPDwCZQiuvBhGk52ipN8Q9UtBZsUC/7ftyPaA8uKZZ9RZyQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI9XL/Nlsgywq9EObxZOSkZ4sBoOioLPGolziBW3XcejonKs73b
	gcYF6VLxm+xT1IOPZ9U46zoCls+8P3WVMhrLGHSS3JEeXoidSxkTKbx6UOqEgG0J
X-Gm-Gg: AYBFou1sedKZolsmQ8fP98sZI7Q7OjHnZlYqXCsXaeaYs/jhPGNuyljRxlcrzJabBj4
	GQxYiCVsj+5JiR9Lh1MU3qwHv14kIREII0vpIBx8jP7m1BGPi/rCQoRxRaVGYUk9X7+9Rva7ulP
	DtI1+OLH72tClMoKJwdeeoCA4gpu6hIHC0KFDHUpLuuQh0AxK+nEGGnr0/KCFOomV75WVGpH8zQ
	tUfbNjzkJCdzXOV1R9j2UchB9L1BJd1Fl+uOI4YVFS5kDOpQrzbGQeFoyg44wyYcw7l37siQNVs
	Mjp0E5qehhFj4Ug0I+IaThPHh12aFqOujYAC3spRn7x17DhwPffMsHCw60/dwPQCiFkz7d1/HV+
	xSeJOOCXbGK4a1YK2kaCgt9RT4OX4HtR9LBLsZjPFYus+33UJLZjY4xyiUjekROLiKn5U5HsV1s
	JoAoWbBXWWB7huJUIJFlTu8BnfXEka2mKW9mTELG3L0vBYjVKBe9C+lw9YNYokjYPziwUAP7imP
	HalXr8cwu6IxwmyvXznvsF5192cSKz9QteHtyh0Yy/BO4meWv+eu8U6koett8Uy0GMh
X-Received: by 2002:a05:7301:825:b0:34a:48ce:b687 with SMTP id 5a478bee46e88-34cdcfaa20dmr3394861eec.32.1790817291533;
        Wed, 30 Sep 2026 18:14:51 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db37573c9sm2459316eec.14.2026.09.30.18.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 18:14:51 -0700 (PDT)
Date: Wed, 30 Sep 2026 18:14:48 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jordan Brough <jordan@brough.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>,
 Hans de Goede <hansg@kernel.org>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Antheas Kapenekakis <lkml@antheas.dev>,
 Matthew Garrett <mjg59@srcf.ucam.org>,
 =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>, Armin Wolf <W_Armin@gmx.de>,
 Jonathan Woithe <jwoithe@just42.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Ike Panhc <ikepanhc@gmail.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Matan Ziv-Av <matan@svgalib.org>, Nikita Kravets <teackot@gmail.com>,
 =?ISO-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
 Joshua Grisham <josh@joshuagrisham.com>, Jeremy Soller <jeremy@system76.com>,
 System76 Product Development <productdev@system76.com>,
 Azael Avalos <coproscefalo@gmail.com>,
 =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Sebastian Reichel <sre@kernel.org>
CC: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/3=5D_ACPI=3A_battery=3A_add?=
 =?US-ASCII?Q?_acpi=5F_prefix_to_the_battery_hook_API?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260930222650.1883805-2-jordan@brough.org>
References: <20260930222650.1883805-1-jordan@brough.org> <20260930222650.1883805-2-jordan@brough.org>
Message-ID: <75CA83D8-3036-46B0-BC04-A522F63B3871@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 30, 2026 3:26:33 PM PDT, Jordan Brough <jordan@brough=2Eorg> w=
rote:
>Rename battery_hook_register(), battery_hook_unregister() and
>devm_battery_hook_register() to acpi_battery_hook_register(),
>acpi_battery_hook_unregister() and devm_acpi_battery_hook_register(), so
>that the exported ACPI battery hook API has a consistent namespace, and
>update all in-tree callers=2E
>
>No functional change=2E

For the lenovo/wmi-other changes=2E=20

Reviewed-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>

>Signed-off-by: Jordan Brough <jordan@brough=2Eorg>
>---
> drivers/acpi/battery=2Ec                       | 30 ++++++++++----------
> drivers/platform/x86/asus-wmi=2Ec              |  4 +--
> drivers/platform/x86/ayaneo-ec=2Ec             |  2 +-
> drivers/platform/x86/dell/dell-laptop=2Ec      |  4 +--
> drivers/platform/x86/dell/dell-wmi-ddv=2Ec     |  2 +-
> drivers/platform/x86/fujitsu-laptop=2Ec        |  4 +--
> drivers/platform/x86/huawei-wmi=2Ec            |  4 +--
> drivers/platform/x86/lenovo/ideapad-laptop=2Ec |  4 +--
> drivers/platform/x86/lenovo/thinkpad_acpi=2Ec  |  4 +--
> drivers/platform/x86/lenovo/wmi-other=2Ec      |  4 +--
> drivers/platform/x86/lg-laptop=2Ec             |  4 +--
> drivers/platform/x86/msi-ec=2Ec                |  4 +--
> drivers/platform/x86/oxpec=2Ec                 |  2 +-
> drivers/platform/x86/samsung-galaxybook=2Ec    |  3 +-
> drivers/platform/x86/samsung-laptop=2Ec        |  4 +--
> drivers/platform/x86/system76_acpi=2Ec         |  4 +--
> drivers/platform/x86/toshiba_acpi=2Ec          |  4 +--
> drivers/platform/x86/uniwill/uniwill-acpi=2Ec  |  2 +-
> drivers/power/supply/cros_charge-control=2Ec   |  2 +-
> include/acpi/battery=2Eh                       |  7 +++--
> 20 files changed, 50 insertions(+), 48 deletions(-)
>
>diff --git a/drivers/acpi/battery=2Ec b/drivers/acpi/battery=2Ec
>index 8599949f8786=2E=2E306bb2088ca6 100644
>--- a/drivers/acpi/battery=2Ec
>+++ b/drivers/acpi/battery=2Ec
>@@ -821,7 +821,7 @@ static LIST_HEAD(acpi_battery_list);
> static LIST_HEAD(battery_hook_list);
> static DEFINE_MUTEX(hook_mutex);
>=20
>-static void battery_hook_unregister_unlocked(struct acpi_battery_hook *h=
ook)
>+static void acpi_battery_hook_unregister_unlocked(struct acpi_battery_ho=
ok *hook)
> {
> 	struct acpi_battery *battery;
>=20
>@@ -838,7 +838,7 @@ static void battery_hook_unregister_unlocked(struct a=
cpi_battery_hook *hook)
> 	pr_info("hook unregistered: %s\n", hook->name);
> }
>=20
>-void battery_hook_unregister(struct acpi_battery_hook *hook)
>+void acpi_battery_hook_unregister(struct acpi_battery_hook *hook)
> {
> 	mutex_lock(&hook_mutex);
> 	/*
>@@ -847,13 +847,13 @@ void battery_hook_unregister(struct acpi_battery_ho=
ok *hook)
> 	 * adding a new battery=2E
> 	 */
> 	if (!list_empty(&hook->list))
>-		battery_hook_unregister_unlocked(hook);
>+		acpi_battery_hook_unregister_unlocked(hook);
>=20
> 	mutex_unlock(&hook_mutex);
> }
>-EXPORT_SYMBOL_GPL(battery_hook_unregister);
>+EXPORT_SYMBOL_GPL(acpi_battery_hook_unregister);
>=20
>-void battery_hook_register(struct acpi_battery_hook *hook)
>+void acpi_battery_hook_register(struct acpi_battery_hook *hook)
> {
> 	struct acpi_battery *battery;
>=20
>@@ -874,7 +874,7 @@ void battery_hook_register(struct acpi_battery_hook *=
hook)
> 			 * hooks=2E
> 			 */
> 			pr_err("hook failed to load: %s", hook->name);
>-			battery_hook_unregister_unlocked(hook);
>+			acpi_battery_hook_unregister_unlocked(hook);
> 			goto end;
> 		}
>=20
>@@ -884,22 +884,22 @@ void battery_hook_register(struct acpi_battery_hook=
 *hook)
> end:
> 	mutex_unlock(&hook_mutex);
> }
>-EXPORT_SYMBOL_GPL(battery_hook_register);
>+EXPORT_SYMBOL_GPL(acpi_battery_hook_register);
>=20
>-static void devm_battery_hook_unregister(void *data)
>+static void devm_acpi_battery_hook_unregister(void *data)
> {
> 	struct acpi_battery_hook *hook =3D data;
>=20
>-	battery_hook_unregister(hook);
>+	acpi_battery_hook_unregister(hook);
> }
>=20
>-int devm_battery_hook_register(struct device *dev, struct acpi_battery_h=
ook *hook)
>+int devm_acpi_battery_hook_register(struct device *dev, struct acpi_batt=
ery_hook *hook)
> {
>-	battery_hook_register(hook);
>+	acpi_battery_hook_register(hook);
>=20
>-	return devm_add_action_or_reset(dev, devm_battery_hook_unregister, hook=
);
>+	return devm_add_action_or_reset(dev, devm_acpi_battery_hook_unregister,=
 hook);
> }
>-EXPORT_SYMBOL_GPL(devm_battery_hook_register);
>+EXPORT_SYMBOL_GPL(devm_acpi_battery_hook_register);
>=20
> /*
>  * This function gets called right after the battery sysfs
>@@ -928,7 +928,7 @@ static void battery_hook_add_battery(struct acpi_batt=
ery *battery)
> 			 */
> 			pr_err("error in hook, unloading: %s",
> 					hook_node->name);
>-			battery_hook_unregister_unlocked(hook_node);
>+			acpi_battery_hook_unregister_unlocked(hook_node);
> 		}
> 	}
> 	mutex_unlock(&hook_mutex);
>@@ -961,7 +961,7 @@ static void __exit battery_hook_exit(void)
> 	 * need to remove the hooks=2E
> 	 */
> 	list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
>-		battery_hook_unregister(hook);
>+		acpi_battery_hook_unregister(hook);
> 	}
> 	mutex_destroy(&hook_mutex);
> }
>diff --git a/drivers/platform/x86/asus-wmi=2Ec b/drivers/platform/x86/asu=
s-wmi=2Ec
>index a65090429ca7=2E=2Ec274f456863c 100644
>--- a/drivers/platform/x86/asus-wmi=2Ec
>+++ b/drivers/platform/x86/asus-wmi=2Ec
>@@ -1681,14 +1681,14 @@ static void asus_wmi_battery_init(struct asus_wmi=
 *asus)
> 	asus->battery_rsoc_available =3D false;
> 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_RSOC)) {
> 		asus->battery_rsoc_available =3D true;
>-		battery_hook_register(&battery_hook);
>+		acpi_battery_hook_register(&battery_hook);
> 	}
> }
>=20
> static void asus_wmi_battery_exit(struct asus_wmi *asus)
> {
> 	if (asus->battery_rsoc_available)
>-		battery_hook_unregister(&battery_hook);
>+		acpi_battery_hook_unregister(&battery_hook);
> }
>=20
> /* LEDs ****************************************************************=
*******/
>diff --git a/drivers/platform/x86/ayaneo-ec=2Ec b/drivers/platform/x86/ay=
aneo-ec=2Ec
>index 41a24e091248=2E=2E3ba87bd16c9a 100644
>--- a/drivers/platform/x86/ayaneo-ec=2Ec
>+++ b/drivers/platform/x86/ayaneo-ec=2Ec
>@@ -493,7 +493,7 @@ static int ayaneo_ec_probe(struct platform_device *pd=
ev)
> 		data->battery_hook=2Eadd_battery =3D ayaneo_add_battery;
> 		data->battery_hook=2Eremove_battery =3D ayaneo_remove_battery;
> 		data->battery_hook=2Ename =3D "Ayaneo Battery";
>-		ret =3D devm_battery_hook_register(&pdev->dev, &data->battery_hook);
>+		ret =3D devm_acpi_battery_hook_register(&pdev->dev, &data->battery_hoo=
k);
> 		if (ret)
> 			return ret;
> 	}
>diff --git a/drivers/platform/x86/dell/dell-laptop=2Ec b/drivers/platform=
/x86/dell/dell-laptop=2Ec
>index 89e85c7f7132=2E=2Ecad2bd06f28a 100644
>--- a/drivers/platform/x86/dell/dell-laptop=2Ec
>+++ b/drivers/platform/x86/dell/dell-laptop=2Ec
>@@ -2446,13 +2446,13 @@ static void __init dell_battery_init(struct devic=
e *dev)
> 	battery_supported_modes =3D battery_get_supported_modes();
>=20
> 	if (battery_supported_modes !=3D 0)
>-		battery_hook_register(&dell_battery_hook);
>+		acpi_battery_hook_register(&dell_battery_hook);
> }
>=20
> static void dell_battery_exit(void)
> {
> 	if (battery_supported_modes !=3D 0)
>-		battery_hook_unregister(&dell_battery_hook);
>+		acpi_battery_hook_unregister(&dell_battery_hook);
> }
>=20
> static int __init dell_init(void)
>diff --git a/drivers/platform/x86/dell/dell-wmi-ddv=2Ec b/drivers/platfor=
m/x86/dell/dell-wmi-ddv=2Ec
>index f8903ced461b=2E=2E6f0504d7519e 100644
>--- a/drivers/platform/x86/dell/dell-wmi-ddv=2Ec
>+++ b/drivers/platform/x86/dell/dell-wmi-ddv=2Ec
>@@ -972,7 +972,7 @@ static int dell_wmi_ddv_battery_add(struct dell_wmi_d=
dv_data *data)
> 	data->eppid_attr=2Eattr=2Emode =3D 0444;
> 	data->eppid_attr=2Eshow =3D eppid_show;
>=20
>-	return devm_battery_hook_register(&data->wdev->dev, &data->hook);
>+	return devm_acpi_battery_hook_register(&data->wdev->dev, &data->hook);
> }
>=20
> static int dell_wmi_ddv_buffer_read(struct seq_file *seq, enum dell_ddv_=
method method)
>diff --git a/drivers/platform/x86/fujitsu-laptop=2Ec b/drivers/platform/x=
86/fujitsu-laptop=2Ec
>index ea543deef68f=2E=2E96e74c4fdb29 100644
>--- a/drivers/platform/x86/fujitsu-laptop=2Ec
>+++ b/drivers/platform/x86/fujitsu-laptop=2Ec
>@@ -267,7 +267,7 @@ static int fujitsu_battery_charge_control_add(struct =
device *dev)
> 		return -ENODEV;
>=20
> 	priv->charge_control_supported =3D true;
>-	battery_hook_register(&battery_hook);
>+	acpi_battery_hook_register(&battery_hook);
>=20
> 	return 0;
> }
>@@ -277,7 +277,7 @@ static void fujitsu_battery_charge_control_remove(str=
uct device *dev)
> 	struct fujitsu_laptop *priv =3D dev_get_drvdata(dev);
>=20
> 	if (priv->charge_control_supported)
>-		battery_hook_unregister(&battery_hook);
>+		acpi_battery_hook_unregister(&battery_hook);
> }
>=20
> /* Hardware access for LCD brightness control */
>diff --git a/drivers/platform/x86/huawei-wmi=2Ec b/drivers/platform/x86/h=
uawei-wmi=2Ec
>index d6aaf14d66a5=2E=2E8cc0e900e984 100644
>--- a/drivers/platform/x86/huawei-wmi=2Ec
>+++ b/drivers/platform/x86/huawei-wmi=2Ec
>@@ -512,7 +512,7 @@ static void huawei_wmi_battery_setup(struct device *d=
ev)
> 		return;
> 	}
>=20
>-	battery_hook_register(&huawei_wmi_battery_hook);
>+	acpi_battery_hook_register(&huawei_wmi_battery_hook);
> 	device_create_file(dev, &dev_attr_charge_control_thresholds);
> }
>=20
>@@ -521,7 +521,7 @@ static void huawei_wmi_battery_exit(struct device *de=
v)
> 	struct huawei_wmi *huawei =3D dev_get_drvdata(dev);
>=20
> 	if (huawei->battery_available) {
>-		battery_hook_unregister(&huawei_wmi_battery_hook);
>+		acpi_battery_hook_unregister(&huawei_wmi_battery_hook);
> 		device_remove_file(dev, &dev_attr_charge_control_thresholds);
> 	}
> }
>diff --git a/drivers/platform/x86/lenovo/ideapad-laptop=2Ec b/drivers/pla=
tform/x86/lenovo/ideapad-laptop=2Ec
>index 8213524504ee=2E=2E1d90d4591641 100644
>--- a/drivers/platform/x86/lenovo/ideapad-laptop=2Ec
>+++ b/drivers/platform/x86/lenovo/ideapad-laptop=2Ec
>@@ -2197,8 +2197,8 @@ static int ideapad_check_features(struct ideapad_pr=
ivate *priv)
> 			priv->battery_hook=2Eremove_battery =3D ideapad_battery_remove;
> 			priv->battery_hook=2Ename =3D "Ideapad Battery Extension";
>=20
>-			err =3D devm_battery_hook_register(&priv->platform_device->dev,
>-							 &priv->battery_hook);
>+			err =3D devm_acpi_battery_hook_register(&priv->platform_device->dev,
>+							      &priv->battery_hook);
> 			if (err)
> 				return err;
> 		}
>diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi=2Ec b/drivers/plat=
form/x86/lenovo/thinkpad_acpi=2Ec
>index 1661f070c571=2E=2Eeb5ad18855db 100644
>--- a/drivers/platform/x86/lenovo/thinkpad_acpi=2Ec
>+++ b/drivers/platform/x86/lenovo/thinkpad_acpi=2Ec
>@@ -10021,13 +10021,13 @@ static int __init tpacpi_battery_init(struct ib=
m_init_struct *ibm)
> 					battery_quirk_table,
> 					ARRAY_SIZE(battery_quirk_table));
>=20
>-	battery_hook_register(&battery_hook);
>+	acpi_battery_hook_register(&battery_hook);
> 	return 0;
> }
>=20
> static void tpacpi_battery_exit(void)
> {
>-	battery_hook_unregister(&battery_hook);
>+	acpi_battery_hook_unregister(&battery_hook);
> }
>=20
> static struct ibm_struct battery_driver_data =3D {
>diff --git a/drivers/platform/x86/lenovo/wmi-other=2Ec b/drivers/platform=
/x86/lenovo/wmi-other=2Ec
>index fbb32bf404f2=2E=2E0450634ac1dd 100644
>--- a/drivers/platform/x86/lenovo/wmi-other=2Ec
>+++ b/drivers/platform/x86/lenovo/wmi-other=2Ec
>@@ -946,7 +946,7 @@ static void lwmi_om_psy_ext_init(struct lwmi_om_priv =
*priv)
> 	priv->battery_hook=2Ename =3D "Lenovo WMI Other Battery Extension";
> 	priv->bh_registered =3D true;
>=20
>-	battery_hook_register(&priv->battery_hook);
>+	acpi_battery_hook_register(&priv->battery_hook);
> }
>=20
> /**
>@@ -960,7 +960,7 @@ static void lwmi_om_psy_remove(struct lwmi_om_priv *p=
riv)
> 	if (!priv->bh_registered)
> 		return;
>=20
>-	battery_hook_unregister(&priv->battery_hook);
>+	acpi_battery_hook_unregister(&priv->battery_hook);
> 	priv->bh_registered =3D false;
> }
>=20
>diff --git a/drivers/platform/x86/lg-laptop=2Ec b/drivers/platform/x86/lg=
-laptop=2Ec
>index 36ad1e269443=2E=2Ee788671307c4 100644
>--- a/drivers/platform/x86/lg-laptop=2Ec
>+++ b/drivers/platform/x86/lg-laptop=2Ec
>@@ -1053,7 +1053,7 @@ static int acpi_probe(struct platform_device *pdev)
> 	if (ret)
> 		goto out_platform_device;
>=20
>-	battery_hook_register(&battery_hook);
>+	acpi_battery_hook_register(&battery_hook);
>=20
> 	return 0;
>=20
>@@ -1068,7 +1068,7 @@ static void acpi_remove(struct platform_device *pde=
v)
> {
> 	sysfs_remove_group(&pf_device->dev=2Ekobj, &dev_attribute_group);
>=20
>-	battery_hook_unregister(&battery_hook);
>+	acpi_battery_hook_unregister(&battery_hook);
> 	platform_device_unregister(pf_device);
> 	pf_device =3D NULL;
> 	platform_driver_unregister(&pf_driver);
>diff --git a/drivers/platform/x86/msi-ec=2Ec b/drivers/platform/x86/msi-e=
c=2Ec
>index 566dfc73cb67=2E=2Ecb30a1d5b546 100644
>--- a/drivers/platform/x86/msi-ec=2Ec
>+++ b/drivers/platform/x86/msi-ec=2Ec
>@@ -1428,13 +1428,13 @@ static int __init msi_ec_init(void)
> 	if (result < 0)
> 		return result;
>=20
>-	battery_hook_register(&battery_hook);
>+	acpi_battery_hook_register(&battery_hook);
> 	return 0;
> }
>=20
> static void __exit msi_ec_exit(void)
> {
>-	battery_hook_unregister(&battery_hook);
>+	acpi_battery_hook_unregister(&battery_hook);
> }
>=20
> MODULE_LICENSE("GPL");
>diff --git a/drivers/platform/x86/oxpec=2Ec b/drivers/platform/x86/oxpec=
=2Ec
>index 34bb17fca148=2E=2E318f194e72b5 100644
>--- a/drivers/platform/x86/oxpec=2Ec
>+++ b/drivers/platform/x86/oxpec=2Ec
>@@ -956,7 +956,7 @@ static int oxp_platform_probe(struct platform_device =
*pdev)
> 		return PTR_ERR(hwdev);
>=20
> 	if (oxp_psy_ext_supported()) {
>-		ret =3D devm_battery_hook_register(dev, &battery_hook);
>+		ret =3D devm_acpi_battery_hook_register(dev, &battery_hook);
> 		if (ret)
> 			return ret;
> 	}
>diff --git a/drivers/platform/x86/samsung-galaxybook=2Ec b/drivers/platfo=
rm/x86/samsung-galaxybook=2Ec
>index 99f72b204a51=2E=2Ea4f7dbb76214 100644
>--- a/drivers/platform/x86/samsung-galaxybook=2Ec
>+++ b/drivers/platform/x86/samsung-galaxybook=2Ec
>@@ -549,7 +549,8 @@ static int galaxybook_battery_threshold_init(struct s=
amsung_galaxybook *galaxybo
> 	galaxybook->battery_hook=2Eremove_battery =3D galaxybook_battery_remove=
;
> 	galaxybook->battery_hook=2Ename =3D "Samsung Galaxy Book Battery Extens=
ion";
>=20
>-	return devm_battery_hook_register(&galaxybook->platform->dev, &galaxybo=
ok->battery_hook);
>+	return devm_acpi_battery_hook_register(&galaxybook->platform->dev,
>+					       &galaxybook->battery_hook);
> }
>=20
> /*
>diff --git a/drivers/platform/x86/samsung-laptop=2Ec b/drivers/platform/x=
86/samsung-laptop=2Ec
>index 710f3d5bf84c=2E=2E43fa1dc2773c 100644
>--- a/drivers/platform/x86/samsung-laptop=2Ec
>+++ b/drivers/platform/x86/samsung-laptop=2Ec
>@@ -1142,8 +1142,8 @@ static int __init samsung_battery_hook_init(struct =
samsung_laptop *samsung)
> 		samsung->battery_hook=2Eadd_battery =3D samsung_battery_add;
> 		samsung->battery_hook=2Eremove_battery =3D samsung_battery_remove;
> 		samsung->battery_hook=2Ename =3D "Samsung Battery Extension";
>-		retval =3D devm_battery_hook_register(&samsung->platform_device->dev,
>-						    &samsung->battery_hook);
>+		retval =3D devm_acpi_battery_hook_register(&samsung->platform_device->=
dev,
>+							 &samsung->battery_hook);
> 	}
>=20
> 	return retval;
>diff --git a/drivers/platform/x86/system76_acpi=2Ec b/drivers/platform/x8=
6/system76_acpi=2Ec
>index dd7b1b07c316=2E=2E33968b61f0b2 100644
>--- a/drivers/platform/x86/system76_acpi=2Ec
>+++ b/drivers/platform/x86/system76_acpi=2Ec
>@@ -288,12 +288,12 @@ static struct acpi_battery_hook system76_battery_ho=
ok =3D {
>=20
> static void system76_battery_init(void)
> {
>-	battery_hook_register(&system76_battery_hook);
>+	acpi_battery_hook_register(&system76_battery_hook);
> }
>=20
> static void system76_battery_exit(void)
> {
>-	battery_hook_unregister(&system76_battery_hook);
>+	acpi_battery_hook_unregister(&system76_battery_hook);
> }
>=20
> // Get the airplane mode LED brightness
>diff --git a/drivers/platform/x86/toshiba_acpi=2Ec b/drivers/platform/x86=
/toshiba_acpi=2Ec
>index a0b8060836d0=2E=2E4cc879bc267a 100644
>--- a/drivers/platform/x86/toshiba_acpi=2Ec
>+++ b/drivers/platform/x86/toshiba_acpi=2Ec
>@@ -3301,7 +3301,7 @@ static void toshiba_acpi_remove(struct platform_dev=
ice *pdev)
> 	}
>=20
> 	if (dev->battery_charge_mode_supported)
>-		battery_hook_unregister(&battery_hook);
>+		acpi_battery_hook_unregister(&battery_hook);
>=20
> 	if (toshiba_acpi)
> 		toshiba_acpi =3D NULL;
>@@ -3566,7 +3566,7 @@ static int toshiba_acpi_probe(struct platform_devic=
e *pdev)
> 	 * set, this must be done after toshiba_acpi is assigned=2E
> 	 */
> 	if (dev->battery_charge_mode_supported)
>-		battery_hook_register(&battery_hook);
>+		acpi_battery_hook_register(&battery_hook);
>=20
> 	return 0;
>=20
>diff --git a/drivers/platform/x86/uniwill/uniwill-acpi=2Ec b/drivers/plat=
form/x86/uniwill/uniwill-acpi=2Ec
>index 7a2eeaec4c96=2E=2Ed76695c2c765 100644
>--- a/drivers/platform/x86/uniwill/uniwill-acpi=2Ec
>+++ b/drivers/platform/x86/uniwill/uniwill-acpi=2Ec
>@@ -2165,7 +2165,7 @@ static int uniwill_battery_init(struct uniwill_data=
 *data)
> 	data->hook=2Eadd_battery =3D uniwill_add_battery;
> 	data->hook=2Eremove_battery =3D uniwill_remove_battery;
>=20
>-	return devm_battery_hook_register(data->dev, &data->hook);
>+	return devm_acpi_battery_hook_register(data->dev, &data->hook);
> }
>=20
> static int uniwill_notifier_call(struct notifier_block *nb, unsigned lon=
g action, void *dummy)
>diff --git a/drivers/power/supply/cros_charge-control=2Ec b/drivers/power=
/supply/cros_charge-control=2Ec
>index e0f168624807=2E=2E1901bbcffd73 100644
>--- a/drivers/power/supply/cros_charge-control=2Ec
>+++ b/drivers/power/supply/cros_charge-control=2Ec
>@@ -315,7 +315,7 @@ static int cros_chctl_probe(struct platform_device *p=
dev)
> 	if (ret < 0)
> 		return ret;
>=20
>-	return devm_battery_hook_register(dev, &priv->battery_hook);
>+	return devm_acpi_battery_hook_register(dev, &priv->battery_hook);
> }
>=20
> static const struct platform_device_id cros_chctl_id[] =3D {
>diff --git a/include/acpi/battery=2Eh b/include/acpi/battery=2Eh
>index c93f16dfb944=2E=2E08c7e37996bf 100644
>--- a/include/acpi/battery=2Eh
>+++ b/include/acpi/battery=2Eh
>@@ -18,8 +18,9 @@ struct acpi_battery_hook {
> 	struct list_head list;
> };
>=20
>-void battery_hook_register(struct acpi_battery_hook *hook);
>-void battery_hook_unregister(struct acpi_battery_hook *hook);
>-int devm_battery_hook_register(struct device *dev, struct acpi_battery_h=
ook *hook);
>+void acpi_battery_hook_register(struct acpi_battery_hook *hook);
>+void acpi_battery_hook_unregister(struct acpi_battery_hook *hook);
>+int devm_acpi_battery_hook_register(struct device *dev,
>+				    struct acpi_battery_hook *hook);
>=20
> #endif

