From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
Date: Mon, 17 Mar 2014 17:44:10 -0300
Message-ID: <20140317204410.GA1118@arch.cereza>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
 <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
 <20140316070917.GA3094@arch.cereza>
 <CADHgK6s58EJyJxB-47K8w26H8ZCBFQ2zu7PGAQU9O+2g7=fPwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60584 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751227AbaCQUob (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Mar 2014 16:44:31 -0400
Content-Disposition: inline
In-Reply-To: <CADHgK6s58EJyJxB-47K8w26H8ZCBFQ2zu7PGAQU9O+2g7=fPwA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Jonathan Austin <jonathan.austin@arm.com>, Victor Kamensky <victor.kamensky@linaro.org>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Laura Abbott <lauraa@codeaurora.org>, Sricharan R <r.sricharan@ti.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Russ Dill <Russ.Dill@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>

On Mar 17, Sebastian Capella wrote:
> On 16 March 2014 00:09, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> > On Mar 05, Sebastian Capella wrote:
> > [..]
> >> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> >> index 1f8fed9..83707702 100644
> >> --- a/arch/arm/mm/Kconfig
> >> +++ b/arch/arm/mm/Kconfig
> >> @@ -611,6 +611,11 @@ config CPU_USE_DOMAINS
> >>  config IO_36
> >>       bool
> >>
> >> +config ARCH_HIBERNATION_POSSIBLE
> ...
> >> +     default y if CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || CPU=
_XSCALE || CPU_XSC3 || CPU_V6 || CPU_V6K || CPU_V7
> ...
> > Is there any reason why CPU_FEROCEON is not listed here? FWIW, I've=
 just built
> > (but not really tested) a Kirkwood kernel with CONFIG_HIBERNATION=3D=
y.
> No reason; I did not change this from the original patch I'd received=
=2E
>  I didn't try to get a comprehensive list of supported hardware.  To
> my understanding, the goal is to get the infrastructure in so that
> people can start working on their platforms and add support for them.
>=20

Sure, no problem. If you consider that build-test is enough, feel free =
to put
CPU_FEROCEON on that list. We added suspend/resume to feroceon not long=
 ago.

> > And is there any reason to put this config in arch/arm/mm/Kconfig, =
instead of
> > in arch/arm/Kconfig, below ARCH_SUSPEND_POSSIBLE?
> I don't have a reason.  Anyone else have a comment on this?
> Otherwise, I'll move it.. thanks!
>

It looked reasonable to me.

> > I'm also puzzled about having two separate options for suspend and =
hibernate,
> > maybe someone can explain me why a given CPU would support the form=
er but not
> > the latter?
> It's part of having the generic hibernation implemented and available
> but with architecture specific dependencies.  Where an architecture
> may not have support for hibernation, it will prevent compilation of
> the generic hibernation support.  For example, at the moment, ARM doe=
s
> not support hibernation.
[..]

I guess my question wasn't clear. I mean to ask: Are there any other
requirements on an ARM platform to support hibernation, other than
suspend/resume support?

If this is the *only* requirement, it seems to me we could make our
ARCH_SUSPEND_POSSIBLE also select ARCH_HIBERNATION_POSSIBLE.

Does this make sense?
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
