From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: brcm: clocks: add binding for
 brcmstb-cpu-clk-div
Date: Sat, 21 Jan 2017 14:39:20 -0600
Message-ID: <20170121203920.ijtrpdsff24rcjgs@rob-hp-laptop>
References: <20170119002933.7529-1-code@mmayer.net>
 <20170119002933.7529-2-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170119002933.7529-2-code@mmayer.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Mayer <code@mmayer.net>
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Power Management List <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Markus Mayer <mmayer@broadcom.com>, Linux Clock List <linux-clk@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 18, 2017 at 04:29:32PM -0800, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> Add binding document for brcm,brcmstb-cpu-clk-div.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  .../bindings/clock/brcm,brcmstb-cpu-clk-div.txt    | 27 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
> new file mode 100644
> index 0000000..c4acb53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
> @@ -0,0 +1,27 @@
> +The CPU divider node serves as the sole clock for the CPU complex. It supports
> +power-of-2 clock division, with a divider of "1" as the default highest-speed
> +setting.
> +
> +Required properties:
> +- compatible: shall be "brcm,brcmstb-cpu-clk-div"
> +- reg: address and width of the divider configuration register
> +- #clock-cells: shall be set to 0
> +- clocks: phandle of clock provider which provides the source clock
> +          (this would typically be a "fixed-clock" type PLL)
> +- div-table: list of (raw_value,divider) ordered pairs that correspond to the
> +             allowed clock divider settings

Why do you need 2 values? Can't you use the index or calculate the 
register value from the divider value?

> +- div-shift-width: least-significant bit position and width of divider value
> +
> +Optional properties:
> +- clock-names: the clock may be named
> +
> +Example:
> +	cpuclkdiv: cpu-clk-div@f03e257c {

clock-controller@...

> +		compatible = "brcm,brcmstb-cpu-clk-div";
> +		reg = <0xf03e257c 0x4>;
> +		div-table = <0x00 1>;
> +		div-shift-width = <0 5>;
> +		#clock-cells = <0>;
> +		clocks = <&cpupll>;
> +		clock-names = "cpupll";
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cfff2c9..690761d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2786,6 +2786,7 @@ M:	bcm-kernel-feedback-list@broadcom.com
>  L:	linux-pm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
> +F:	Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
>  F:	drivers/cpufreq/brcmstb*
>  
>  BROADCOM SPECIFIC AMBA DRIVER (BCMA)
> -- 
> 2.7.4
> 
