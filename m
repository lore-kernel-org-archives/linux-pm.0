From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/5] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Thu, 3 Oct 2013 09:20:12 -0500
Message-ID: <524D7D1C.30207@ti.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1380634382-15609-3-git-send-email-Sudeep.KarkadaNagesha@arm.com> <524AFC52.8080201@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524AFC52.8080201-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>, "cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 10/01/2013 11:46 AM, Sudeep KarkadaNagesha wrote:
> On 01/10/13 14:32, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
>>
>> Currently we need to replicate the OPP entries in all the nodes even
>> though they share OPPs being in the same clock domain.
>>
>> Few drivers like cpufreq depend on physical cpu0 node to specify the
>> OPPs and only that node is referred irrespective of the logical cpu
>> accessing it. Alternatively to support cpuhotplug path, few drivers
>> parse all the cpu nodes for OPPs. Instead we can specify the phandle
>> of the node which contains the OPP tuples.
>>
>> This patch adds support to the new property 'operating-points-phandle'
>> which specifies the phandle pointing to another node which contains the
>> actual OPP tuples.
>>
>> Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>> Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
>> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>> Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
>> Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
>> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
>> ---
>>  drivers/base/power/opp.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
>> index ef89897..bb6ff64 100644
>> --- a/drivers/base/power/opp.c
>> +++ b/drivers/base/power/opp.c
>> @@ -708,12 +708,20 @@ struct srcu_notifier_head *opp_get_notifier(struct device *dev)
>>  int of_init_opp_table(struct device *dev)
>>  {
>>  	const struct property *prop;
>> +	struct device_node *opp_node;
>>  	const __be32 *val;
>>  	int nr;
>>  
>> -	prop = of_find_property(dev->of_node, "operating-points", NULL);
>> -	if (!prop)
>> +	opp_node = of_parse_phandle(dev->of_node,
>> +					"operating-points-phandle", 0);
>> +	if (!opp_node) /* if no OPP phandle, search for OPPs in current node */
>> +		opp_node = dev->of_node;
>> +	prop = of_find_property(opp_node, "operating-points", NULL);
>> +	if (!prop) {
>> +		dev_warn(dev, "node %s missing operating-points property\n",
>> +							opp_node->full_name);
>>  		return -ENODEV;
>> +	}
>>  	if (!prop->value)
>>  		return -ENODATA;
>>  
>> @@ -740,6 +748,9 @@ int of_init_opp_table(struct device *dev)
>>  		nr -= 2;
>>  	}
>>  
>> +	if (opp_node != dev->of_node)
>> +		of_node_put(opp_node);
>> +
> There are several exit paths on error conditions where we need to do this.
> I missed them all. Here is the updated patch:

> 
> -->8--
> 
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
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
> Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/base/power/opp.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index ef89897..cd4dbb3 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -708,14 +708,25 @@ struct srcu_notifier_head *opp_get_notifier(struct device
> *dev)
^^
<minor crib>
When reposting, could you avoid having word wrap? - kinda hard to get
https://patchwork.kernel.org/patch/2971091/ to apply clean :(

wget -O a.patch 'https://patchwork.kernel.org/patch/2971091/mbox/'
patch -p1< a.patch --dry-run
patching file drivers/base/power/opp.c
patch: **** malformed patch at line 143: *dev)

also when i look at the mbox patch, I see it split up.. did not dig in
why.. manually fixed it up.
</minor crib>

minor comments follow (other than squashing it with patch #1)
>  int of_init_opp_table(struct device *dev)
>  {
>  	const struct property *prop;
> +	struct device_node *opp_node;
>  	const __be32 *val;
> -	int nr;
> -
> -	prop = of_find_property(dev->of_node, "operating-points", NULL);
> -	if (!prop)
> -		return -ENODEV;
> -	if (!prop->value)
> -		return -ENODATA;
> +	int nr, ret = 0;
> +
> +	opp_node = of_parse_phandle(dev->of_node,
> +					"operating-points-phandle", 0);
> +	if (!opp_node) /* if no OPP phandle, search for OPPs in current node */
If you do not have a strong opinion, could you move the comment above
the if?
> +		opp_node = dev->of_node;
add an eol here.
> +	prop = of_find_property(opp_node, "operating-points", NULL);
> +	if (!prop) {
> +		dev_warn(dev, "node %s missing operating-points property\n",
> +							opp_node->full_name);
^^ align the opp_node->full_name to the d in dev in dev_warn(dev?
Checkpatch.sh --strict reports
CHECK: Alignment should match open parenthesis
#57: FILE: drivers/base/power/opp.c:722:
+		dev_warn(dev, "node %s missing operating-points property\n",
+							opp_node->full_name);

total: 0 errors, 0 warnings, 1 checks, 53 lines checked


> +		ret = -ENODEV;
> +		goto put_node;
> +	}
> +	if (!prop->value) {
> +		ret = -ENODATA;
> +		goto put_node;
> +	}
> 
>  	/*
>  	 * Each OPP is a set of tuples consisting of frequency and
> @@ -724,7 +735,8 @@ int of_init_opp_table(struct device *dev)
>  	nr = prop->length / sizeof(u32);
>  	if (nr % 2) {
>  		dev_err(dev, "%s: Invalid OPP list\n", __func__);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto put_node;
>  	}
> 
>  	val = prop->value;
> @@ -740,7 +752,11 @@ int of_init_opp_table(struct device *dev)
>  		nr -= 2;
>  	}
> 
> -	return 0;
> +put_node:
> +	if (opp_node != dev->of_node)
> +		of_node_put(opp_node);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_init_opp_table);
>  #endif
> 
other than that, please feel free to add
Acked-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
