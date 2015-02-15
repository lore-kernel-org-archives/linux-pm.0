From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v5 0/5] drivers: bus: Add Simple Power-Managed Bus
Date: Sun, 15 Feb 2015 10:45:57 -0500
Message-ID: <20150215154556.GD25065@verge.net.au>
References: <1423131088-7835-1-git-send-email-geert+renesas@glider.be>
 <20150211001835.GB7826@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150211001835.GB7826@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Felipe Balbi <balbi@ti.com>, Olof Johansson <olof@lixom.net>, Magnus Damm <magnus.damm@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 11, 2015 at 09:18:35AM +0900, Simon Horman wrote:
> Hi Geert,
> 
> On Thu, Feb 05, 2015 at 11:11:23AM +0100, Geert Uytterhoeven wrote:
> >         Hi all,
> > 
> > The Renesas Bus State Controller (BSC) provides an external bus for
> > connecting multiple external devices to an SoC, driving several chip
> > select lines, for e.g. NOR FLASH, Ethernet and USB.
> > On the kzm9g and ape6evm development boards, an smsc9220 Ethernet
> > controller is connnected to the BSC of an SH-Mobile AG5 (sh73a0) resp.
> > R-Mobile APE6 (r8a73a4) SoC.
> > 
> > The BSC is a fairly simple memory-mapped bus, hence a "simple-bus"
> > compatibility seems suitable.  However, the BSC is special in two
> > ways:
> >   1. It is part of a PM domain (A4S on sh73a0),
> >   2. It has a gateable functional clock (ZB).
> > Before a device connected to the BSC can be accessed, the PM domain
> > containing the BSC must be powered on, and the functional clock
> > driving the BSC must be enabled.
> > 
> > Both special properties can be described in DT in a standardized way
> > ("power-domains = <&pd_a4s>" and "clocks = <&zb_clk>", cfr. the
> > example in the DT binding documentation).  Externally connected
> > devices are described as children of the BSC node.
> > 
> > Unfortunately this doesn't mean everything will work out-of-the-box.
> > There are two problems:
> >   1. Without a device driver bound to the bus device, this device is
> >      not attached to the PM domain. And although a child device is
> >      present and active, the PM domain may be powered down, as it's
> >      considered unused by the PM domain core.
> >   2. Without a device driver calling pm_runtime_enable(), its
> >      functional clock is not enabled. Once runtime PM is enabled, the
> >      R-Mobile PM domain platform driver manages the functional clock
> >      using runtime PM.
> > 
> > As none of the above is really bus hardware-specific (PM domains and
> > functional clocks in clock domains are handled from genpd and platform
> > code), this series adds a Simple Power-Managed Bus driver for
> > transparent busses, which matches against "simple-pm-bus", enables
> > runtime PM for the bus device, and calls of_platform_populate() to
> > probe for child devices.
> > Due to the child-parent relationship of devices connected to the bus,
> > as long as the device drivers for the child devices are runtime PM
> > enabled, the bus's PM domain will be powered, and the bus's clock will
> > be enabled automatically when needed, for both runtime PM and s2ram.
> > 
> > This was tested on sh73a0/kzm9g-multiplatform (by me), and (v3) on
> > r8a73a4/ape6evm-multiplatform (by Ulrich Hecht). Without this,
> > Ethernet doesn't work, as the ZB clock is disabled by
> > clk_disable_unused().
> > 
> > Felipe: It looks like drivers/usb/musb/musb_am335x.c can be removed, if
> > "ti,am33xx-usb" claims compatibility with "simple-pm-bus"?
> > 
> > As drivers/bus doesn't have a maintainer, and this driver is needed to
> > move two shmobile platforms away from legacy to multiplatform, I think
> > this can go in through Simon's shmobile tree.
> 
> thanks for persisting with this. From my point of view it appears
> to be reviewed and ready.
> 
> Does anyone object to me queueing this up for v3.21 in the renesas tree?
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

As no one has objected and it seems has been thoroughly reviewed
I have queued this up in the renesas tree.

It is part of the renesas-devel-20150215-v3.19 tag.

[snip]
