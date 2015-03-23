From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 0/7] ARM: shmobile: Add IRQC clock to device tree
Date: Mon, 23 Mar 2015 10:09:41 +0000
Message-ID: <20150323100941.GM15137@io.lakedaemon.net>
References: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Geert,

On Wed, Mar 18, 2015 at 07:55:54PM +0100, Geert Uytterhoeven wrote:
> 	Hi,
> 
> This patch series adds the IRQC clock to the device tree on SoCs that
> have such a clock (r8a73a4 and r8a779x), and adds mininal runtime PM
> support to the renesas-irqc driver, to make sure the clock is enabled
> when needed by the external IRQ controller(s).
> Before, the clock was assumed enabled by the bootloader or reset state.
> 
> As usual when involving clocks, the DTS changes depend stricly on the
> driver changes. Else the clock will be disabled as assumed unused,
> breaking the boot.
> 
> This was tested on r8a73a4/ape6evm and r8a7791/koelsch.
> 
> Thanks!
> 
> Geert Uytterhoeven (7):
>   irqchip: renesas-irqc: Add more register documentation
>   irqchip: renesas-irqc: Add minimal runtime PM support
>   irqchip: renesas-irqc: Add functional clock to bindings
>   ARM: shmobile: r8a7734: Add IRQC clock to device tree
>   ARM: shmobile: r8a7790: Add IRQC clock to device tree
>   ARM: shmobile: r8a7791: Add IRQC clock to device tree
>   ARM: shmobile: r8a7794: Add IRQC clock to device tree
> 
>  .../bindings/interrupt-controller/renesas,irqc.txt |  4 +++-
>  arch/arm/boot/dts/r8a73a4.dtsi                     | 11 +++++----
>  arch/arm/boot/dts/r8a7790.dtsi                     |  9 +++++++
>  arch/arm/boot/dts/r8a7791.dtsi                     |  9 +++++++
>  arch/arm/boot/dts/r8a7794.dtsi                     |  9 +++++++
>  drivers/irqchip/irq-renesas-irqc.c                 | 28 ++++++++++++++++++----
>  include/dt-bindings/clock/r8a73a4-clock.h          |  1 +
>  include/dt-bindings/clock/r8a7790-clock.h          |  3 +++
>  include/dt-bindings/clock/r8a7791-clock.h          |  3 +++
>  include/dt-bindings/clock/r8a7794-clock.h          |  3 +++
>  10 files changed, 70 insertions(+), 10 deletions(-)

Patches 1 - 3 applied to irqchip/renesas with Simon's Reviewed-by.

I'll give it a few days in -next, then merge it into irqchip/core.  I'll leave
the branch up for you to base the rest of the series against.

thx,

Jason.
