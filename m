From: Wei Ni <wni@nvidia.com>
Subject: Re: [RFC PATCH 6/9] hwmon: (lm90) Register to the thermal framework
Date: Wed, 20 Feb 2013 18:40:25 +0800
Message-ID: <5124A819.7040400@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-7-git-send-email-wni@nvidia.com> <5124082E.604@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:16269 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759171Ab3BTKke (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Feb 2013 05:40:34 -0500
In-Reply-To: <5124082E.604@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/20/2013 07:18 AM, Stephen Warren wrote:
> On 02/18/2013 04:30 AM, Wei Ni wrote:
>> Register the remote sensor to the thermal framework.
>> It can support to show the temperature and read/write threshold.
> 
>>  arch/arm/boot/dts/tegra30-cardhu.dtsi |    1 +
>>  drivers/hwmon/lm90.c                  |  182 ++++++++++++++++++++++++++++++++-
> 
> There shouldn't be any need to edit both those files in the same patch.
> This patch is making multiple separate logical changes, which should be
> separate patches.

I will follow Matthew's suggestion to split this serial patch into 3
separate sets.

> 
>> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> 
>> +			#sensor-cells = <1>;
> 
> Again, in order to allow that, you need some documentation in
> Documentation/devicetree/bindings/. Related to that, you need to Cc the
> devicetree maintainers on at least the patches that add that documentation.

Ok, I will do it.

> 
>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> 
>> @@ -1576,12 +1728,38 @@ static int lm90_probe(struct i2c_client *client,
> ...
>> +	np_args.np = dev->of_node;
>> +	np_args.index = 0;
> 
> As I mentioned before, that'd be better replaced by an explicit of_xlate
> function.

Yes, I will try to use this func.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

