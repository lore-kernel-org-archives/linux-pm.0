From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH v10 2/7] of/irq: Adjust of_pci_irq parsing for
 multiple interrupts
Date: Fri, 27 Oct 2017 14:33:38 -0700
Message-ID: <20171027213337.GB105121@google.com>
References: <20171027072612.26565-1-jeffy.chen@rock-chips.com>
 <20171027072612.26565-3-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171027072612.26565-3-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Jeffy,

On Fri, Oct 27, 2017 at 03:26:07PM +0800, Jeffy Chen wrote:
> Currently we are considering the first irq as the PCI interrupt pin,
> but a PCI device may have multiple interrupts(e.g. PCIe WAKE# pin).
> 
> Only parse the PCI interrupt pin when the irq is unnamed or named as
> "pci".
> 
> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v10: None
> Changes in v9: None
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/of/of_pci_irq.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
> index 3a05568f65df..8b69211f0b88 100644
> --- a/drivers/of/of_pci_irq.c
> +++ b/drivers/of/of_pci_irq.c
> @@ -27,7 +27,18 @@ int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq
>  	 */
>  	dn = pci_device_to_OF_node(pdev);
>  	if (dn) {
> -		rc = of_irq_parse_one(dn, 0, out_irq);
> +		struct property *prop;
> +		const char *name;
> +		int index = 0;
> +
> +		prop = of_find_property(dn, "interrupt-names", NULL);
> +		for (name = of_prop_next_string(prop, NULL); name;
> +		     name = of_prop_next_string(prop, name), index++) {
> +			if (!strcmp(name, "pci"))
> +				break;
> +		}

You seem to have expanded of_property_for_each_string(). You could also
do this more clearly with:

		of_property_for_each_string(dn, "interrupt-names", prop, name) {
			if (!strcmp(name, "pci"))
				break;
			index++;
		}

> +
> +		rc = of_irq_parse_one(dn, index, out_irq);
>  		if (!rc)
>  			return rc;

Suppose you provide a "wakeup" interrupt but no "pci" interrupt: are you
sure you're properly falling back to the tree-walking INTx discovery? At
this point, 'index' will be out of bounds, so I guess you rely on
of_irq_parse_one(dn, OUT_OF_BOUNDS, out_irq) returning an error?

It seems like you could also be sure to skip the IRQ parsing in that
case by writing this:

		/*
		 * Only parse from DT if we have no "interrupt-names",
		 * or if we found an interrupt named "pci".
		 */
		if (index == 0 || name) {
			rc = of_irq_parse_one(dn, index, out_irq);
			if (!rc)
				return rc;
		}

Brian

>  	}
> -- 
> 2.11.0
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
