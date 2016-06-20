From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 0/3] firmware: scpi: add device power domain support
Date: Mon, 20 Jun 2016 19:02:43 +0100
Message-ID: <57682FC3.3070504@arm.com>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
 <m24m8nbv7k.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34917 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbcFTSDU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 20 Jun 2016 14:03:20 -0400
In-Reply-To: <m24m8nbv7k.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Jon Medhurst <tixy@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>



On 20/06/16 18:56, Kevin Hilman wrote:
> Sudeep Holla <sudeep.holla@arm.com> writes:
>
>> This series add support for SCPI based device device power state
>> management using genpd.
>>
>> Regards,
>> Sudeep
>>
>> v1[1]->v2:
>> 	- Fixed the endianness handling in scpi_device_get_power_state
>> 	  as spotted by Tixy
>> 	- Renamed scpi_pd.c to scpi_pm_domain.c as suggested by Ulf
>> 	- Added Mark's ack on DT binding
>>
>> [1] https://marc.info/?l=linux-kernel&m=146522850003483&w=2
>>
>> Sudeep Holla (3):
>>    firmware: arm_scpi: add support for device power state management
>>    Documentation: add DT bindings for ARM SCPI power domains
>>    firmware: scpi: add device power domain support using genpd
>
> Other than the couple nits on specific patches,
>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
>
> And just a[nother] reminder to be sure to keep things that are Juno
> specific well described since we know other vendors will be (and are
> being) "creative" in their implementations of SCPI.
>

Agreed as mentioned in the other thread.

I just sent a PR to arm-soc this afternoon. Do you think it's better to
recall it and incorporate this ?

Extremely sorry for rushing, I thought it would get too late. Ulf
reviewed them so I rushed a bit.

-- 
Regards,
Sudeep
