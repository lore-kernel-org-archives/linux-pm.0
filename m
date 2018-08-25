From: Emmanuel Vadot <manu@bidouilliste.com>
Subject: Re: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
Date: Sat, 25 Aug 2018 17:43:52 +0200
Message-ID: <20180825174352.68de8a2720f4c91b987be914@bidouilliste.com>
References: <20180804070355.14857-1-manu@freebsd.org>
        <20180820111755.rzg7l2lznmbpuf2e@flea>
        <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
        <20180820140737.xmqhu5ndqzehvkql@flea>
        <20180820162715.49e6d8a469ece983f3c1d288@bidouilliste.com>
        <20180824145840.isdcg3fr6mw4ntzg@flea>
        <20180824215921.59d060b54eb3a1e7d1552bde@bidouilliste.com>
        <20180824230338.GA19399@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824230338.GA19399@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, "open list:THERMAL" <linux-pm@vger.kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Emmanuel Vadot <manu@freebsd.org>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


 Hi,

On Fri, 24 Aug 2018 16:03:40 -0700
Eduardo Valentin <edubezval@gmail.com> wrote:

> On Fri, Aug 24, 2018 at 09:59:21PM +0200, Emmanuel Vadot wrote:
> > 
> >  Hi,
> > 
> > On Fri, 24 Aug 2018 16:58:40 +0200
> > Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > 
> > > Hi,
> > > 
> > > On Mon, Aug 20, 2018 at 04:27:15PM +0200, Emmanuel Vadot wrote:
> > > > On Mon, 20 Aug 2018 16:07:37 +0200
> > > > Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > 
> > > > > On Mon, Aug 20, 2018 at 07:41:22AM -0600, Rob Herring wrote:
> > > > > > On Mon, Aug 20, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > >
> > > > > > > On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> > > > > > > > This patch adds documentation for Device-Tree bindings for the Allwinner
> > > > > > > > Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> > > > > > > >
> > > > > > > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > > > > > >
> > > > > > > I'm not going to merge a binding for a device that doesn't have any
> > > > > > > driver implemented at the moment in Linux.
> > > > > > 
> > > > > > I'll take it then. Linux is not the only DT client.
> > > > > 
> > > > > Then don't complain if we ever have to break the ABI. We never tested
> > > > > that hardware, never had any code running on it, and it *will* cause
> > > > > some issues. For example, the calibration data have never been used
> > > > > and how they should be represented have never been described, since no
> > > > > one ever actually tried to use it.
> > > > > 
> > > > > And sure, Linux is not the only DT client. Just like FreeBSD isn't.
> > > > 
> > > >  What kind of data would you need for me to make things better ?
> > > >  We have the driver in FreeBSD for almost two years now, whne I started
> > > > to see how to upstream it I noticed a lot of problems and spent 4 or 5
> > > > days to try on all the SoCs mentionned in the serie, the only SoC I
> > > > didn't include it the A83T as for some reason I couldn't make the
> > > > driver work.
> > > 
> > > Do you have a link to that driver? 
> > 
> >  https://github.com/freebsd/freebsd/blob/master/sys/arm/allwinner/aw_thermal.c
> > 
> > > How and how much did you test it?
> > 
> >  Using a cheap IR thermometer as it's all I can afford.
> >  Then running multiples cpufreq-a53 process and comparing the result.
> >  Did the same without using the calibration data, result where closer
> > when I used them.
> > 
> > > Are you using the calibration data stored in the SID?
> > 
> >  Yes, which is why the serie contain the nvmem cell for the SID.
> > 
> > > 
> > > > I just hope that you understand that we cannot wait for Linux to
> > > > have a driver to have some bindings.
> > > 
> > > Just like I'm sure you can understand that just merging the DT bits
> > > without testing anything caused some troubles in the past, and I don't
> > > want to discover it in a year from now.
> > 
> >  I do, I don't like wrong DT info as much as you do I think. I had
> > the unfortunate event to find that the sun4i-a10-timer compatible used
> > in every soc is plain wrong for !A10 and !A13, patches comming soon.
> >  I want those bits merged but I also want that they reflect reality,
> > this is not a hard driver to do, NetBSD also have one I think, maybe
> > OpenBSD do to.
> 
> 
> I would prefer to see a series of DT bindings + driver. Can you send
> your next iteration with the driver so we can review both together?

 You mean a link to the FreeBSD driver (and OpenBSD since they have one
too) in the cover letter ?

> > 
> > > Maxime
> > > 
> > > -- 
> > > Maxime Ripard, Bootlin
> > > Embedded Linux and Kernel engineering
> > > https://bootlin.com
> > 
> > 
> > -- 
> > Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
