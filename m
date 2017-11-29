From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC V7 1/2] OPP: Allow OPP table to be used for power-domains
Date: Wed, 29 Nov 2017 10:46:09 -0600
Message-ID: <CAL_JsqJr9pTkwODqxc1CKRv-zNr3B_kfy4U0g6imaV67oaca4A@mail.gmail.com>
References: <cover.1509453284.git.viresh.kumar@linaro.org> <2b244ea0a09deaf50237fb8b7578273a8284499e.1509453284.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2b244ea0a09deaf50237fb8b7578273a8284499e.1509453284.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 31, 2017 at 7:47 AM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Power-domains can also have their active states and this patch enhances
> the OPP binding to define those.
>
> The power domains can use the OPP bindings mostly as is. Though there
> are some changes required to support special cases:
>
> - Allow "operating-points-v2" to contain multiple phandles for power
>   domain providers providing multiple domains.
>
> - A new property "power-domain-opp" is added for devices to specify the
>   minimum required OPP of the master domain for the functioning of the
>   device. We can add this property directly to device's node if the
>   device has a fixed minimum OPP requirement from the master power
>   domain. Or we can add this property to each OPP node of the device, if
>   different OPP nodes have different minimum OPP requirement from the
>   master power domain.
>
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt      | 12 +++++
>  .../devicetree/bindings/power/power_domain.txt     | 62 ++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 9d733af26be7..203e09fe7698 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -45,6 +45,11 @@ Devices supporting OPPs must set their "operating-points-v2" property with
>  phandle to a OPP table in their DT node. The OPP core will use this phandle to
>  find the operating points for the device.
>
> +This can contain more than one phandle for power domain providers that provide
> +multiple power domains. That is, one phandle for each power domain. If only one
> +phandle is available, then the same OPP table will be used for all power domains
> +provided by the power domain provider.
> +
>  If required, this can be extended for SoC vendor specific bindings. Such bindings
>  should be documented as Documentation/devicetree/bindings/power/<vendor>-opp.txt
>  and should have a compatible description like: "operating-points-v2-<vendor>".
> @@ -154,6 +159,13 @@ properties.
>
>  - status: Marks the node enabled/disabled.
>
> +- power-domain-opp: This contains phandle to one of the OPP nodes of the master
> +  power domain. This specifies the minimum required OPP of the master domain for
> +  the functioning of the device in this OPP (where this property is present).
> +  This property can only be set for a device if the device node contains the
> +  "power-domains" property. Also, either all or none of the OPP nodes in an OPP
> +  table should have it set.

This is a "this device requires OPP n" property. Couldn't we want this
for cases other than a powerdomain OPP? What if a device has
requirements 2 different OPPs?

On the flipside, I don't think we want devices picking things like CPU
OPPs and putting policy here. But I'd rather things be extendable than
reviewing yet another OPP property next month.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
