From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH v12 2/5] of/irq: Adjust of_pci_irq parsing for
 multiple interrupts
Date: Tue, 26 Dec 2017 09:48:11 -0600
Message-ID: <CAL_JsqL8nztgA0RWw5f_H75T4iVEDt23poUXb_RsL+jWmQ-X6w@mail.gmail.com>
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com> <20171226023646.17722-3-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171226023646.17722-3-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Shawn Lin <shawn.lin@rock-chips.com>, Brian Norris <briannorris@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Anderson <dianders@chromium.org>, Frank Rowand <frowand.list@gmail.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 25, 2017 at 8:36 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Currently we are considering the first irq as the PCI interrupt pin,
> but a PCI device may have multiple interrupts(e.g. PCIe WAKE# pin).
>
> Only parse the PCI interrupt pin when the irq is unnamed or named as
> "pci".
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
> Changes in v13: None
> Changes in v12: None
> Changes in v11:
> Address Brian's comments.
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
>  drivers/of/of_pci_irq.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
> index 3a05568f65df..d39565d5477b 100644
> --- a/drivers/of/of_pci_irq.c
> +++ b/drivers/of/of_pci_irq.c
> @@ -27,9 +27,25 @@ int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq
>          */
>         dn = pci_device_to_OF_node(pdev);
>         if (dn) {
> -               rc = of_irq_parse_one(dn, 0, out_irq);
> -               if (!rc)
> -                       return rc;
> +               struct property *prop;
> +               const char *name;
> +               int index = 0;
> +
> +               of_property_for_each_string(dn, "interrupt-names", prop, name) {
> +                       if (!strcmp(name, "pci"))
> +                               break;
> +                       index++;
> +               }
> +
> +               /*
> +                * Only parse from DT if we have no "interrupt-names",
> +                * or if we found an interrupt named "pci".
> +                */
> +               if (index == 0 || name) {
> +                       rc = of_irq_parse_one(dn, index, out_irq);
> +                       if (!rc)
> +                               return rc;
> +               }

As mentioned before, use of_property_match_string. The following should work:

index = of_property_match_string(dn, "interrupt-names", "pci");
if (index == -EINVAL)  /* Property doesn't exist */
  index = 0;

if (index >= 0) {
  rc = of_irq_parse_one(dn, index, out_irq);
  if (!rc)
    return rc;
}


>         }
>
>         /* Ok, we don't, time to have fun. Let's start by building up an
> --
> 2.11.0
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
