From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v3 1/3] ARM: da850: fix infinite loop in clk_set_rate()
Date: Tue, 6 Dec 2016 19:54:44 -0600
Message-ID: <148e4d35-da65-a212-1490-c2d902dd4410@lechnology.com>
References: <1480932549-30811-1-git-send-email-bgolaszewski@baylibre.com>
 <1480932549-30811-2-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480932549-30811-2-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/05/2016 04:09 AM, Bartosz Golaszewski wrote:
> The aemif clock is added twice to the lookup table in da850.c. This
> breaks the children list of pll0_sysclk3 as we're using the same list
> links in struct clk. When calling clk_set_rate(), we get stuck in
> propagate_rate().

&emac_clk is used twice in this list as well. Shouldn't we fix it too? I 
would expect that it causes the same problem.

>
> Create a separate clock for nand, inheriting the rate of the aemif
> clock and retrieve it in the davinci_nand module.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/da850.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index e770c97..c008e5e 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -367,6 +367,11 @@ static struct clk aemif_clk = {
>  	.flags		= ALWAYS_ENABLED,
>  };
>
> +static struct clk aemif_nand_clk = {
> +	.name		= "nand",
> +	.parent		= &aemif_clk,
> +};
> +
>  static struct clk usb11_clk = {
>  	.name		= "usb11",
>  	.parent		= &pll0_sysclk4,
> @@ -537,7 +542,7 @@ static struct clk_lookup da850_clks[] = {
>  	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
>  	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
>  	CLK("ti-aemif",		NULL,		&aemif_clk),
> -	CLK(NULL,		"aemif",	&aemif_clk),
> +	CLK(NULL,		"aemif",	&aemif_nand_clk),
>  	CLK("ohci-da8xx",	"usb11",	&usb11_clk),
>  	CLK("musb-da8xx",	"usb20",	&usb20_clk),
>  	CLK("spi_davinci.0",	NULL,		&spi0_clk),
>
