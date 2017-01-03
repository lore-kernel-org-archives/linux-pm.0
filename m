From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] power: reset: add linkstation-reset driver
Date: Mon, 2 Jan 2017 21:19:10 -0800
Message-ID: <fff132e9-a178-6948-676e-6a4d24b6c4d6@gmail.com>
References: <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161227070611.14852-1-rogershimizu@gmail.com>
 <20161227070611.14852-2-rogershimizu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161227070611.14852-2-rogershimizu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Shimizu <rogershimizu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>, Sylver Bruneau <sylver.bruneau-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Herbert Valerio Riedel <hvr-mXXj517/zsQ@public.gmane.org>, Ryan Tandy <ryan-pRYBVO4bdZ33fQ9qLvQP4Q@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Roger,

On 12/26/2016 11:06 PM, Roger Shimizu wrote:
> Buffalo Linkstation / KuroBox and their variants need magic command
> sending to UART1 to power-off.
> 
> Power driver linkstation-reset implements the magic command and I/O
> routine, which come from files listed below:
>   - arch/arm/mach-orion5x/kurobox_pro-setup.c
>   - arch/arm/mach-orion5x/terastation_pro2-setup.c

Interestingly, I submitted a patch doing nearly the same thing recently
after hacking on a Buffalo Terastation Pro II two days after yours
without seeing yours:

https://lkml.org/lkml/2016/12/28/273

Some comments below.

> +
> +static void __iomem *base;
> +static unsigned long tclk;
> +static const struct reset_cfg *cfg;

How about avoiding the singletons here and pass this down from the
platform driver's private data after we (see below) also make use of a
reboot notifier?

> +
> +static void linkstation_reset(void)
> +{
> +	const unsigned divisor = ((tclk + (8 * cfg->baud)) / (16 * cfg->baud));
> +	int i;
> +
> +	pr_err("%s: triggering power-off...\n", __func__);
> +
> +	/* hijack UART1 and reset into sane state */
> +	writel(0x83, UART1_REG(LCR));
> +	writel(divisor & 0xff, UART1_REG(DLL));
> +	writel((divisor >> 8) & 0xff, UART1_REG(DLM));
> +	writel(cfg->magic[0], UART1_REG(LCR));
> +	writel(cfg->magic[1], UART1_REG(IER));
> +	writel(cfg->magic[2], UART1_REG(FCR));
> +	writel(cfg->magic[3], UART1_REG(MCR));
> +
> +	/* send the power-off command to PIC */
> +	for(i = 0; cfg->cmd[i][0] > 0; i ++) {
> +		/* [0] is size of the command; command starts from [1] */
> +		uart1_micon_send(base, &(cfg->cmd[i][1]), cfg->cmd[i][0]);
> +	}
> +}
> +
> +static int linkstation_reset_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct resource *res;
> +	struct clk *clk;
> +	char symname[KSYM_NAME_LEN];
> +
> +	const struct of_device_id *match =
> +		of_match_node(linkstation_reset_of_match_table, np);
> +	cfg = match->data;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Missing resource");
> +		return -EINVAL;
> +	}
> +
> +	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (!base) {
> +		dev_err(&pdev->dev, "Unable to map resource");
> +		return -EINVAL;
> +	}
> +
> +	/* We need to know tclk in order to calculate the UART divisor */
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "Clk missing");
> +		return PTR_ERR(clk);
> +	}
> +
> +	tclk = clk_get_rate(clk);

Does this work with the Terastation II which has not been converted to
DT yet? Is tclk available through the CLK API there?

> +
> +	/* Check that nothing else has already setup a handler */
> +	if (pm_power_off) {
> +		lookup_symbol_name((ulong)pm_power_off, symname);
> +		dev_err(&pdev->dev,
> +			"pm_power_off already claimed %p %s",
> +			pm_power_off, symname);
> +		return -EBUSY;
> +	}
> +	pm_power_off = linkstation_reset;

That seems a bit complicated, why not just assume that there will be
either this driver used, or not at all?

Also, you are supposed to register a reboot notifier to which you can
pass private context:

https://lkml.org/lkml/2016/12/28/275

As indicated in my patch series, the UART1-attached micro controller
does a lot more things that just providing reboot, which is why I chose
to move this code to a MFD driver, as the starting point before adding
support for LEDs, FAN, PWM, beeper which would be other types of devices.

Is adding support for other peripherals on your TODO as well?

Thanks!
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
