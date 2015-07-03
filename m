From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH RFC 1/5] clk: mvebu: Add Armada 38x support for clk-cpu
Date: Fri, 3 Jul 2015 15:54:53 +0200
Message-ID: <20150703135453.GI13481@lunn.ch>
References: <1435903917-20486-1-git-send-email-gregory.clement@free-electrons.com>
 <1435903917-20486-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:33611 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754978AbbGCOBR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 Jul 2015 10:01:17 -0400
Content-Disposition: inline
In-Reply-To: <1435903917-20486-2-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

On Fri, Jul 03, 2015 at 08:11:53AM +0200, Gregory CLEMENT wrote:
> This patch first shortens the registers definition and also introduces
> difference between Armada XP value and Armada 38x value.
> 
> Then it adds specific functions for Armada 38x in order to support cpu
> freq on these SoCs.

Hi Gregory

I would suggest splitting this into two. Because of the #define
changes, it is not easy to see the new functions from #define changes.

> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |  27 ++-
>  drivers/clk/mvebu/clk-cpu.c                        | 220 ++++++++++++++++-----
>  2 files changed, 201 insertions(+), 46 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
> index 99c214660bdc..9272b3464ab1 100644
> --- a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
> @@ -1,10 +1,13 @@
>  Device Tree Clock bindings for cpu clock of Marvell EBU platforms

Maybe i'm reading the following hunk wrong, but....
  
>  Required properties:
> -- compatible : shall be one of the following:
> +- compatible : shall be the following:

"one of the following" is grammatically better.

>  	"marvell,armada-xp-cpu-clock" - cpu clocks for Armada XP
> +	"marvell,armada-38x-cpu-clock", "marvell,armada-xp-cpu-clock" - cpu
> +	clocks for Armada 38x

and don't we now have marvell,armada-xp-cpu-clock twice?

>  - reg : Address and length of the clock complex register set, followed
> -        by address and length of the PMU DFS registers
> +	by address and length of the PMU DFS registers, for Armada 38x
> +	a third register set must be addeed: DFX server.
>  - #clock-cells : should be set to 1.
>  - clocks : shall be the input parent clock phandle for the clock.
>  
> @@ -20,3 +23,23 @@ cpu@0 {
>  	reg = <0>;
>  	clocks = <&cpuclk 0>;
>  };
> +
> +or for Armada38x
> +
> +cpuclk: clock-complex@18700 {
> +	compatible = "marvell,armada-380-cpu-clock",
> +	"marvell,armada-xp-cpu-clock";
> +	reg = <0x18700 0xA0>, <0x1c054 0x40>,
> +	<0xe4260 0x8>;

Maybe this third address property could be better indented?

      Andrew
