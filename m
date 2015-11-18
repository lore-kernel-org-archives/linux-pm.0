From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] cpufreq: scpi: Add dependency on SCPI clk driver
Date: Wed, 18 Nov 2015 13:06:13 +0000
Message-ID: <9hhk2pfpid6.fsf@e105922-lin.cambridge.arm.com>
References: <1447784059-22769-1-git-send-email-punit.agrawal@arm.com>
	<20151118051953.GB7336@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:59189 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755226AbbKRNGt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 08:06:49 -0500
In-Reply-To: <20151118051953.GB7336@ubuntu> (Viresh Kumar's message of "Wed,
	18 Nov 2015 10:49:53 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arnd@arndb.de, "Rafael J . Wysocki" <rjw@rjwysocki.net>

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 17-11-15, 18:14, Punit Agrawal wrote:
>> The SCPI clk driver registers the virtual cpufreq device that kicks off
>> initialisation of the SCPI cpufreq driver. Make the dependendency
>> explicit in Kconfig.
>
> That's not a dependency. Any other part of the kernel can add this
> *virtual* cpufreq device to get it going.

Any part can add the virtual cpufreq device but for scpi-cpufreq it is
done by clk-scpi. I can re-word it for clarity.
>
> But, we do have dependency the other way round. clk_get() will fail
> for the cpufreq driver if SCPI-clk driver is missing and perhaps
> that's what you need to mention in the changelog.
>
>> Fixes: 8def31034d03 ("cpufreq: arm_big_little: add SCPI interface driver")
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/cpufreq/Kconfig.arm | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 1582c1c..dadfdd4 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -201,7 +201,7 @@ config ARM_SA1110_CPUFREQ
>>  
>>  config ARM_SCPI_CPUFREQ
>>          tristate "SCPI based CPUfreq driver"
>> -	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL
>> +	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
>
> This looks fine.

I'll send an updated version to be picked up.

Thanks for taking a look.
