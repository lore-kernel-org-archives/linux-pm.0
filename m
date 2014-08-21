From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 1/9] ARM: zynq: PM: Enable A9 internal clock gating
 feature
Date: Thu, 21 Aug 2014 10:20:17 -0700
Message-ID: <7df25bc3-d1ea-405c-a880-b22b53225ec6@BN1BFFO11FD018.protection.gbl>
References: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408567315-28479-2-git-send-email-soren.brinkmann@xilinx.com>
 <26994133-6c3c-45c0-af09-3cb55ad35b13@BY2FFO11FD028.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1blp0189.outbound.protection.outlook.com ([207.46.163.189]:18823
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753288AbaHURUc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Aug 2014 13:20:32 -0400
Content-Disposition: inline
In-Reply-To: <26994133-6c3c-45c0-af09-3cb55ad35b13@BY2FFO11FD028.protection.gbl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Russell King <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On Thu, 2014-08-21 at 02:19PM +0200, Michal Simek wrote:
> On 08/20/2014 10:41 PM, Soren Brinkmann wrote:
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >  arch/arm/mach-zynq/common.c  |  6 ++++++
> >  arch/arm/mach-zynq/common.h  | 11 +++++++++++
> >  arch/arm/mach-zynq/platsmp.c |  9 +++++++++
> >  3 files changed, 26 insertions(+)
> >=20
> > diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/commo=
n.c
> > index 31a6fa40ba37..3cb7c198615a 100644
> > --- a/arch/arm/mach-zynq/common.c
> > +++ b/arch/arm/mach-zynq/common.c
> > @@ -98,6 +98,11 @@ static int __init zynq_get_revision(void)
> >  	return revision;
> >  }
> > =20
> > +static void __init zynq_init_late(void)
> > +{
> > +	zynq_core_pm_init();
> > +}
> > +
> >  /**
> >   * zynq_init_machine - System specific initialization, intended to=
 be
> >   *		       called from board specific initialization.
> > @@ -204,6 +209,7 @@ DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Pla=
tform")
> >  	.map_io		=3D zynq_map_io,
> >  	.init_irq	=3D zynq_irq_init,
> >  	.init_machine	=3D zynq_init_machine,
> > +	.init_late	=3D zynq_init_late,
> >  	.init_time	=3D zynq_timer_init,
> >  	.dt_compat	=3D zynq_dt_match,
> >  	.reserve	=3D zynq_memory_init,
> > diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/commo=
n.h
> > index f652f0a884a6..596ef0b5067c 100644
> > --- a/arch/arm/mach-zynq/common.h
> > +++ b/arch/arm/mach-zynq/common.h
> > @@ -40,4 +40,15 @@ extern void __iomem *zynq_scu_base;
> >  /* Hotplug */
> >  extern void zynq_platform_cpu_die(unsigned int cpu);
> > =20
> > +static inline void zynq_core_pm_init(void)
> > +{
> > +	/* A9 clock gating */
> > +	asm volatile ("mrc  p15, 0, r12, c15, c0, 0\n"
> > +		      "orr  r12, r12, #1\n"
> > +		      "mcr  p15, 0, r12, c15, c0, 0\n"
> > +		      : /* no outputs */
> > +		      : /* no inputs */
> > +		      : "r12");
> > +}
> > +
> >  #endif
> > diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/plat=
smp.c
> > index abc82ef085c1..616b99e07c60 100644
> > --- a/arch/arm/mach-zynq/platsmp.c
> > +++ b/arch/arm/mach-zynq/platsmp.c
> > @@ -112,6 +112,14 @@ static void __init zynq_smp_prepare_cpus(unsig=
ned int max_cpus)
> >  	scu_enable(zynq_scu_base);
> >  }
> > =20
> > +/*
> > + * This function is in the hotplug path. Don't move it into the in=
it section!!
> > + */
>=20
> Worth to use kernel-doc format here.

The secondary init function is kind of documented in
arch/arm/include/asm/smp.h as part of the smp_operations struct. Do you
want more documentation here?
=09
	S=C3=B6ren

