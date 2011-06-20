From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [Update][PATCH 8/8] ARM / shmobile: Support for I/O
	power domains for SH7372 (v6)
Date: Mon, 20 Jun 2011 11:01:32 +0900
Message-ID: <20110620020125.GA26125__20036.4261320376$1308535383$gmane$org@linux-sh.org>
References: <201106112223.04972.rjw@sisk.pl>
	<BANLkTi=u_eyGZt9e0CuVpyz9B08HarEyVw@mail.gmail.com>
	<201106160106.40553.rjw@sisk.pl> <201106200007.47828.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201106200007.47828.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 20, 2011 at 12:07:47AM +0200, Rafael J. Wysocki wrote:
> +static int pd_power_down(struct generic_pm_domain *genpd)
> +{
> +	struct sh7372_pm_domain *sh7372_pd = to_sh7372_pd(genpd);
> +	unsigned int mask = 1 << sh7372_pd->bit_shift;
> +
> +	if (__raw_readl(PSTR) & mask) {
> +		__raw_writel(mask, SPDCR);
> +
> +		while (__raw_readl(SPDCR) & mask)
> +			cpu_relax();
> +
> +		pr_debug("sh7372 power domain down 0x%08x -> PSTR = 0x%08x\n",
> +			 mask, __raw_readl(PSTR));
> +	}
> +
> +	return 0;
> +}
> +
> +static int pd_power_up(struct generic_pm_domain *genpd)
> +{
> +	struct sh7372_pm_domain *sh7372_pd = to_sh7372_pd(genpd);
> +	unsigned int mask = 1 << sh7372_pd->bit_shift;
> +
> +	if (!(__raw_readl(PSTR) & mask)) {
> +		__raw_writel(mask, SWUCR);
> +
> +		while (__raw_readl(SWUCR) & mask)
> +			cpu_relax();
> +
> +		pr_debug("sh7372 power domain up 0x%08x -> PSTR = 0x%08x\n",
> +			 mask, __raw_readl(PSTR));
> +	}
> +
> +	return 0;
> +}
> +
Given that these functions can return errors, it's probably more prudent
to implement some timeout logic on top of the busy loop. Hardware does
get stuck, after all.
