From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 9/9] ARM: zynq: Rename 'zynq_platform_cpu_die'
Date: Thu, 21 Aug 2014 12:02:35 -0700
Message-ID: <9c7c26e1-4098-4252-a719-fb7b7205be61@BN1AFFO11FD006.protection.gbl>
References: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408567315-28479-10-git-send-email-soren.brinkmann@xilinx.com>
 <4ac42f4d-72bf-4a8d-a997-094f129d7c74@BN1AFFO11FD020.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4ac42f4d-72bf-4a8d-a997-094f129d7c74@BN1AFFO11FD020.protection.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Russell King <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2014-08-21 at 02:28PM +0200, Michal Simek wrote:
> On 08/20/2014 10:41 PM, Soren Brinkmann wrote:
> > Match the naming pattern of all other SMP ops and rename
> > zynq_platform_cpu_die --> zynq_cpu_die.
> >=20
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >  arch/arm/mach-zynq/platsmp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/plat=
smp.c
> > index 04e578718aa2..95933c5e70e1 100644
> > --- a/arch/arm/mach-zynq/platsmp.c
> > +++ b/arch/arm/mach-zynq/platsmp.c
> > @@ -138,7 +138,7 @@ static int zynq_cpu_kill(unsigned cpu)
> >   *
> >   * Called with IRQs disabled
> >   */
> > -static void zynq_platform_cpu_die(unsigned int cpu)
> > +static void zynq_cpu_die(unsigned int cpu)
> >  {
> >  	zynq_slcr_cpu_state_write(cpu, true);
> > =20
> > @@ -158,7 +158,7 @@ struct smp_operations zynq_smp_ops __initdata =3D=
 {
> >  	.smp_boot_secondary	=3D zynq_boot_secondary,
> >  	.smp_secondary_init	=3D zynq_secondary_init,
> >  #ifdef CONFIG_HOTPLUG_CPU
> > -	.cpu_die		=3D zynq_platform_cpu_die,
> > +	.cpu_die		=3D zynq_cpu_die,
> >  	.cpu_kill		=3D zynq_cpu_kill,
> >  #endif
> >  };
>=20
> Will be good if you can move fix that kernel-doc format for this func=
tion
> too. It is just nice to have thing.

All these SMP-ops should be documented in the header defining that
struct, shouldn't they?

	S=C3=B6ren
