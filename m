Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB86345EA0;
	Fri, 24 Jul 2026 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878402; cv=none; b=gvP1BQlUiu+o7niQBlfiogrs1YXr5Azl2bk2EXd/Abr7/+/NihH5iZKjZTaP3RXKJSl2Nms1Gd1ARJ85o/z/pqEhXH+hgQQ3YDQKq5bMi2+v+IFPxnZqsgpp9uTQ8OXsvPAS6w8VjNqby7LFHVnp8Ut+JRo2KiTfyA7anyAHoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878402; c=relaxed/simple;
	bh=x9LmrL4vi1p/uZ6gqpgPr54sygHMVfjIptudzDjTOl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gsPRXb4bPSqKmvSL0eoiYLZrg6lTcAm7q4WUumI8l3Tzd78hFVxJLCOOZc3N/7iCg/ng1pVTp7HfJwrrv+IFCsASsR5KrucjHRQ0uCjHhZfd6Wtt3R33BSa4ltrXO7twG+9SPDmgfzZVTyLPHPhODcsQBnHIo+hcDyudKvPcGjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=C9gNQ1Xr; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="C9gNQ1Xr"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h608V55MxzMlGk;
	Fri, 24 Jul 2026 09:33:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1784878394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfsPJae40g6qK1jZzC/IxZz7ir5SsaodPqLyDpyJNZ0=;
	b=C9gNQ1XrSDQuyHT/uSywJhQjA5vuT7vaDpc75fO5lqbYVW8mz2Wy9ePY5jgjs2cDQkilZw
	D+QZ65uSXioC/o3+TvdBlGlNeFVEsDpzeOVIqxcNjelUavHY+cBqtRRylI2fTOcr2rM47+
	8G3cFvnQ5b+nKoOzHOE6oILLrmKClwV4A0bAXQ8K+ov0NJL9vTEAVnnndLM/PNEZiUm0bP
	lVJvGxUHPaI3oK3Kizo0UY0KBzS+lLhiGW6UPFLKxHC0xe+tG6qdk9r8LRWOOHHvU+1x9C
	tK8eHxSS386LF9bWSekl5+TzRVPMof/CPIHmHFktP+ZyuvrTy1PmNQrWRkb9Vg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=lists@steffen.cc
Message-ID: <9c68a65380b440e6a51d8b3d7c9ccce53d82f13a.camel@dirkwinkel.cc>
Subject: Re: [REGRESSION]: [PATCH 1/2] power: supply: leds: create triggers
 based on properties, not type
From: Steffen Dirkwinkel <lists@steffen.cc>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, Sebastian
 Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "intel-gfx@lists.freedesktop.org"
	 <intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	 <intel-xe@lists.freedesktop.org>, ravitejax.veesam@intel.com
Date: Fri, 24 Jul 2026 09:33:11 +0200
In-Reply-To: <a95a2720-4092-4b49-bd9d-b700f1c2680d@intel.com>
References: 
	<20260625-std-power-supply-triggers-v1-0-d80db570d329@beckhoff.com>
	 <20260625-std-power-supply-triggers-v1-1-d80db570d329@beckhoff.com>
	 <a95a2720-4092-4b49-bd9d-b700f1c2680d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h608V55MxzMlGk

Hello Chaitanya,

thanks for the report. This should be a fix:
https://lore.kernel.org/all/20260724-power-supply-triggers-lockdep-v1-1-9b4=
51b1f1916@beckhoff.com/T/#u

Regards
Steffen

