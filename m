From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 3/4] power: Add support for DA9150 Fuel-Gauge
Date: Tue, 7 Jul 2015 07:58:01 +0100
Message-ID: <20150707065801.GG3182@x1>
References: <cover.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
 <596f44407759e2047a02594367116f9c92afee56.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
 <20150703152217.GC10500@x1>
 <2E89032DDAA8B9408CB92943514A0337AB55C839@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36603 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbbGGG6G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 02:58:06 -0400
Received: by widjy10 with SMTP id jy10so179580416wid.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2015 23:58:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337AB55C839@SW-EX-MBX01.diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, jic23@cam.ac.uk

On Mon, 06 Jul 2015, Opensource [Adam Thomson] wrote:

> On July 3, 2015 16:22, Lee Jones wrote:
>=20
> > > +/*
> > > + * Function template to provide battery temperature. Should prov=
ide
> > > + * 0.1 degrees C resolution return values.
> > > + */
> > > +typedef int (*da9150_read_temp_t)(void *context);
> > > +
> > > +/* Register temp callback function */
> > > +void da9150_fg_register_temp_cb(struct power_supply *psy,
> > da9150_read_temp_t cb,
> > > +				void *cb_context);
> > > +
> > >  #endif /* __DA9150_FG_H */
> >=20
> > I still don't get why you think pointers are better than just calli=
ng
> > the function directly.  Can the *fn() ever point to different funct=
ions?
>=20
> Here, the intention is to cover the scenario where a battery has no i=
nternal
> thermistor, and cannot provide temperature readings to the DA9150 dev=
ice. In
> that scenario I've allowed for the option of providing an external fu=
nction
> which can give the temperature reading instead as DA9150 will not be =
able to
> provide a correct reading in that scenario. This would be platform de=
pendent and
> such a platform using a battery not employing an NTC in their battery=
 can
> register its own call-back function to provide battery temperature in=
stead.
>=20
> So, in answer to your question, yes.

Before you add this scenario, I would like to see the code which
utilises it.  I'm not a fan of coding-up 'just-in-case's.  Please
re-submit when you have a user in the same patch-set.

This whole idea will need a discussion with Jonathan (the IIO
Maintainer), now CC'ed.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
