From: Vince Hsu <vinceh@nvidia.com>
Subject: Re: [PATCH v2 01/17] reset: add of_reset_control_get_by_index()
Date: Fri, 13 Mar 2015 11:04:46 +0800
Message-ID: <550253CE.80201@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>	 <1426162518-7405-2-git-send-email-vinceh@nvidia.com> <1426172504.14455.67.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5820 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbbCMDE1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2015 23:04:27 -0400
In-Reply-To: <1426172504.14455.67.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: thierry.reding@gmail.com, pdeschrijver@nvidia.com, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, tj@kernel.org, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org

Hi Philipp,

On 03/12/2015 11:01 PM, Philipp Zabel wrote:
> Hi Vince,
>
> Am Donnerstag, den 12.03.2015, 20:15 +0800 schrieb Vince Hsu:
>> Add of_reset_control_get_by_index() to allow the drivers to get reset device
>> without knowing its name.
> I see this is useful in the case of PM domain drivers that just need to
> trigger a list of resets in whatever order.
Yep.

>
>> Signed-off-by: Vince Hsu <vinceh@nvidia.com>
>>
>> ---
>> v2: minor changes according to Alex's comments
>>
>>   drivers/reset/core.c  | 44 +++++++++++++++++++++++++++++---------------
>>   include/linux/reset.h |  9 +++++++++
>>   2 files changed, 38 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
>> index 7955e00d04d4..5e78866acd62 100644
>> --- a/drivers/reset/core.c
>> +++ b/drivers/reset/core.c
>> @@ -140,28 +140,15 @@ int reset_control_status(struct reset_control *rstc)
>>   }
>>   EXPORT_SYMBOL_GPL(reset_control_status);
>>   
>> -/**
>> - * of_reset_control_get - Lookup and obtain a reference to a reset controller.
>> - * @node: device to be reset by the controller
>> - * @id: reset line name
>> - *
>> - * Returns a struct reset_control or IS_ERR() condition containing errno.
>> - *
>> - * Use of id names is optional.
>> - */
>> -struct reset_control *of_reset_control_get(struct device_node *node,
>> -					   const char *id)
>> +struct reset_control *__of_reset_control_get(struct device_node *node,
>> +						int index)
> static
Will merge to of_reset_control_get_by_index.

>
>>   {
>>   	struct reset_control *rstc = ERR_PTR(-EPROBE_DEFER);
>>   	struct reset_controller_dev *r, *rcdev;
>>   	struct of_phandle_args args;
>> -	int index = 0;
>>   	int rstc_id;
>>   	int ret;
>>   
>> -	if (id)
>> -		index = of_property_match_string(node,
>> -						 "reset-names", id);
>>   	ret = of_parse_phandle_with_args(node, "resets", "#reset-cells",
>>   					 index, &args);
>>   	if (ret)
>> @@ -202,6 +189,33 @@ struct reset_control *of_reset_control_get(struct device_node *node,
>>   
>>   	return rstc;
>>   }
>> +
>> +struct reset_control *of_reset_control_get_by_index(struct device_node *node,
>> +					   int index)
>> +{
>> +	return __of_reset_control_get(node, index);
>> +}
>> +EXPORT_SYMBOL_GPL(of_reset_control_get_by_index);
> This function is missing a kerneldoc comment, and please add a note that
> this is only to be used if the order of the resets doesn't matter.
Will add comment.

>
> Actually, I see no reason not to just merge __of_reset_control_get into
> of_reset_control_get_by_index and then just call that from
> of_reset_control_get.
Indeed. Will fix.

Thanks for the review. :)
Vince

>
>> +/**
>> + * of_reset_control_get - Lookup and obtain a reference to a reset controller.
>> + * @node: device to be reset by the controller
>> + * @id: reset line name
>> + *
>> + * Returns a struct reset_control or IS_ERR() condition containing errno.
>> + *
>> + * Use of id names is optional.
>> + */
>> +struct reset_control *of_reset_control_get(struct device_node *node,
>> +					   const char *id)
>> +{
>> +	int index = 0;
>> +
>> +	if (id)
>> +		index = of_property_match_string(node,
>> +						 "reset-names", id);
>> +	return __of_reset_control_get(node, index);
>> +}
>>   EXPORT_SYMBOL_GPL(of_reset_control_get);
> [...]
>
> regards
> Philipp
>

