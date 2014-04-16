From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq, powernv: Fix build failure on UP
Date: Wed, 16 Apr 2014 11:31:02 +0530
Message-ID: <534E1C9E.3090802@linux.vnet.ibm.com>
References: <20140415141111.GA28352@windriver.com> <534E199D.2090504@linux.vnet.ibm.com> <CAKohponDbPXTzzSvOy=V2vKpJEZYtt7i1ZqQLwcjN_Nhf95+mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponDbPXTzzSvOy=V2vKpJEZYtt7i1ZqQLwcjN_Nhf95+mQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, linux-next list <linux-next@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, cpufreq <cpufreq@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04/16/2014 11:25 AM, Viresh Kumar wrote:
> On 16 April 2014 11:18, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>> Subject: [PATCH] cpufreq, powernv: Fix build failure on UP
>>
>> Paul Gortmaker reported the following build failure of the powernv cpufreq
>> driver on UP configs:
>>
>> drivers/cpufreq/powernv-cpufreq.c:241:2: error: implicit declaration of
>> function 'cpu_sibling_mask' [-Werror=implicit-function-declaration]
>> cc1: some warnings being treated as errors
>> make[3]: *** [drivers/cpufreq/powernv-cpufreq.o] Error 1
>> make[2]: *** [drivers/cpufreq] Error 2
>> make[1]: *** [drivers] Error 2
>> make: *** [sub-make] Error 2
>>
>> The trouble here is that cpu_sibling_mask is defined only in <asm/smp.h>, and
>> <linux/smp.h> includes <asm/smp.h> only in SMP builds.
>>
>> So fix this build failure by explicitly including <asm/smp.h> in the driver,
>> so that we get the definition of cpu_sibling_mask even in UP configurations.
>>
>> Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
>> ---
>>
>>  drivers/cpufreq/powernv-cpufreq.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index 9edccc6..ed1c7e5 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -29,6 +29,7 @@
>>
>>  #include <asm/cputhreads.h>
>>  #include <asm/reg.h>
> 
> Probably a comment here ?, so that people don't try to remove it in future.
> 

Sure, that sounds like a good idea.

> /* Required for cpu_sibling_mask() in UP configurations */
> 
>> +#include <asm/smp.h>
>>
>>  #define POWERNV_MAX_PSTATES    256
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thank you!

Regards,
Srivatsa S. Bhat

