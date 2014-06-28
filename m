From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 07/16] ARM: mvebu: Make the CPU idle initialization
 more generic
Date: Sat, 28 Jun 2014 10:56:25 -0400
Message-ID: <20140628145625.GL23978@titan.lakedaemon.net>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
 <1403875377-940-8-git-send-email-gregory.clement@free-electrons.com>
 <53AD7C90.6080600@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56262 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaF1O4j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 28 Jun 2014 10:56:39 -0400
Content-Disposition: inline
In-Reply-To: <53AD7C90.6080600@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Gregory,

On Fri, Jun 27, 2014 at 04:15:44PM +0200, Gregory CLEMENT wrote:
> On 27/06/2014 15:22, Gregory CLEMENT wrote:
> > In order to support more mvebu SoCs, this patch use an initialization
> > specific function associated to each SoCs which support CPU Idle.
> > 
> > Then each SoC will have his own set of check and of data
> > configuration.
> > 
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > ---
> >  arch/arm/mach-mvebu/pmsu.c | 39 +++++++++++++++++++++++++++++++--------
> >  1 file changed, 31 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> > index 087157c20b8a..454f0f9ede6b 100644
> > --- a/arch/arm/mach-mvebu/pmsu.c
> > +++ b/arch/arm/mach-mvebu/pmsu.c
> > @@ -293,23 +293,47 @@ static struct notifier_block mvebu_v7_cpu_pm_notifier = {
> >  	.notifier_call = mvebu_v7_cpu_pm_notify,
> >  };
> >  
> > +static bool (*mvebu_v7_cpu_idle_init)(void);
> > +
> > +static __init bool armada_xp_cpuidle_init(void)
> > +{
> > +	struct device_node *np;
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric");
> > +	if (!np)
> > +		return false;
> > +	of_node_put(np);
> > +
> > +	mvebu_v7_cpuidle_device.dev.platform_data = armada_xp_370_cpu_suspend;
> > +	return true;
> > +}
> > +
> > +static struct of_device_id of_cpuidle_table[] __initdata = {
> > +	{ .compatible = "marvell,armadaxp",
> > +	  .data = (void *)armada_xp_cpuidle_init,
> > +	},
> > +	{ /* end of list */ },
> > +};
> > +
> >  static int __init mvebu_v7_cpu_pm_init(void)
> >  {
> >  	struct device_node *np;
> > +	const struct of_device_id *match;
> > +
> > +	np = of_find_matching_node_and_match(NULL, of_cpuidle_table,
> > +					&match);
> > +
> 
> The following part was missing (without this the kernel hang on Armada 375)
> 
> +       if (!np)
> +               return 0;

If there's no other changes, I can fix this up when I apply it.  As well
as the S-o-b.

thx,

Jason.
