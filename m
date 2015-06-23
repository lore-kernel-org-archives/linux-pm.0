From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for
 ST's platforms
Date: Tue, 23 Jun 2015 09:27:59 +0100
Message-ID: <20150623082759.GF3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
 <20150623025031.GD16776@linux>
 <20150623071647.GD3245@x1>
 <20150623080309.GI16776@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35828 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbbFWI2E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 04:28:04 -0400
Received: by wiga1 with SMTP id a1so98817802wig.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 01:28:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150623080309.GI16776@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

On Tue, 23 Jun 2015, Viresh Kumar wrote:

> On 23-06-15, 08:16, Lee Jones wrote:
> > Thanks for your timely review Viresh.
>=20
> Your welcome Lee :)
>=20
> > On Tue, 23 Jun 2015, Viresh Kumar wrote:
> > > On 22-06-15, 16:43, Lee Jones wrote:
> > > > +config ARM_ST_CPUFREQ
> > > > +	bool "ST CPUFreq support"
> > >=20
> > > Isn't using ST just too generic? There are multiple SoCs ST has b=
een
> > > involved with, I have worked on a completely different series.
> > > Probably a more relative string is required here, like stih407 ?
> >=20
> > This is ST's only CPUFreq implementation and is pretty board
> > agnostic.  This particular driver only currently supports the STiH4=
07
> > family, but internally it supports some others too.  I'll have a ch=
at
> > and see if we can make it more specific somehow.
>=20
> So, SPEAr is also from ST. And it already have a driver for itself.

Sure.  I will use STI as suggested by Maxime.

> > > > +	if (!ddata->dvfs_tab_count) {
> > > > +		dev_err(&pdev->dev, "No suitable AVS table found\n");
> > >=20
> > > Why is this an error? I thought in this case you will go ahead wi=
th
> > > the normal OPP-table.
> >=20
> > I've written it so it's an error within this function, as it makes =
the
> > function fail, but is downgraded by the caller to a warning and
> > gracefully bypassed to still allow frequency scaling.
>=20
> Not that, I was asking about the print. I thought we will still try t=
o
> find OPP from the CPU node and a warning or a error might not be the
> right choice. You can surely add a debug print. Currently you are
> doing a dev_err() here, followed by a dev_warn() I think..

Okay, but the reasoning is the same.  I consider the function to have
failed, but the over-all failure culminates in just a warning that
voltage scaling has indeed failed, but we can still go on with
frequency scaling.

Unless his is a big blocker for you, I would like to keep these
semantics.

> > > So you have added new OPPs here, but cpufreq-dt will try to add o=
ld
> > > OPPs. You must be getting lots of warnings ?
> >=20
> > Yes, we recieve the 'duplicate OPPs detected' warning, but there is
> > nothing we can do about that.
>=20
> :)
>=20
> OPP-v2 will get that solved too..

I'll take another look at them to see if there is anything we can
use.

> > > > +	if (ddata->substrate < 0)
> > > > +		goto set_default;
> > >=20
> > > Maybe:
> > >=20
> > > 	if (ddata->substrate >=3D 0)
> > >                 return;
> >=20
> > 0 is a valid substrate value.
>=20
> I had >=3D in the comparison. Wasn't that right?

Oh, you reversed the condition, I see now.

> And I was just suggesting that a single return can be used instead of

So technically you are correct, but it makes the code slightly more
confusing IMHO.  Yes, it's one more line of code, but it's worth it to
add clarity.
=20
> if (xyz)
>         goto set_default;
> return;
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
