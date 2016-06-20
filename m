From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 3/3] firmware: scpi: add device power domain support
 using genpd
Date: Mon, 20 Jun 2016 19:06:20 +0100
Message-ID: <5768309C.9020103@arm.com>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
 <1466073481-697-4-git-send-email-sudeep.holla@arm.com>
 <m2eg7rbvc2.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35381 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679AbcFTTXK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 20 Jun 2016 15:23:10 -0400
In-Reply-To: <m2eg7rbvc2.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Jon Medhurst <tixy@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 20/06/16 18:53, Kevin Hilman wrote:
> Sudeep Holla <sudeep.holla@arm.com> writes:
>
>> This patch hooks up the support for device power domain provided by
>> SCPI using the Linux generic power domain infrastructure.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Kevin Hilman <khilman@kernel.org>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> [...]
>
>> +static int scpi_pd_power(struct scpi_pm_domain *pd, bool power_on)
>> +{
>> +	int ret;
>> +	enum scpi_power_domain_state state;
>> +
>> +	if (power_on)
>> +		state = SCPI_PD_STATE_ON;
>> +	else
>> +		state = SCPI_PD_STATE_OFF;
>> +
>> +	ret = pd->ops->device_set_power_state(pd->domain, state);
>
> There should probably be some sanity checks here that these function
> pointers are non-NULL.
>

Yes I agree. Since with the current scpi driver, if scpi_ops is
populated, it's all non-NULL I skipped the sanity check as the probe
will check for non-NULL scpi_ops.

However, with extension work by Neil I agree, we may have to revisit all
such callers.

-- 
Regards,
Sudeep