On Fri, 2026-07-24 at 11:28 +0530, Borah, Chaitanya Kumar wrote:
> Hello Steffen,
> On 6/25/2026 10:37 PM, Steffen Dirkwinkel wrote:
> > From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> >=20
> > Currently only battery power supplies get triggers for other properties
> > and other supplies only get the online trigger.
> >=20
> > This changes it to provide the triggers for any power supply depending
> > on what properties are available. Batteries will still get the same
> > triggers if the properties are there, but now other power supplies can
> > get the triggers too.
> >=20
>=20
> This seems to be causing regression in our linux-next CI [1] since=20
> next-20260722.
>=20
> <6>[   11.206334] ------------[ cut here ]------------
> <4>[   11.206341] WARNING: drivers/power/supply/power_supply_core.c:1384=
=20
> at power_supply_has_property+0xed/0x100, CPU#2: (udev-worker)/324
> ...
> <4>[   11.206524] Call Trace:
> <4>[   11.206526]  <TASK>
> <4>[   11.206532]  power_supply_create_triggers+0x4b/0x150
> <4>[   11.206541]  __power_supply_register.part.0+0x3b0/0x510
> <4>[   11.206547]  ? __pfx_devm_power_supply_release+0x10/0x10
> <4>[   11.206560]  devm_power_supply_register+0x75/0x100
> <4>[   11.206569]  tps6598x_probe+0x34c/0x6c0 [tps6598x]
> <4>[   11.206592]  i2c_device_probe+0x19c/0x3b0
> <4>[   11.206604]  really_probe+0xf1/0x420
> <4>[   11.206612]  __driver_probe_device+0xa2/0x1e0
> <4>[   11.206620]  driver_probe_device+0x24/0xb0
> <4>[   11.206627]  __driver_attach+0x110/0x240
> <4>[   11.206632]  ? __pfx___driver_attach+0x10/0x10
> <4>[   11.206638]  bus_for_each_dev+0x7f/0xe0
> ...
>=20
> Detailed log can be seen found in [2].
>=20
> We confirmed that reverting the patch solves the issue.
>=20
> Could you please check why the patch causes this regression and provide
> a fix if necessary?
>=20
> Regards
> Chaitanya
>=20
> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> [2]=20
> https://intel-gfx-ci.01.org/tree/linux-next/next-20260722/fi-kbl-8809g/bo=
ot0.txt
>=20
> --Bisect Logs--
>=20
> git bisect start
> # status: waiting for both good and bad commits
> # good: [842870cdfa33b9191b46484a3264bd5126a90570] net: Enable BIG TCP=
=20
> with partial GSO
> git bisect good 842870cdfa33b9191b46484a3264bd5126a90570
> # status: waiting for bad commit, 1 good commit known
> # bad: [b4515cf4156356e8f4fe6e0fdc17f59adab9772f] Add linux-next=20
> specific files for 20260722
> git bisect bad b4515cf4156356e8f4fe6e0fdc17f59adab9772f
> # good: [ce3befa9786f3e9eb3990cb6f6b497710bd10ec5] Merge branch 'master'=
=20
> of=20
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git
> git bisect good ce3befa9786f3e9eb3990cb6f6b497710bd10ec5
> # good: [efac7c4cbbafdd21f9866476e3f4e5e5bfae8912] Merge branch=20
> 'for-next' of=20
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.gi=
t
> git bisect good efac7c4cbbafdd21f9866476e3f4e5e5bfae8912
> # bad: [a91e6d5412453d44dc4d59d62d3ce50b53122ad8] Merge branch=20
> 'usb-next' of https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.=
git
> git bisect bad a91e6d5412453d44dc4d59d62d3ce50b53122ad8
> # bad: [b828bb5abe65b8b73fcd49d3c92cdd3af45bfe6f] Merge branch=20
> 'kexec-next' of=20
> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
> git bisect bad b828bb5abe65b8b73fcd49d3c92cdd3af45bfe6f
> # bad: [8a3f0f5b2aadc94d6300cfdd8daf3971decc1961] Merge branch=20
> 'for-next' of=20
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> git bisect bad 8a3f0f5b2aadc94d6300cfdd8daf3971decc1961
> # bad: [5e64a0d36112c45c8ae0c6903ce2b1b49bea04dd] Merge branch=20
> 'for-next' of=20
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t
> git bisect bad 5e64a0d36112c45c8ae0c6903ce2b1b49bea04dd
> # good: [db30c3e3e3c247b0b1e73449b7ead5dd19044c26] Merge branch=20
> 'for-mfd-next' of=20
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
> git bisect good db30c3e3e3c247b0b1e73449b7ead5dd19044c26
> # good: [406b652bf9c47d6e784fd2ab723e6798d322ef47] power: supply:=20
> rt9455_charger: Remove redundant dev_err()/dev_err_probe()
> git bisect good 406b652bf9c47d6e784fd2ab723e6798d322ef47
> # good: [5ec27fa6b9d937188a81724f09df82707cca944e] selftests: helpers:=
=20
> handle multi line in test_sysfs_prop_optional_list
> git bisect good 5ec27fa6b9d937188a81724f09df82707cca944e
> # bad: [353438b3107d56e36a642f117c2b4accc963abbd] dt-bindings: power:=20
> supply: maxim,max8903: add DC and USB input current-limit controls
> git bisect bad 353438b3107d56e36a642f117c2b4accc963abbd
> # bad: [741a9b09775517c76a5029c58a03725b414d7e20] dt-bindings: power:=20
> reset: qcom,pon: Narrow allowed reboot modes
> git bisect bad 741a9b09775517c76a5029c58a03725b414d7e20
> # good: [f97d9166048ddea147b5673330f9900bf08c725d] power: supply:=20
> sbs-battery: Add PbAc, NiZn, RAM, and ZnAr support
> git bisect good f97d9166048ddea147b5673330f9900bf08c725d
> # bad: [b04510c3af6dd34b2e8dcf303114d77d5e443cac] power: supply: leds:=
=20
> create triggers based on properties, not type
> git bisect bad b04510c3af6dd34b2e8dcf303114d77d5e443cac
> # first bad commit: [b04510c3af6dd34b2e8dcf303114d77d5e443cac] power:=20
> supply: leds: create triggers based on properties, not type
>=20
>=20
> > Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > ---
> >   drivers/power/supply/power_supply_leds.c | 88 ++++++++++++++++-------=
---------
> >   include/linux/power_supply.h             |  3 +-
> >   2 files changed, 45 insertions(+), 46 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/s=
upply/power_supply_leds.c
> > index 1548aaba3362..538cc0440e53 100644
> > --- a/drivers/power/supply/power_supply_leds.c
> > +++ b/drivers/power/supply/power_supply_leds.c
> > @@ -17,8 +17,6 @@
> >  =20
> >   #include "power_supply.h"
> >  =20
> > -/* Battery specific LEDs triggers. */
> > -
> >   struct power_supply_led_trigger {
> >   	struct led_trigger trig;
> >   	struct power_supply *psy;
> > @@ -89,7 +87,7 @@ static void power_supply_unregister_led_trigger(struc=
t led_trigger *trig)
> >   	kfree(psy_trig);
> >   }
> >  =20
> > -static void power_supply_update_bat_leds(struct power_supply *psy)
> > +static void power_supply_update_status_leds(struct power_supply *psy)
> >   {
> >   	union power_supply_propval status;
> >   	unsigned int intensity_green[3] =3D { 0, 255, 0 };
> > @@ -102,7 +100,7 @@ static void power_supply_update_bat_leds(struct pow=
er_supply *psy)
> >  =20
> >   	switch (status.intval) {
> >   	case POWER_SUPPLY_STATUS_FULL:
> > -		led_trigger_event(psy->trig, LED_FULL);
> > +		led_trigger_event(psy->charging_or_full_trig, LED_FULL);
> >   		led_trigger_event(psy->charging_trig, LED_OFF);
> >   		led_trigger_event(psy->full_trig, LED_FULL);
> >   		/* Going from blink to LED on requires a LED_OFF event to stop blin=
k */
> > @@ -114,7 +112,7 @@ static void power_supply_update_bat_leds(struct pow=
er_supply *psy)
> >   				     LED_FULL);
> >   		break;
> >   	case POWER_SUPPLY_STATUS_CHARGING:
> > -		led_trigger_event(psy->trig, LED_FULL);
> > +		led_trigger_event(psy->charging_or_full_trig, LED_FULL);
> >   		led_trigger_event(psy->charging_trig, LED_FULL);
> >   		led_trigger_event(psy->full_trig, LED_OFF);
> >   		led_trigger_blink(psy->charging_blink_full_solid_trig, 0, 0);
> > @@ -124,7 +122,7 @@ static void power_supply_update_bat_leds(struct pow=
er_supply *psy)
> >   				     LED_FULL);
> >   		break;
> >   	default:
> > -		led_trigger_event(psy->trig, LED_OFF);
> > +		led_trigger_event(psy->charging_or_full_trig, LED_OFF);
> >   		led_trigger_event(psy->charging_trig, LED_OFF);
> >   		led_trigger_event(psy->full_trig, LED_OFF);
> >   		led_trigger_event(psy->charging_blink_full_solid_trig,
> > @@ -135,21 +133,15 @@ static void power_supply_update_bat_leds(struct p=
ower_supply *psy)
> >   	}
> >   }
> >  =20
> > -static void power_supply_remove_bat_triggers(struct power_supply *psy)
> > -{
> > -	power_supply_unregister_led_trigger(psy->trig);
> > -	power_supply_unregister_led_trigger(psy->charging_trig);
> > -	power_supply_unregister_led_trigger(psy->full_trig);
> > -	power_supply_unregister_led_trigger(psy->charging_blink_full_solid_tr=
ig);
> > -	power_supply_unregister_led_trigger(psy->charging_orange_full_green_t=
rig);
> > -}
> > -
> > -static int power_supply_create_bat_triggers(struct power_supply *psy)
> > +static int power_supply_create_status_triggers(struct power_supply *ps=
y)
> >   {
> >   	int err =3D 0;
> >  =20
> > +	if (!power_supply_has_property(psy, POWER_SUPPLY_PROP_STATUS))
> > +		return 0;
> > +
> >   	power_supply_register_led_trigger(psy, "%s-charging-or-full",
> > -					  &psy->trig, &err);
> > +					  &psy->charging_or_full_trig, &err);
> >   	power_supply_register_led_trigger(psy, "%s-charging",
> >   					  &psy->charging_trig, &err);
> >   	power_supply_register_led_trigger(psy, "%s-full",
> > @@ -158,15 +150,11 @@ static int power_supply_create_bat_triggers(struc=
t power_supply *psy)
> >   					  &psy->charging_blink_full_solid_trig, &err);
> >   	power_supply_register_led_trigger(psy, "%s-charging-orange-full-gree=
n",
> >   					  &psy->charging_orange_full_green_trig, &err);
> > -	if (err)
> > -		power_supply_remove_bat_triggers(psy);
> >  =20
> >   	return err;
> >   }
> >  =20
> > -/* Generated power specific LEDs triggers. */
> > -
> > -static void power_supply_update_gen_leds(struct power_supply *psy)
> > +static void power_supply_update_online_leds(struct power_supply *psy)
> >   {
> >   	union power_supply_propval online;
> >  =20
> > @@ -175,43 +163,53 @@ static void power_supply_update_gen_leds(struct p=
ower_supply *psy)
> >  =20
> >   	dev_dbg(&psy->dev, "%s %d\n", __func__, online.intval);
> >  =20
> > -	if (online.intval)
> > -		led_trigger_event(psy->trig, LED_FULL);
> > -	else
> > -		led_trigger_event(psy->trig, LED_OFF);
> > +	led_trigger_event(psy->online_trig, online.intval ? LED_FULL : LED_OF=
F);
> >   }
> >  =20
> > -static int power_supply_create_gen_triggers(struct power_supply *psy)
> > +static int power_supply_create_online_trigger(struct power_supply *psy=
)
> >   {
> > -	return power_supply_register_led_trigger(psy, "%s-online", &psy->trig=
, NULL);
> > -}
> > +	int err =3D 0;
> >  =20
> > -static void power_supply_remove_gen_triggers(struct power_supply *psy)
> > -{
> > -	power_supply_unregister_led_trigger(psy->trig);
> > -}
> > +	if (!power_supply_has_property(psy, POWER_SUPPLY_PROP_ONLINE))
> > +		return 0;
> >  =20
> > -/* Choice what triggers to create&update. */
> > +	power_supply_register_led_trigger(psy, "%s-online", &psy->online_trig=
,
> > +					  &err);
> > +
> > +	return err;
> > +}
> >  =20
> >   void power_supply_update_leds(struct power_supply *psy)
> >   {
> > -	if (psy->desc->type =3D=3D POWER_SUPPLY_TYPE_BATTERY)
> > -		power_supply_update_bat_leds(psy);
> > -	else
> > -		power_supply_update_gen_leds(psy);
> > +	power_supply_update_online_leds(psy);
> > +	power_supply_update_status_leds(psy);
> >   }
> >  =20
> >   int power_supply_create_triggers(struct power_supply *psy)
> >   {
> > -	if (psy->desc->type =3D=3D POWER_SUPPLY_TYPE_BATTERY)
> > -		return power_supply_create_bat_triggers(psy);
> > -	return power_supply_create_gen_triggers(psy);
> > +	int err;
> > +
> > +	err =3D power_supply_create_online_trigger(psy);
> > +	if (err)
> > +		goto err_remove;
> > +
> > +	err =3D power_supply_create_status_triggers(psy);
> > +	if (err)
> > +		goto err_remove;
> > +
> > +	return 0;
> > +
> > +err_remove:
> > +	power_supply_remove_triggers(psy);
> > +	return err;
> >   }
> >  =20
> >   void power_supply_remove_triggers(struct power_supply *psy)
> >   {
> > -	if (psy->desc->type =3D=3D POWER_SUPPLY_TYPE_BATTERY)
> > -		power_supply_remove_bat_triggers(psy);
> > -	else
> > -		power_supply_remove_gen_triggers(psy);
> > +	power_supply_unregister_led_trigger(psy->online_trig);
> > +	power_supply_unregister_led_trigger(psy->charging_or_full_trig);
> > +	power_supply_unregister_led_trigger(psy->charging_trig);
> > +	power_supply_unregister_led_trigger(psy->full_trig);
> > +	power_supply_unregister_led_trigger(psy->charging_blink_full_solid_tr=
ig);
> > +	power_supply_unregister_led_trigger(psy->charging_orange_full_green_t=
rig);
> >   }
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.=
h
> > index 7a5e4c3242a0..68b65682b14d 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -346,7 +346,8 @@ struct power_supply {
> >   #endif
> >  =20
> >   #ifdef CONFIG_LEDS_TRIGGERS
> > -	struct led_trigger *trig;
> > +	struct led_trigger *charging_or_full_trig;
> > +	struct led_trigger *online_trig;
> >   	struct led_trigger *charging_trig;
> >   	struct led_trigger *full_trig;
> >   	struct led_trigger *charging_blink_full_solid_trig;
> >=20
