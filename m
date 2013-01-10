From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH v2 2/2] ARM: imx: enable imx6q-cpufreq support
Date: Thu, 10 Jan 2013 10:50:25 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDF7BF@DBDE01.ent.ti.com>
References: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
 <1357806863-6899-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58706 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab3AJKu7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jan 2013 05:50:59 -0500
In-Reply-To: <1357806863-6899-3-git-send-email-shawn.guo@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>

Hi,

On Thu, Jan 10, 2013 at 14:04:23, Shawn Guo wrote:
> Update operating-points per hardware document and add support for
> 1 GHz and 1.2 GHz frequencies.
> 
> 400 MHz, 800 MHz and 1 GHz should be supported by all i.MX6Q chips,
> while 1.2 GHz support needs to know from OTP fuse bit.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx6q.dtsi   |   19 ++++++++----
>  arch/arm/mach-imx/mach-imx6q.c |   65 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index d6265ca..17c5618 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -38,12 +38,18 @@
>  			next-level-cache = <&L2>;
>  			operating-points = <
>  				/* kHz    uV */
> -				792000  1100000
> +				996000  1250000
> +				792000  1150000
>  				396000  950000
> -				198000  850000
>  			>;

[...]

>  
> +#define OCOTP_CFG3			0x440
> +#define OCOTP_CFG3_SPEED_SHIFT		16
> +#define OCOTP_CFG3_SPEED_1P2GHZ		0x3
> +
> +static void __init imx6q_opp_check_1p2ghz(struct device *cpu_dev)
> +{
> +	struct device_node *np;
> +	void __iomem *base;
> +	u32 val;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-ocotp");
> +	if (!np) {
> +		pr_warn("failed to find ocotp node\n");
> +		return;
> +	}
> +
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		pr_warn("failed to map ocotp\n");
> +		goto put_node;
> +	}
> +
> +	val = readl_relaxed(base + OCOTP_CFG3);
> +	val >>= OCOTP_CFG3_SPEED_SHIFT;
> +	if ((val & 0x3) == OCOTP_CFG3_SPEED_1P2GHZ)
> +		if (opp_add(cpu_dev, 1200000000, 1275000))
> +			pr_warn("failed to add 1.2 GHz operating point\n");
> +

I just happened to be thinking about the problem of enabling additional OPPs based on
some Si rev info for TI's AM335x. 

The other approach could be to register additional OPPs and mark then as disabled to begin with.
A platform specific hook could then be used to selectively enable the OPPs for based on the Si rev
info.

If this approach was already discussed sorry for the noise.

Regards,
Vaibhav 

