From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 4/4] mvebu: Dove: Add clocks and DFS interrupt to
 cpu node in DT.
Date: Wed, 4 Dec 2013 09:43:07 -0500
Message-ID: <20131204144307.GM29282@titan.lakedaemon.net>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
 <1386166641-7567-5-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23846 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932178Ab3LDOnU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2013 09:43:20 -0500
Content-Disposition: inline
In-Reply-To: <1386166641-7567-5-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux-pm@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 04, 2013 at 03:17:21PM +0100, Andrew Lunn wrote:
> The dove-cpufreq driver needs access to the DDR and CPU clock.  There
> is also an interrupt generated when the DFS hardware completes a
> change of frequencey. Add these to the cpu node in DT.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  arch/arm/boot/dts/dove.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 4c8028513133..3842ba02dddf 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -22,6 +22,10 @@
>  			device_type = "cpu";
>  			next-level-cache = <&l2>;
>  			reg = <0>;
> +			clocks = <&core_clk 1>, <&core_clk 3>;

This isn't a blocker by any means, but does anyone have on their TODO
list a DT include file of macros for the clocks? So this would become:

			clocks = <&core_clk DOVE_CPU_CLK>, <&core_clk DOVE_DDRCLK>;

or similar?

If not, would it be considered useful?

thx,

Jason.

> +			clock-names = "cpu_clk", "ddrclk";
> +			interrupt-parent = <&pmu_intc>;
> +			interrupts = <0>;
>  		};
>  	};
>  
> -- 
> 1.8.5
> 
