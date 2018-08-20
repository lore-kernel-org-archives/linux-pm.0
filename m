From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
Date: Mon, 20 Aug 2018 13:47:35 -0500
Message-ID: <CAL_JsqKzCySH0q=4Ly9tJBiDaW23Mz9Q0j-_qb55CcL2F5fYOA@mail.gmail.com>
References: <20180804070355.14857-1-manu@freebsd.org> <20180820111755.rzg7l2lznmbpuf2e@flea>
 <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com> <20180820140737.xmqhu5ndqzehvkql@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820140737.xmqhu5ndqzehvkql@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Emmanuel Vadot <manu@freebsd.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 20, 2018 at 9:07 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
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
> Then don't complain if we ever have to break the ABI.

My only complaint is when breaking ABIs and not being clear about
doing so. Otherwise, it is up to platform maintainers to not upset
their users (including if some of those users are FreeBSD).

> We never tested
> that hardware, never had any code running on it, and it *will* cause
> some issues. For example, the calibration data have never been used
> and how they should be represented have never been described, since no
> one ever actually tried to use it.

Then perhaps that part of the binding should be omitted for now. But I
don't see how if this works for FreeBSD how it wouldn't for Linux.

Rob
