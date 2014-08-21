From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v3 3/4] ARM: tegra: Add thermal trip points for Jetson
 TK1
Date: Thu, 21 Aug 2014 10:37:46 +0300
Message-ID: <53F5A1CA.1010601@nvidia.com>
References: <1407320706-17440-1-git-send-email-mperttunen@nvidia.com> <1407320706-17440-4-git-send-email-mperttunen@nvidia.com> <53F4FA80.9050103@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5825 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbaHUHhu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Aug 2014 03:37:50 -0400
In-Reply-To: <53F4FA80.9050103@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, rui.zhang@intel.com, edubezval@gmail.com, thierry.reding@gmail.com
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 20/08/14 22:44, Stephen Warren wrote:
> On 08/06/2014 04:25 AM, Mikko Perttunen wrote:
>> This adds critical trip points to the Jetson TK1 device tree.
>> The device will do a controlled shutdown when either the CPU, GPU
>> or MEM thermal zone reaches 101 degrees Celsius.
>
>> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>
>> +    thermal-zones {
>> +        cpu {
>> +            trips {
> ...
>> +            };
>> +        };
>
> thermal.txt states that a cooling-maps sub-node is mandatory. However,
> it seems to be missing here. Is the DT binding documentation overly
> strict, or do we need to add such a node here?

Debatable. I can add an empty one, that's probably the easiest solution.

Mikko

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
