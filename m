From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 5/7] cpufreq: intel_pstate: Remove redundant includes
Date: Tue, 10 Jun 2014 17:45:26 +0300
Message-ID: <53971A06.20906@semaphore.gr>
References: <53962087.8000706@semaphore.gr> <CAKohpokJfS=wFFFuqc26tnojTViuejVQMXGn18DAqrN+j0Zihw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:57268 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750800AbaFJOpb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 10:45:31 -0400
In-Reply-To: <CAKohpokJfS=wFFFuqc26tnojTViuejVQMXGn18DAqrN+j0Zihw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 10/06/2014 08:29 =CF=80=CE=BC, Viresh Kumar wrote:
> On 10 June 2014 02:30, Stratos Karafotis <stratosk@semaphore.gr> wrot=
e:
>> Also put them in alphabetical order.
>>
>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
>> ---
>>  drivers/cpufreq/intel_pstate.c | 17 ++---------------
>>  1 file changed, 2 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_=
pstate.c
>> index 26a0262..d4f0518 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -10,26 +10,13 @@
>>   * of the License.
>>   */
>>
>> -#include <linux/kernel.h>
>> -#include <linux/kernel_stat.h>
>> -#include <linux/module.h>
>> -#include <linux/ktime.h>
>> -#include <linux/hrtimer.h>
>> -#include <linux/tick.h>
>> -#include <linux/slab.h>
>> -#include <linux/sched.h>
>> -#include <linux/list.h>
>> +#include <linux/acpi.h>
>>  #include <linux/cpu.h>
>>  #include <linux/cpufreq.h>
>> -#include <linux/sysfs.h>
>> -#include <linux/types.h>
>> -#include <linux/fs.h>
>>  #include <linux/debugfs.h>
>> -#include <linux/acpi.h>
>> +#include <linux/module.h>
>>  #include <trace/events/power.h>
>>
>> -#include <asm/div64.h>
>> -#include <asm/msr.h>
>>  #include <asm/cpu_device_id.h>
>=20
> As a rule, header files for all the symbols directly used by a file m=
ust
> be included directly by the file and must not depend on indirect incl=
usions.
>=20
> So even if it compiles, its the wrong thing to do. Though you can obv=
iously
> remove the headers which aren't used.
>=20

I didn't know this. I will drop this patch. I'm sorry for the noise.

Thanks for your comments!
Stratos

