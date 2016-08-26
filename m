From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/3] soc: ti: Add ti_sci_pm_domains driver
Date: Fri, 26 Aug 2016 18:37:45 -0500
Message-ID: <57C0D2C9.1030801@ti.com>
References: <20160819235653.26355-1-nm@ti.com> <20160819235653.26355-4-nm@ti.com> <CAPDyKFooDUOPT9dP8HaW3YBO9PsX-1+96PPE7CRMyjEkra7cBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFooDUOPT9dP8HaW3YBO9PsX-1+96PPE7CRMyjEkra7cBQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,
On 08/25/2016 02:27 AM, Ulf Hansson wrote:
> + Jon
>
> [...]
>
>> +
>> +static int ti_sci_pm_domains_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *np = dev->of_node;
>> +       struct ti_sci_genpd_data *ti_sci_genpd;
>> +
>> +       ti_sci_genpd = devm_kzalloc(dev, sizeof(*ti_sci_genpd), GFP_KERNEL);
>> +       if (!ti_sci_genpd)
>> +               return -ENOMEM;
>> +
>> +       ti_sci_genpd->ti_sci = devm_ti_sci_get_handle(dev);
>> +       if (IS_ERR(ti_sci_genpd->ti_sci))
>> +               return PTR_ERR(ti_sci_genpd->ti_sci);
>> +
>> +       ti_sci_genpd->dev = dev;
>> +
>> +       INIT_LIST_HEAD(&ti_sci_genpd->pd_list);
>> +       mutex_init(&ti_sci_genpd->pd_list_mutex);
>> +
>> +       return __of_genpd_add_provider(np, of_ti_sci_genpd_xlate_onecell,
>> +                                      ti_sci_genpd);
>
> Jon Hunter are working on adding robust method to be able to remove
> initialized genpds [1].
>
> In that series we intend to remove the __of_genpd_add_provider() API,
> and instead only have of_genpd_add_provider_onecell() and
> of_genpd_add_provider_simple(). Could you please convert to use any of
> these APIs instead?

Thanks for pointing this out. I took at look at the series you've linked and the
short answer is that I see no good way to directly convert what we've done to
use those APIs.

On this platform each device has it's power state controlled through the SCI
protocol described in the cover letter. The system makes a request for powering
on or off the device using a unique ID number for each device, as provided in
patches 1 and 2. These operations map to those of a genpd, so we decided to do a
1:1 device to genpd mapping, where each device has it's own genpd.

The split that we took from the provided simple and onecell xlate functions
arises from this mapping. The IDs are not necessarily linear and also they are
not necessarily defined in a fixed way for all SoCs, they are entirely data
driven based on the provided device ID. To make use of these IDs, I created a
new xlate function that takes a onecell value but instead dynamically allocates
a new genpd, at probe time, to give us a genpd that contains the necessary SoC
specific data for that device that probed and is mapped directly to the device.
This lets us only create the genpds we need without having to redefine a static
list of all possible genpds and duplicate the data.

So my question back would be, how critical is it to be able to drop the ability
to provide custom xlate functions?

Regards,
Dave

>
> Kind regards
> Uffe
>
> [1]
> http://www.spinics.net/lists/arm-kernel/msg524151.html
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
