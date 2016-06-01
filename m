From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH] thermal: cpu_cooling: fix improper order during
 initialization
Date: Wed, 1 Jun 2016 14:31:35 +0100
Message-ID: <574EE3B7.1060302@arm.com>
References: <1464690722-27996-1-git-send-email-lukasz.luba@arm.com>
 <20160601111034.GO3725@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37879 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240AbcFANbj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Jun 2016 09:31:39 -0400
In-Reply-To: <20160601111034.GO3725@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, javi.merino@arm.com, amit.kachhap@gmail.com, rui.zhang@intel.com



On 01/06/16 12:10, Viresh Kumar wrote:
> On 31-05-16, 11:32, Lukasz Luba wrote:
>> The freq_table array is not populated before calling
>> thermal_of_cooling_register. The code which populates the freq table was
>> introduced in commit f6859014.
>> This should be done before registering new thermal cooling device.
>> The log shows effects of this wrong decision.
>> [    2.172614] cpu cpu1: Failed to get voltage for frequency 1984518656000: -34
>> [    2.220863] cpu cpu0: Failed to get voltage for frequency 1984524416000: -34
>>
>
> You should have added this as well:
>
> Cc: 4.19+ <stable@vger.kernel.org> # 4.19+

You mean 3.19+
Cc: <stable@vger.kernel.org> # 3.19+

> Fixes: f6859014c7e7 ("thermal: cpu_cooling: Store frequencies in descending order")
>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/cpu_cooling.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
Eduardo can you pick these tags when you merge it?

Thanks,
Lukasz
