From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 7/9] ARM: multi_v7_defconfig: Enable support for PWM
 Regulators
Date: Wed, 1 Jul 2015 13:31:46 +0100
Message-ID: <20150701123146.GK3210@x1>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
 <1435154348-28840-8-git-send-email-lee.jones@linaro.org>
 <CABxcv==J2hi0y+=s3nK_U=-jkjTW3L9jCC2JfebnWwRfpDGLAQ@mail.gmail.com>
 <20150625084204.GW15013@x1>
 <CABxcv==_YZ7BCCzfbLXYxwUL_kKLtBxOVTCvcUnvGVnrD4bVpg@mail.gmail.com>
 <20150625150255.GE23990@x1>
 <CABxcv==dWX_J_+zhqjn61QXGtxCKmK62_HEj4R7wsMAWcC=H=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33599 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbGAMbv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 08:31:51 -0400
Received: by wgck11 with SMTP id k11so35559189wgc.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2015 05:31:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABxcv==dWX_J_+zhqjn61QXGtxCKmK62_HEj4R7wsMAWcC=H=Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ajit Pal Singh <ajitpal.singh@st.com>

On Thu, 25 Jun 2015, Javier Martinez Canillas wrote:
> On Thu, Jun 25, 2015 at 5:02 PM, Lee Jones <lee.jones@linaro.org> wro=
te:
> > On Thu, 25 Jun 2015, Javier Martinez Canillas wrote:
> >> On Thu, Jun 25, 2015 at 10:42 AM, Lee Jones <lee.jones@linaro.org>=
 wrote:
> >> > On Wed, 24 Jun 2015, Javier Martinez Canillas wrote:
> >>
> >> [...]
> >>
> >> >> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/c=
onfigs/multi_v7_defconfig
> >> >> > index f632af0..6666973 100644
> >> >> > --- a/arch/arm/configs/multi_v7_defconfig
> >> >> > +++ b/arch/arm/configs/multi_v7_defconfig
> >> >> > @@ -365,6 +365,7 @@ CONFIG_REGULATOR_MAX8907=3Dy
> >> >> >  CONFIG_REGULATOR_MAX8973=3Dy
> >> >> >  CONFIG_REGULATOR_MAX77686=3Dy
> >> >> >  CONFIG_REGULATOR_PALMAS=3Dy
> >> >> > +CONFIG_REGULATOR_PWM=3Dy
> >> >>
> >> >> The current policy is to build as much as possible as a module =
in
> >> >> multi_v7_defconfig. Since this is a tristate Kconfig symbol, co=
uld you
> >> >> please change it to =3Dm ?
> >> >
> >> > I would prefer that it stays built-in.
> >> >
> >>
> >> Ok, I've no strong opinion on this. I was just mentioning what arm=
-soc
> >> maintainers prefer nowadays.
> >>
> >> May I ask what's the rationale for leaving this option built-in?
> >
> > My view is that multi_v7 is used for prototyping, testing and to
> > ensure all of the vendors are playing nice together.  Hopefully
> > vendors aren't actually releasing kernels built with this defconfig=
!
>=20
> Agreed and same for the per SoC family defconfigs, vendors should shi=
p
> kernels with a customized defconfig.

Right.

> > During testing/prototyping time; installing and messing around with
> > modules is an over-head I can do without.
>=20
> Right but my question wasn't whether multi_v7 should have the options
> as built-in or as modules. That has already been decided by the
> arm-soc maintainers who want to have as much as possible as modules.
> In fact, there have been patches posted recently to change the curren=
t
> multi_v7 options from built-in to modules.

Then I need to either stop using multi_v7 or write a pre-build script
to turn it into something useful I guess.

Thanks for the heads-up.

> Instead my question was what makes this driver special to not follow
> the current convention.

There is nothing special about this particular driver to warrant that.

> I agree that there is a trade off between having options as built-in
> or modules and I believe that is why most SoC specific defconfigs hav=
e
> the opposite policy,  that is to enable everything as built-in so one
> doesn't have to mess with modules as you said.

Precisely.

> But again, I don't have a strong opinion on this. What I think though
> is that this should be documented somewhere so the options are enable=
d
> following a documented rule instead of just whatever fits in someone
> workflow.

News of this new convention is new to me.  As I said, this driver
isn't in any way "special".  I was merely enabling it to make it
useful to everyone, rather than only people who are currently
supporting module support in their builds.  Which as a low-level guy,
I currently have no requirement for -- it just adds time, complexity
and more things to debug.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
