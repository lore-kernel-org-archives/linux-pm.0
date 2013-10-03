From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 3/5] PM / OPP: check for existing OPP list when initialising
 from device tree
Date: Thu, 3 Oct 2013 09:25:01 -0500
Message-ID: <524D7E3D.4050705@ti.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1380634382-15609-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380634382-15609-4-git-send-email-Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 10/01/2013 08:33 AM, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
> 
> CPUs are registered as devices and their OPPs can be initialised from
> the device tree. Whenever CPUs are hotplugged out, the corresponding
> cpu devices are not removed. As a result all their OPPs remain intact
> even when they are offlined.
> 
> But when they are hotplugged back-in, the cpufreq along with other cpu
> related subsystem gets re-initialised. Since its almost same as secondary
> cpu being brought up, no special consideration is taken in the hotplug
> path. This may result in cpufreq trying to initialise the OPPs again though
> the cpu device already contains the OPPs.
> 
> This patch checks if there exist an OPP list associated with the device,
> before attempting to initialise it.
> 
> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
> Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/base/power/opp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index bb6ff64..05b2ebf 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -709,9 +709,15 @@ int of_init_opp_table(struct device *dev)
>  {
>  	const struct property *prop;
>  	struct device_node *opp_node;
> +	struct device_opp *dev_opp;
>  	const __be32 *val;
>  	int nr;
>  
> +	/* Check for existing list for 'dev' */
> +	dev_opp = find_device_opp(dev);
> +	if (!IS_ERR(dev_opp))
> +		return -EEXIST; /* Device OPP already initialized */
in the interest of remaining code, Prefer comments not inline with
code -> example if additional logic gets added later on in the if
condition, someone'd have to move that comment over, instead, prefer
it embedded before the if check as a line of it's own.
> +
>  	opp_node = of_parse_phandle(dev->of_node,
>  					"operating-points-phandle", 0);
>  	if (!opp_node) /* if no OPP phandle, search for OPPs in current node */
> 

other than that,
Acked-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
