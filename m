Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501F43C7A3;
	Mon, 20 Jul 2026 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567237; cv=none; b=a8a4WfEU41Tc8rZvjU0ujigz9P42jfxpIQKa5qMZR44qJWNcndJQUUbMGWbXPV8ovuWwZtF4hNfVViMy4nAgf3zh96DuoO2RXHvD8IMIq8kZft/F7kdIyV/GGxMIlZ67ZzJY6Dn5STs0Jq4+tk6x9yrJlXHU+mQFaoV5zphp+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567237; c=relaxed/simple;
	bh=QpJayyGRfwIwgnPrJtwvRRAyWecvSEQUQJg07vqTn5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKiqvYU4mIROqhwG3N1XC1Qs0EhejMihDO/O6j1SR/0ovI4F9PwRqlGWR6EXT6K2iJU8gETIYbeCi61jQ9QvrkN0ASn3xNstGVPpUupK5+1UQgUud47GTBZNjZrXOWyLogOvWg2apDZFV68kD8dowW4yknTj9UF5KBZ/tTWNoiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RT5H9kx3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+jTIHKGj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RT5H9kx3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+jTIHKGj"
Date: Mon, 20 Jul 2026 19:07:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784567231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1spDH2aWpNawTi0FWzkm9K/w4h9xxsbHldprDmhqKsY=;
	b=RT5H9kx3G44z2XjMJsjzGLqwn4nQ/Mr4/ossQTkxVUJTH0uxkCSFLJ9SwmAd2rlaDcWlfF
	vQ5dWDszbRMuQ8fFo87nnehRNxsx3JHlSB75MkAQi/TfUc9E2K0KnYac4I89Qd/A8FhhBh
	jG04FWyPMhs6E7m88cw0NOs59MRTKIjwzpzEI6xL9TrRaAjYHyvgV7DtLxq8Hoz5D+ywCh
	fpbgsZxYbBi0dLFDc7e6xxkbDTGlml0m4VDQPRRfiOdy8DXGv58GEhmCULSzS3J2tX5HfZ
	C/h6ZpoQXEEVR8GJKgxWJwbkm3BnmuxeFNA51e4e06k8t99IVs28dX7tXy5uKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784567231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1spDH2aWpNawTi0FWzkm9K/w4h9xxsbHldprDmhqKsY=;
	b=+jTIHKGjppA7EJKqPdXiM7obdAt7VNTHbDUO7gYxpaB4llwkHJKu9Z+aXMXm24fZ2X6toi
	SulR1eRipcFVc9CQ==
From: Gregor Herburger <gregor.herburger@linutronix.de>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: raspberrypi-power: add remove function
Message-ID: <ifzlb2b3rdoo3hckhga7ggmmd3j5ub4a2krb4g25sh6naoxeyj@64ownhquehue>
References: <20260715-rpi-pm-remove-v1-1-e4eed226e08a@linutronix.de>
 <CAPx+jO8EPX2br9vsuFXBDPoQTF+Ks09MFcFQzchZxZVaj7y=-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO8EPX2br9vsuFXBDPoQTF+Ks09MFcFQzchZxZVaj7y=-w@mail.gmail.com>

On Thu, Jul 16, 2026 at 02:28:15PM +0200, Ulf Hansson wrote:
> On Wed, Jul 15, 2026 at 10:16 AM Gregor Herburger
> <gregor.herburger@linutronix.de> wrote:
> >
> > The raspberrypi-power driver registers resources with
> > of_genpd_add_provider_onecell and pm_genpd_init but never removes them.
> > When the driver gets unbound and bound again this causes error. Add a
> > remove function to cleanup all registered resources.
> >
> > Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> > ---
> >  drivers/pmdomain/bcm/raspberrypi-power.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/pmdomain/bcm/raspberrypi-power.c b/drivers/pmdomain/bcm/raspberrypi-power.c
> > index b87ea7adb7bea..2c2135c17afb0 100644
> > --- a/drivers/pmdomain/bcm/raspberrypi-power.c
> > +++ b/drivers/pmdomain/bcm/raspberrypi-power.c
> > @@ -232,6 +232,17 @@ static int rpi_power_probe(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > +static void rpi_power_remove(struct platform_device *pdev)
> > +{
> > +       struct rpi_power_domains *rpi_domains = platform_get_drvdata(pdev);
> > +       int nr_domains = RPI_POWER_DOMAIN_COUNT - 1;
> > +
> > +       of_genpd_del_provider(pdev->dev.of_node);
> > +
> > +       for (int i = nr_domains; i >= 0; i--)
> > +               pm_genpd_remove(&rpi_domains->domains[i].base);
> > +}
> > +
> >  static const struct of_device_id rpi_power_of_match[] = {
> >         { .compatible = "raspberrypi,bcm2835-power", },
> >         {},
> > @@ -244,6 +255,7 @@ static struct platform_driver rpi_power_driver = {
> >                 .of_match_table = rpi_power_of_match,
> >         },
> >         .probe          = rpi_power_probe,
> > +       .remove         = rpi_power_remove,
> 
> In general it's not a good idea to allow unbinding power domain
> drivers, as it will probably break consumers and their drivers.
> Although, I don't know whether it makes sense in this particular case.
> 
Ok. I stumbled on this when I was trying to fix an error in the remove path of
the raspberrypi-firmware driver. I have not checked if all the drivers still
work so you are probably right.

> Another option is to prevent user-space from unbinding by adding the below here:
> ".suppress_bind_attrs = true,"

That would be the simpler solution. If I add this for this driver, it should
also be added to raspberrypi-firmware and to bcm2835-mbox. Because without those
drivers this driver wouldn't work anyways. Should I add this to those drivers?
And remove the remove callbacks?
> 
> >  };
> >  builtin_platform_driver(rpi_power_driver);
> >
> 
> Kind regards
> Uffe

-- 
Gregor Herburger
Linutronix GmbH | Bahnhofstrasse 3 | D-88690 Uhldingen-Mühlhofen
Phone: +49 7556 25 999 35; Fax.: +49 7556 25 999 99

Hinweise zum Datenschutz finden Sie hier (Informations on data privacy 
can be found here): https://linutronix.de/legal/data-protection.php

Linutronix GmbH | Firmensitz (Registered Office): Uhldingen-Mühlhofen | 
Registergericht (Registration Court): Amtsgericht Freiburg i.Br., HRB700 
806 | Geschäftsführer (Managing Directors): Dr. Wilfried Wessner, 
Katharina Kopp, Alexander Gieringer
