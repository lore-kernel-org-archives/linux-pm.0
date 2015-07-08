From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: mediatek: Add MT8173 cpufreq driver
 binding
Date: Wed, 8 Jul 2015 16:49:00 +0530
Message-ID: <20150708111900.GD1805@linux>
References: <1435717005-20012-1-git-send-email-pi-cheng.chen@linaro.org>
 <1435717005-20012-2-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435717005-20012-2-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 01-07-15, 10:16, Pi-Cheng Chen wrote:
> This patch adds device tree binding document for MT8173 cpufreq driver.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Reviewed-by: Michael Turquette <mturquette@baylibre.com>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-mt8173.txt | 145 +++++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
> new file mode 100644
> index 0000000..65701c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt
> @@ -0,0 +1,145 @@
> +
> +Mediatek MT8173 cpufreq driver
> +------------------------------
> +
> +Mediatek MT8173 cpufreq driver for CPU frequency scaling.
> +
> +Required properties:
> +- clocks: A list of phandle + clock-specifier pairs for the clocks listed in clock names.
> +- clock-names: Should contain the following:
> +	"cpu"		- The multiplexer for clock input of CPU cluster.
> +	"intermediate"	- A parent of "cpu" clock which is used as "intermediate" clock
> +			  source (usually MAINPLL) when the original CPU PLL is under
> +			  transition and not stable yet.
> +	Please refer to Documentation/devicetree/bindings/clk/clock-bindings.txt for
> +	generic clock consumer properties.

Don't have any intentions to halt this series anymore, I have
irritated you enough already :)

But, what about moving these bindings in something like a clock
driver?

@Mike: ?

I am asking because these really belong to the clock driver, as I
understood it from Mike. And clearly asked me to not take care of such
things in cpufreq core/drivers.

Another reason is that, later you will kill this driver one day and
use cpufreq-dt. And then you will be required to move these bindings
to a clock driver, as these will stay.

-- 
viresh
