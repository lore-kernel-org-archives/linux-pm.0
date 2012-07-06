From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/4] cpuidle : move tlb flag to the cpuidle
	header
Date: Fri, 06 Jul 2012 13:07:12 +0200
Message-ID: <4FF6C6E0.8020609@linaro.org>
References: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>
	<1341494608-16591-4-git-send-email-daniel.lezcano@linaro.org>
	<201207052243.15048.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201207052243.15048.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 07/05/2012 10:43 PM, Rafael J. Wysocki wrote:
> On Thursday, July 05, 2012, Daniel Lezcano wrote:
>> Move this specific flag to the header file.
>=20
> The patch evidently does more than that.
>=20
> Is it just a cleanup, or is there a functional reason for doing it?

It is just a cleanup.


Thanks for reviewing the patches.

  -- Daniel


>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/idle/intel_idle.c |    8 --------
>>  include/linux/cpuidle.h   |   16 +++++++++++++---
>>  2 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index fe95d54..3f0eb07 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -101,14 +101,6 @@ static int intel_idle_cpu_init(int cpu);
>>  static struct cpuidle_state *cpuidle_state_table;
>> =20
>>  /*
>> - * Set this flag for states where the HW flushes the TLB for us
>> - * and so we don't need cross-calls to keep it consistent.
>> - * If this flag is set, SW flushes the TLB, so even if the
>> - * HW doesn't do the flushing, this flag is safe to use.
>> - */
>> -#define CPUIDLE_FLAG_TLB_FLUSHED	0x10000
>> -
>> -/*
>>   * States are indexed by the cstate number,
>>   * which is also the index into the MWAIT hint array.
>>   * Thus C0 is a dummy.
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 730e12e..be150c9 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -67,10 +67,20 @@ struct cpuidle_state {
>>   *                            the cpuidle core the specified state ca=
n use the  *
>>   *                            enter_dead function.                   =
           *
>>   *                                                                   =
           *
>> + * CPUIDLE_FLAG_TLB_FLUSHED : Set this flag for states where the HW f=
lushes the *
>> + *                            TLB for us and so we don't need cross-c=
alls to    *
>> + *                            keep it consistent. If this flag is set=
, SW       *
>> + *                            flushes the TLB, so even if the HW does=
n't do the *
>> + *                            flushing, this flag is safe to use.    =
           *
>> + *                                                                   =
           *
>>   ********************************************************************=
***********/
>> -#define CPUIDLE_FLAG_TIME_VALID	(0x01)
>> -#define CPUIDLE_FLAG_COUPLED	(0x02)
>> -#define CPUIDLE_FLAG_DEAD_VALID (0x04)
>> +#define CPUIDLE_FLAG_TIME_VALID  (0x01)
>> +#define CPUIDLE_FLAG_COUPLED     (0x02)
>> +#define CPUIDLE_FLAG_DEAD_VALID  (0x04)
>> +#define CPUIDLE_FLAG_TLB_FLUSHED (0x08)
>> +
>> +
>> +
>> =20
>>  /**
>>   * cpuidle_get_statedata - retrieves private driver state data
>>
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
