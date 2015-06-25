From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 7/9] ARM: multi_v7_defconfig: Enable support for PWM
 Regulators
Date: Thu, 25 Jun 2015 16:02:55 +0100
Message-ID: <20150625150255.GE23990@x1>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
 <1435154348-28840-8-git-send-email-lee.jones@linaro.org>
 <CABxcv==J2hi0y+=s3nK_U=-jkjTW3L9jCC2JfebnWwRfpDGLAQ@mail.gmail.com>
 <20150625084204.GW15013@x1>
 <CABxcv==_YZ7BCCzfbLXYxwUL_kKLtBxOVTCvcUnvGVnrD4bVpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36219 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbbFYPDA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2015 11:03:00 -0400
Received: by wicnd19 with SMTP id nd19so166814429wic.1
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2015 08:02:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABxcv==_YZ7BCCzfbLXYxwUL_kKLtBxOVTCvcUnvGVnrD4bVpg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ajit Pal Singh <ajitpal.singh@st.com>

On Thu, 25 Jun 2015, Javier Martinez Canillas wrote:
> On Thu, Jun 25, 2015 at 10:42 AM, Lee Jones <lee.jones@linaro.org> wr=
ote:
> > On Wed, 24 Jun 2015, Javier Martinez Canillas wrote:
>=20
> [...]
>=20
> >> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/conf=
igs/multi_v7_defconfig
> >> > index f632af0..6666973 100644
> >> > --- a/arch/arm/configs/multi_v7_defconfig
> >> > +++ b/arch/arm/configs/multi_v7_defconfig
> >> > @@ -365,6 +365,7 @@ CONFIG_REGULATOR_MAX8907=3Dy
> >> >  CONFIG_REGULATOR_MAX8973=3Dy
> >> >  CONFIG_REGULATOR_MAX77686=3Dy
> >> >  CONFIG_REGULATOR_PALMAS=3Dy
> >> > +CONFIG_REGULATOR_PWM=3Dy
> >>
> >> The current policy is to build as much as possible as a module in
> >> multi_v7_defconfig. Since this is a tristate Kconfig symbol, could=
 you
> >> please change it to =3Dm ?
> >
> > I would prefer that it stays built-in.
> >
>=20
> Ok, I've no strong opinion on this. I was just mentioning what arm-so=
c
> maintainers prefer nowadays.
>=20
> May I ask what's the rationale for leaving this option built-in?

My view is that multi_v7 is used for prototyping, testing and to
ensure all of the vendors are playing nice together.  Hopefully
vendors aren't actually releasing kernels built with this defconfig!
During testing/prototyping time; installing and messing around with
modules is an over-head I can do without.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
