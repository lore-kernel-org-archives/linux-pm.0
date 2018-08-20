From: Emmanuel Vadot <manu@bidouilliste.com>
Subject: Re: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
Date: Mon, 20 Aug 2018 15:57:57 +0200
Message-ID: <20180820155757.7f393d75fdbe55610efff0c1@bidouilliste.com>
References: <20180804070355.14857-1-manu@freebsd.org>
        <20180820111755.rzg7l2lznmbpuf2e@flea>
        <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Mark Rutland <mark.rutland@arm.com>, Eduardo Valentin <edubezval@gmail.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Emmanuel Vadot <manu@freebsd.org>, Chen-Yu Tsai <wens@csie.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 20 Aug 2018 07:41:22 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Mon, Aug 20, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> > > This patch adds documentation for Device-Tree bindings for the Allwinner
> > > Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> > >
> > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> >
> > I'm not going to merge a binding for a device that doesn't have any
> > driver implemented at the moment in Linux.
> 
> I'll take it then. Linux is not the only DT client.
> 
> Rob

 Thanks Rob, I'll send a V2 shortly with the modification you asked and
some minor others documentation corrections.

-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
