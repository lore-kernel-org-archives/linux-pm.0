From: Emmanuel Vadot <manu@bidouilliste.com>
Subject: Re: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
Date: Mon, 20 Aug 2018 16:27:15 +0200
Message-ID: <20180820162715.49e6d8a469ece983f3c1d288@bidouilliste.com>
References: <20180804070355.14857-1-manu@freebsd.org>
        <20180820111755.rzg7l2lznmbpuf2e@flea>
        <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
        <20180820140737.xmqhu5ndqzehvkql@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820140737.xmqhu5ndqzehvkql@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eduardo Valentin <edubezval@gmail.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Emmanuel Vadot <manu@freebsd.org>, Chen-Yu Tsai <wens@csie.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 20 Aug 2018 16:07:37 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Mon, Aug 20, 2018 at 07:41:22AM -0600, Rob Herring wrote:
> > On Mon, Aug 20, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> > > > This patch adds documentation for Device-Tree bindings for the Allwinner
> > > > Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> > > >
> > > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > >
> > > I'm not going to merge a binding for a device that doesn't have any
> > > driver implemented at the moment in Linux.
> > 
> > I'll take it then. Linux is not the only DT client.
> 
> Then don't complain if we ever have to break the ABI. We never tested
> that hardware, never had any code running on it, and it *will* cause
> some issues. For example, the calibration data have never been used
> and how they should be represented have never been described, since no
> one ever actually tried to use it.
> 
> And sure, Linux is not the only DT client. Just like FreeBSD isn't.
> 
> Maxime

 Maxime,

 What kind of data would you need for me to make things better ?
 We have the driver in FreeBSD for almost two years now, whne I started
to see how to upstream it I noticed a lot of problems and spent 4 or 5
days to try on all the SoCs mentionned in the serie, the only SoC I
didn't include it the A83T as for some reason I couldn't make the
driver work.
 I just hope that you understand that we cannot wait for Linux to have
a driver to have some bindings.

 Cheers,

-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
