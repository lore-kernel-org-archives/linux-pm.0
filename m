From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH v2 2/3] cpufreq: Remove unused function __cpufreq_driver_getavg
Date: Tue, 04 Jun 2013 18:06:04 +0300
Message-ID: <51AE025C.9030401@semaphore.gr>
References: <51ACF2F1.1050600@semaphore.gr> <CAKohpomTRdHdKN3QUf0ba+gFXrEr=PbD4cJc8NSyNPmxfnUsMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:57956 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752522Ab3FDPGJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2013 11:06:09 -0400
In-Reply-To: <CAKohpomTRdHdKN3QUf0ba+gFXrEr=PbD4cJc8NSyNPmxfnUsMQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/04/2013 08:19 AM, Viresh Kumar wrote:
> On 4 June 2013 01:18, Stratos Karafotis <stratosk@semaphore.gr> wrote:
>> Calculation of frequency target in ondemand governor changed and it is
>
> s/frequency target/target frequency

I will change it also in 3/3 that I use the same.

>> independent from measured average frequency.
>>
>> Remove unused__cpufreq_driver_getavg function and getavg member from
>> cpufreq_driver struct. Also, remove the callback getavg in
>> acpi_cpufreq_driver.
>>
>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
>> ---
>>   drivers/cpufreq/Makefile       |  2 +-
>>   drivers/cpufreq/acpi-cpufreq.c |  5 -----
>>   drivers/cpufreq/cpufreq.c      | 12 ------------
>>   include/linux/cpufreq.h        |  6 ------
>>   4 files changed, 1 insertion(+), 24 deletions(-)
>>
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index 6ad0b91..aebd4ef 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -23,7 +23,7 @@ obj-$(CONFIG_GENERIC_CPUFREQ_CPU0)    += cpufreq-cpu0.o
>>   # powernow-k8 can load then. ACPI is preferred to all other hardware-specific drivers.
>>   # speedstep-* is preferred over p4-clockmod.
>>
>> -obj-$(CONFIG_X86_ACPI_CPUFREQ)         += acpi-cpufreq.o mperf.o
>
> Should this be done in 3/3 ?
>

acpi-cpufreq does not use mperf after 2/3. Why should we compile it with
CONFIG_X86_ACPI_CPUFREQ?
Do you want me to move the change in 3/3?

Thanks,
Stratos

