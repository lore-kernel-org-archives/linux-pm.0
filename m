From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] PM / OPP: add support to specify phandle of
 another node for OPP
Date: Mon, 30 Sep 2013 09:57:38 +0100
Message-ID: <20130930085738.GC19738@e106331-lin.cambridge.arm.com>
References: <1379501893-12669-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1379501893-12669-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36724 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754551Ab3I3I5p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2013 04:57:45 -0400
Content-Disposition: inline
In-Reply-To: <1379501893-12669-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Nishanth Menon <nm@ti.com>

On Wed, Sep 18, 2013 at 11:58:12AM +0100, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Currently we need to replicate the OPP entries in all the nodes even
> though they share OPPs being in the same clock domain.
> 
> Few drivers like cpufreq depend on physical cpu0 node to specify the
> OPPs and only that node is referred irrespective of the logical cpu
> accessing it. Alternatively to support cpuhotplug path, few drivers
> parse all the cpu nodes for OPPs. Instead we can specify the phandle
> of the node which contains the OPP tuples.
> 
> This patch adds support to the new property 'operating-points-phandle'
> which specifies the phandle pointing to another node which contains the
> actual OPP tuples.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>  drivers/base/power/opp.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index ef89897..a450e2f 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -708,12 +708,20 @@ struct srcu_notifier_head *opp_get_notifier(struct device *dev)
>  int of_init_opp_table(struct device *dev)
>  {
>  	const struct property *prop;
> +	struct device_node *opp_node;
>  	const __be32 *val;
>  	int nr;
>  
> -	prop = of_find_property(dev->of_node, "operating-points", NULL);
> -	if (!prop)
> +	opp_node = of_parse_phandle(dev->of_node,
> +					"operating-points-phandle", 0);

This will increment the refcount of the node pointed to.

> +	if (!opp_node) /* if no OPP phandle, search for OPPs in current node */
> +		opp_node = dev->of_node;
> +	prop = of_find_property(opp_node, "operating-points", NULL);
> +	if (!prop) {
> +		dev_warn(dev, "node %s missing operating-points property\n",
> +							opp_node->full_name);
>  		return -ENODEV;
> +	}
>  	if (!prop->value)
>  		return -ENODATA;

>From the looks of mainline the table gets parsed here, and then the node
is never used again.

At the end there should probably be an of_node_put on the opp_node (if
it's from an operating-points-phandle property).

Cheers,
Mark.
