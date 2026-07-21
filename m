Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6633F825F;
	Tue, 21 Jul 2026 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617021; cv=none; b=KGaGuhI1tTtklg4fj+DFhVFIinH5fOu66uxWbn9cXYC/qQ73NXS0xQd7CvKSGxEcnI1B1WzoMkl5N/1+F4udN0D89W9Odu1WXSLBL82P9DOV0YTZU4FF4+3xhoQm2wiXAU+NfE4mE9ZUtpHpWRlkOpFdIR7y3Q/buJVjBiJZ+yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617021; c=relaxed/simple;
	bh=nns3iSgt5ff26gWQxN0huIrbM0z2U39WLRGHlKFv86w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UUD2KNAvlo5zgXfR0ocwccifWP04zLjt5bFfUT9xfw3VUlypJ81pmDmTDoK+ftwbmLSzCmVNdzEfzIM9vsa4nqaKjOtfDFFrl/gD5tnEK2OGf1TwhLqx922PyZ2/p6Xe22zpwSehNk92uAPXbcGbCfGuDupQTuka1qvFYwIbAKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=LQBQRS8S; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="LQBQRS8S"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h47Tr5qbKzMlL1;
	Tue, 21 Jul 2026 08:56:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1784617008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBL/7lIRZvpCUU2/MhTo80J7cVWUAWOQWX585xnQ+IE=;
	b=LQBQRS8SAE2nM7u6w2bDkwI6EcjDUo3WF/FM7cSUFP2vk3V1Onp4osbQ6LKpDRdREdXNHl
	I7jhdh0WP3tMe/tqC1pWczHVaKPAOzGdP8SZGcWUNuBbKi2+FbWFhRzFy50uGz3buzWVNH
	XTJdctmvxsKREhScky1ZMOQvUweVO7J5/zcn5v/IYWyDph2h39PNqh01bEsXBA+9/p1GOh
	9YuxkvUJ5WHXnqCLorA36HewtZP7ifYdRZA0MDJ7n41Zz2UNi1FKFS8ZPl2XWLEG722C3C
	A5gk4HUMHCk+P95jSiad7DE4oRGcENzM50Xb77v5H9tO6M6gl4UtXeL3hFOwYQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=lists@steffen.cc
Message-ID: <b31e36e3c6b36e1b65880d91b53f6f3f9611a102.camel@dirkwinkel.cc>
Subject: Re: [PATCH 2/2] power: supply: leds: add a not-charging trigger
From: Steffen Dirkwinkel <"Steffen Dirkwinkel <lists"@steffen.cc>>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 Jul 2026 08:56:47 +0200
In-Reply-To: <al6dJek_lLPGARdU@venus>
References: 
	<20260625-std-power-supply-triggers-v1-0-d80db570d329@beckhoff.com>
	 <20260625-std-power-supply-triggers-v1-2-d80db570d329@beckhoff.com>
	 <al6dJek_lLPGARdU@venus>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: yaa8mgkf3m736f11djhoxwu5bop5ujii
X-MBO-RS-ID: 271db2019656a914a18
X-Rspamd-Queue-Id: 4h47Tr5qbKzMlL1

Hi,

On Tue, 2026-07-21 at 00:23 +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Thu, Jun 25, 2026 at 07:07:35PM +0200, Steffen Dirkwinkel wrote:
> > From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> >=20
> > We intend to use this with a gpio-charger ups device that reports
> > charging or not-charging based on a gpio to set a "power failure" led.
> >=20
> > Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > ---
> >  drivers/power/supply/power_supply_leds.c | 7 +++++++
> >  include/linux/power_supply.h             | 1 +
> >  2 files changed, 8 insertions(+)
>=20
> POWER_SUPPLY_STATUS_NOT_CHARGING means, that a battery is neither
> charged **nor discharged**. I think the NOT_CHARGING status has a
> bad name, but it's ABI and cannot be changed easily. But I certainly
> don't want it to spread further. Let's find a better name for this
> trigger. Maybe idle?

Hm, I guess I was also mislead by the name, as it's somewhat correct for my
usecase, our gpio connected ups is indicating "not-charging" via a gpio and=
 I'm
using it as a gpio-charger charge-status-gpio.

I guess it would be more correct if I could map the gpio-charger charge sta=
tus
to switch between charging and discharging instead of indicating not-chargi=
ng.
If you agree I'd add that as an option via device tree binding there and ad=
d a
discharging trigger instead of the not charging one to the led triggers:

  charge-status-discharging:
      type: boolean
      description:
        Interpret a deasserted charge-status-gpio as "discharging" instead =
of
	"not charging".

Thanks,
Steffen

>=20
> Greetings,
>=20
> -- Sebastian
>=20
> > diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/s=
upply/power_supply_leds.c
> > index 538cc0440e53..c82a3628765c 100644
> > --- a/drivers/power/supply/power_supply_leds.c
> > +++ b/drivers/power/supply/power_supply_leds.c
> > @@ -131,6 +131,10 @@ static void power_supply_update_status_leds(struct=
 power_supply *psy)
> >  			LED_OFF);
> >  		break;
> >  	}
> > +
> > +	led_trigger_event(psy->not_charging_trig,
> > +			  status.intval =3D=3D POWER_SUPPLY_STATUS_NOT_CHARGING ?
> > +			  LED_FULL : LED_OFF);
> >  }
> > =20
> >  static int power_supply_create_status_triggers(struct power_supply *ps=
y)
> > @@ -150,6 +154,8 @@ static int power_supply_create_status_triggers(stru=
ct power_supply *psy)
> >  					  &psy->charging_blink_full_solid_trig, &err);
> >  	power_supply_register_led_trigger(psy, "%s-charging-orange-full-green=
",
> >  					  &psy->charging_orange_full_green_trig, &err);
> > +	power_supply_register_led_trigger(psy, "%s-not-charging",
> > +					  &psy->not_charging_trig, &err);
> > =20
> >  	return err;
> >  }
> > @@ -209,6 +215,7 @@ void power_supply_remove_triggers(struct power_supp=
ly *psy)
> >  	power_supply_unregister_led_trigger(psy->online_trig);
> >  	power_supply_unregister_led_trigger(psy->charging_or_full_trig);
> >  	power_supply_unregister_led_trigger(psy->charging_trig);
> > +	power_supply_unregister_led_trigger(psy->not_charging_trig);
> >  	power_supply_unregister_led_trigger(psy->full_trig);
> >  	power_supply_unregister_led_trigger(psy->charging_blink_full_solid_tr=
ig);
> >  	power_supply_unregister_led_trigger(psy->charging_orange_full_green_t=
rig);
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.=
h
> > index 68b65682b14d..9052610e3910 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -349,6 +349,7 @@ struct power_supply {
> >  	struct led_trigger *charging_or_full_trig;
> >  	struct led_trigger *online_trig;
> >  	struct led_trigger *charging_trig;
> > +	struct led_trigger *not_charging_trig;
> >  	struct led_trigger *full_trig;
> >  	struct led_trigger *charging_blink_full_solid_trig;
> >  	struct led_trigger *charging_orange_full_green_trig;
> >=20
> > --=20
> > 2.54.0
> >=20
