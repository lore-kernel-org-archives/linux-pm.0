From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [RFC PATCH v5 1/4] cpufreq: Add a cpufreq driver for Marvell
 Dove
Date: Thu, 19 Dec 2013 22:32:57 -0500
Message-ID: <20131220033257.GF2609@titan.lakedaemon.net>
References: <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
 <1387316473-3250-1-git-send-email-andrew@lunn.ch>
 <1387316473-3250-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43960 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab3LTDdJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2013 22:33:09 -0500
Content-Disposition: inline
In-Reply-To: <1387316473-3250-2-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: mark.rutland@arm.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

On Tue, Dec 17, 2013 at 10:41:10PM +0100, Andrew Lunn wrote:
> The Marvell Dove SoC can run the CPU at two frequencies. The high
> frequencey is from a PLL, while the lower is the same as the DDR
> clock. Add a cpufreq driver to swap between these frequences.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Sort header files
> Remove unneeded header files
> Notify only on change
> Use get_cpu_device(0), devm_clk_get()
> Use platform_get_resource_byname()
> Error check clk_prepare_enable()
> Comment the interrupt handler
> 
> rebase onto 3.13-rc2 linux-next
> use target_index
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-dove.txt   |  23 ++
>  drivers/cpufreq/Kconfig.arm                        |   5 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/dove-cpufreq.c                     | 265 +++++++++++++++++++++
>  4 files changed, 294 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-dove.txt
>  create mode 100644 drivers/cpufreq/dove-cpufreq.c
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-dove.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-dove.txt
> new file mode 100644
> index 000000000000..f95cc2234fc1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-dove.txt
> @@ -0,0 +1,23 @@
> +Dove cpufreq driver
> +-------------------
> +
> +The Dove cpufreq driver makes use of the pmu node in the device tree.

I would prefer to reword this to make it OS-agnostic.  The cpufreq
driver is Linux-specific.

> +
> +Required properties:
> +- compatibility: Must be "marvell,dove-pmu"
> +- interrupts:	 Interrupt to know the completion of cpu frequency change.
> +- clocks:	 phandles and clock specifiers pairs for CPU and DDR clock
> +- clock-names: 	 "cpu" and "ddr"
> +- reg: 		 Address ranges of the PMU. Two ranges are expected.

Shall we define the two ranges?

> +
> +Example:
> +
> +	pmu: pmu@d0000 {
> +		compatible = "marvell,dove-pmu";
> +		reg = <0xd0000 0x0700>,
> +		      <0xd8000 0x0140>;
> +		clocks = <&core_clk 1>, <&core_clk 3>;
> +		clock-names = "cpu", "ddr";
> +		interrupt-parent = <&pmu_intc>;
> +		interrupts = <0>;
> +	};

thx,

Jason.
