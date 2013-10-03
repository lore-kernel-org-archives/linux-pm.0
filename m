From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH v2 2/5] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Thu, 03 Oct 2013 16:39:58 +0100
Message-ID: <524D8FCE.2030200@arm.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1380634382-15609-3-git-send-email-Sudeep.KarkadaNagesha@arm.com> <524AFC52.8080201@arm.com> <524D7D1C.30207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34789 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139Ab3JCPj4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:39:56 -0400
In-Reply-To: <524D7D1C.30207@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 03/10/13 15:20, Nishanth Menon wrote:
> On 10/01/2013 11:46 AM, Sudeep KarkadaNagesha wrote:
>> On 01/10/13 14:32, Sudeep KarkadaNagesha wrote:
[...]
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
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
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>> Cc: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>> ---
>>  drivers/base/power/opp.c | 34 +++++++++++++++++++++++++---------
>>  1 file changed, 25 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
>> index ef89897..cd4dbb3 100644
>> --- a/drivers/base/power/opp.c
>> +++ b/drivers/base/power/opp.c
>> @@ -708,14 +708,25 @@ struct srcu_notifier_head *opp_get_notifier(struct device
>> *dev)
> ^^
> <minor crib>
> When reposting, could you avoid having word wrap? - kinda hard to get
> https://patchwork.kernel.org/patch/2971091/ to apply clean :(
> 
> wget -O a.patch 'https://patchwork.kernel.org/patch/2971091/mbox/'
> patch -p1< a.patch --dry-run
> patching file drivers/base/power/opp.c
> patch: **** malformed patch at line 143: *dev)
> 
> also when i look at the mbox patch, I see it split up.. did not dig in
> why.. manually fixed it up.

Sorry for this, since I replied over my original patch(didn't use git mail)
I messed it up. It won't happen again :)

> </minor crib>
> 
> minor comments follow (other than squashing it with patch #1)
>>  int of_init_opp_table(struct device *dev)
>>  {
>>  	const struct property *prop;
>> +	struct device_node *opp_node;
>>  	const __be32 *val;
>> -	int nr;
>> -
>> -	prop = of_find_property(dev->of_node, "operating-points", NULL);
>> -	if (!prop)
>> -		return -ENODEV;
>> -	if (!prop->value)
>> -		return -ENODATA;
>> +	int nr, ret = 0;
>> +
>> +	opp_node = of_parse_phandle(dev->of_node,
>> +					"operating-points-phandle", 0);
>> +	if (!opp_node) /* if no OPP phandle, search for OPPs in current node */
> If you do not have a strong opinion, could you move the comment above
> the if?
>> +		opp_node = dev->of_node;
> add an eol here.
>> +	prop = of_find_property(opp_node, "operating-points", NULL);
>> +	if (!prop) {
>> +		dev_warn(dev, "node %s missing operating-points property\n",
>> +							opp_node->full_name);
> ^^ align the opp_node->full_name to the d in dev in dev_warn(dev?
> Checkpatch.sh --strict reports
> CHECK: Alignment should match open parenthesis
> #57: FILE: drivers/base/power/opp.c:722:
> +		dev_warn(dev, "node %s missing operating-points property\n",
> +							opp_node->full_name);
> 
> total: 0 errors, 0 warnings, 1 checks, 53 lines checked
> 
All the other coding style comments and checkpatch errors reported in all the
patches are now fixed. I will post the next version once I get response for DT
binding updates from DT maintainers.

> 
>> +		ret = -ENODEV;
>> +		goto put_node;
>> +	}
>> +	if (!prop->value) {
>> +		ret = -ENODATA;
>> +		goto put_node;
>> +	}
>>
>>  	/*
>>  	 * Each OPP is a set of tuples consisting of frequency and
>> @@ -724,7 +735,8 @@ int of_init_opp_table(struct device *dev)
>>  	nr = prop->length / sizeof(u32);
>>  	if (nr % 2) {
>>  		dev_err(dev, "%s: Invalid OPP list\n", __func__);
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +		goto put_node;
>>  	}
>>
>>  	val = prop->value;
>> @@ -740,7 +752,11 @@ int of_init_opp_table(struct device *dev)
>>  		nr -= 2;
>>  	}
>>
>> -	return 0;
>> +put_node:
>> +	if (opp_node != dev->of_node)
>> +		of_node_put(opp_node);
>> +
>> +	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(of_init_opp_table);
>>  #endif
>>
> other than that, please feel free to add
> Acked-by: Nishanth Menon <nm@ti.com>
> 
Thanks for the review.

Regards,
Sudeep

