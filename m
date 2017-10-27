From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v8 4/7] of/irq: Adjust of pci irq parsing for
 multiple interrupts
Date: Fri, 27 Oct 2017 09:38:12 -0500
Message-ID: <20171027143812.5i4vathfjpgld7wk@rob-hp-laptop>
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
 <20171026132840.20946-5-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171026132840.20946-5-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com, linux-pm@vger.kernel.org, tony@atomide.com, shawn.lin@rock-chips.com, briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 26, 2017 at 09:28:37PM +0800, Jeffy Chen wrote:
> Currently we are considering the first irq as the PCI interrupt pin,
> but a pci device may have multiple interrupts(e.g. PCIe WAKE# pin).
> 
> Only parse the PCI interrupt pin when the irq is unnamed or named as
> "pci".
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
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

Use of_property_match_string

> +		}
> +
> +		rc = of_irq_parse_one(dn, index, out_irq);
>  		if (!rc)
>  			return rc;
>  	}
> -- 
> 2.11.0
> 
> 
