From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH V3 2/2] thermal: max77620: Add thermal driver for reporting
 junction temp
Date: Tue, 7 Jun 2016 12:05:27 +0530
Message-ID: <57566B2F.3020706@nvidia.com>
References: <1465213467-23518-1-git-send-email-ldewangan@nvidia.com> <1465213467-23518-2-git-send-email-ldewangan@nvidia.com> <5756441A.7030705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15977 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbcFGGsQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2016 02:48:16 -0400
In-Reply-To: <5756441A.7030705@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keerthy <a0393675@ti.com>, edubezval@gmail.com, rui.zhang@intel.com, robh+dt@kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org


On Tuesday 07 June 2016 09:18 AM, Keerthy wrote:
> Hi Laxman,
>
> On Monday 06 June 2016 05:14 PM, Laxman Dewangan wrote:
>> Maxim Semiconductor Max77620 supports alarm interrupts when
>> its die temperature crosses 120C and 140C. These threshold
>> temperatures are not configurable.
>>
>> Add thermal driver to register PMIC die temperature as thermal
>> zone sensor and capture the die temperature warning interrupts
>> to notifying the client.
>
> Couple of minor comments.
>
>> +      Support for die junction temperature warning alarm for Maxim
>> +      Semiconductor PMIC MAX77620 device. Device generates two alarm
>> +      interrupts when PMIC die temperature cross the threshold of
>> +      120 degC and 140 degC.
>
> So what are the actions taken for 120C and 140C trips?
> What cooling device is used?
>

The PMIC die temp increases because of higher load on the rails. The 
higher load (more current from rail) is due to if CPU are running on 
higher frequency,

The information is used by the thermal monitoring and throttling system 
and when it sees higher temp on the PMIC die:
- It can reduce the frequency of the CPU or something like this as part 
of thermal throttling.
- If device supports fan then it can increase speed of fans or turn on fan.


>>
>> +};
>> +
>
> This does not give the absolute temperature. So some comments would be 
> really helpful for this function.
>

OK, will add on next rev of patch.

