From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v2 1/2] cpumask: introduce cpumask for
	hotpluggable CPUs
Date: Thu, 11 Aug 2011 11:39:03 -0700
Message-ID: <CAJOA=zNyssmgoHXbX6maR=EM4T8A79YU-iwgy8oW2xMoVrQvZA__40602.4459087805$1313088029$gmane$org@mail.gmail.com>
References: <1313006614-28702-1-git-send-email-mturquette@ti.com>
	<1313006614-28702-2-git-send-email-mturquette@ti.com>
	<20110811060622.GA2549@matterhorn1>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110811060622.GA2549@matterhorn1>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Turquette <mturquette@ti.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, gregkh@suse.de, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 10, 2011 at 11:06 PM, Amit Kucheria
<amit.kucheria@linaro.org> wrote:
> See comments inline.
>
> On 11 Aug 10, Mike Turquette wrote:
>> On some platforms it is possible to have some CPUs which support CPU
>> hotplug and some which do not. =A0Currently the prescence of an 'online'
>> sysfs entry in userspace is adequate for applications to know that a CPU
>> supports hotplug, but there is no convenient way to make the same
>> determination in the kernel.
>>
>> To better model this relationship this patch introduces a new cpumask to
>> track CPUs that support CPU hotplug operations.
>>
>> This new cpumask is populated at boot-time and remains static for the
>> life of the machine. =A0Bits set in the mask indicate a CPU which suppor=
ts
>> hotplug, but make no guarantees about whether that CPU is currently
>> online or not. =A0Likewise a cleared bit in the mask indicates either a
>> CPU which cannot hotplug or a lack of a populated CPU.
>>
>> The purpose of this new cpumask is to aid kernel code which uses CPU to
>> take CPUs online and offline. =A0Possible uses are as a thermal event
>> mitigation technique or as a power capping mechanism.
>>
>> Signed-off-by: Mike Turquette <mturquette@ti.com>
>> ---
>> Change log:
>> v2: fixed missing parentheses in cpumask_test_cpu and improved grammar
>> =A0 =A0 in comments
>>
>> =A0include/linux/cpumask.h | =A0 27 ++++++++++++++++++++++-----
>> =A0kernel/cpu.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 18 ++++++++++++++++++
>> =A02 files changed, 40 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
>> index b24ac56..52e64a7 100644
>> --- a/include/linux/cpumask.h
>> +++ b/include/linux/cpumask.h
>> @@ -39,10 +39,11 @@ extern int nr_cpu_ids;
>> =A0 * The following particular system cpumasks and operations manage
>> =A0 * possible, present, active and online cpus.
>> =A0 *
>> - * =A0 =A0 cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
>> - * =A0 =A0 cpu_present_mask - has bit 'cpu' set iff cpu is populated
>> - * =A0 =A0 cpu_online_mask =A0- has bit 'cpu' set iff cpu available to =
scheduler
>> - * =A0 =A0 cpu_active_mask =A0- has bit 'cpu' set iff cpu available to =
migration
>> + * =A0 =A0 cpu_possible_mask =A0 =A0 - has bit 'cpu' set iff cpu is pop=
ulatable
>> + * =A0 =A0 cpu_hotpluggable_mask - has bit 'cpu' set iff cpu is hotplug=
gable
>> + * =A0 =A0 cpu_present_mask =A0 =A0 =A0- has bit 'cpu' set iff cpu is p=
opulated
>> + * =A0 =A0 cpu_online_mask =A0 =A0 =A0 - has bit 'cpu' set iff cpu avai=
lable to scheduler
>> + * =A0 =A0 cpu_active_mask =A0 =A0 =A0 - has bit 'cpu' set iff cpu avai=
lable to migration
>> =A0 *
>> =A0 * =A0If !CONFIG_HOTPLUG_CPU, present =3D=3D possible, and active =3D=
=3D online.
>> =A0 *
>> @@ -51,7 +52,11 @@ extern int nr_cpu_ids;
>> =A0 * =A0life of that system boot. =A0The cpu_present_mask is dynamic(*),
>> =A0 * =A0representing which CPUs are currently plugged in. =A0And
>> =A0 * =A0cpu_online_mask is the dynamic subset of cpu_present_mask,
>> - * =A0indicating those CPUs available for scheduling.
>> + * =A0indicating those CPUs available for scheduling. =A0The
>> + * =A0cpu_hotpluggable_mask is also fixed at boot time as the set of CPU
>> + * =A0id's which are possible AND can hotplug. =A0Cleared bits in this =
mask
>> + * =A0mean that either the CPU is not possible, or it is possible but d=
oes
>> + * =A0not support CPU hotplug operations.
>> =A0 *
>> =A0 * =A0If HOTPLUG is enabled, then cpu_possible_mask is forced to have
>> =A0 * =A0all NR_CPUS bits set, otherwise it is just the set of CPUs that
>> @@ -61,6 +66,9 @@ extern int nr_cpu_ids;
>> =A0 * =A0depending on what ACPI reports as currently plugged in, otherwi=
se
>> =A0 * =A0cpu_present_mask is just a copy of cpu_possible_mask.
>> =A0 *
>> + * =A0If HOTPLUG is not enabled then cpu_hotpluggable_mask is the empty
>> + * =A0set.
>> + *
>> =A0 * =A0(*) Well, cpu_present_mask is dynamic in the hotplug case. =A0I=
f not
>> =A0 * =A0 =A0 =A0hotplug, it's a copy of cpu_possible_mask, hence fixed =
at boot.
>> =A0 *
>> @@ -76,6 +84,7 @@ extern int nr_cpu_ids;
>> =A0 */
>>
>> =A0extern const struct cpumask *const cpu_possible_mask;
>> +extern const struct cpumask *const cpu_hotpluggable_mask;
>> =A0extern const struct cpumask *const cpu_online_mask;
>> =A0extern const struct cpumask *const cpu_present_mask;
>> =A0extern const struct cpumask *const cpu_active_mask;
>> @@ -85,19 +94,23 @@ extern const struct cpumask *const cpu_active_mask;
>> =A0#define num_possible_cpus() =A0cpumask_weight(cpu_possible_mask)
>> =A0#define num_present_cpus() =A0 cpumask_weight(cpu_present_mask)
>> =A0#define num_active_cpus() =A0 =A0cpumask_weight(cpu_active_mask)
>> +#define num_hotpluggable_cpus() =A0 =A0 =A0cpumask_weight(cpu_hotplugga=
ble_mask)
>> =A0#define cpu_online(cpu) =A0 =A0 =A0 =A0 =A0 =A0 =A0cpumask_test_cpu((=
cpu), cpu_online_mask)
>> =A0#define cpu_possible(cpu) =A0 =A0cpumask_test_cpu((cpu), cpu_possible=
_mask)
>> =A0#define cpu_present(cpu) =A0 =A0 cpumask_test_cpu((cpu), cpu_present_=
mask)
>> =A0#define cpu_active(cpu) =A0 =A0 =A0 =A0 =A0 =A0 =A0cpumask_test_cpu((=
cpu), cpu_active_mask)
>> +#define cpu_hotpluggable(cpu) =A0 =A0 =A0 =A0cpumask_test_cpu((cpu, cpu=
_hotpluggable_mask))
>
> The bracket should be around cpu, like this (cpu) so that there are no
> side-effects when passing anything to the macro. See the other #defines a=
bove.

Wow, not sure how that happened...  will send in V3...

>> =A0#else
>> =A0#define num_online_cpus() =A0 =A01U
>> =A0#define num_possible_cpus() =A01U
>> =A0#define num_present_cpus() =A0 1U
>> =A0#define num_active_cpus() =A0 =A01U
>> +#define num_hotpluggable_cpus() =A0 =A0 =A00
>> =A0#define cpu_online(cpu) =A0 =A0 =A0 =A0 =A0 =A0 =A0((cpu) =3D=3D 0)
>> =A0#define cpu_possible(cpu) =A0 =A0((cpu) =3D=3D 0)
>> =A0#define cpu_present(cpu) =A0 =A0 ((cpu) =3D=3D 0)
>> =A0#define cpu_active(cpu) =A0 =A0 =A0 =A0 =A0 =A0 =A0((cpu) =3D=3D 0)
>> +#define cpu_hotpluggable(cpu) =A0 =A0 =A0 =A00
>> =A0#endif
>>
>> =A0/* verify cpu argument to cpumask_* operators */
>> @@ -678,16 +691,20 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
>> =A0#define cpu_none_mask to_cpumask(cpu_bit_bitmap[0])
>>
>> =A0#define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_m=
ask)
>> +#define for_each_hotpluggable_cpu(cpu) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for_eac=
h_cpu((cpu), cpu_hotpluggable_mask)
>> =A0#define for_each_online_cpu(cpu) =A0 for_each_cpu((cpu), cpu_online_m=
ask)
>> =A0#define for_each_present_cpu(cpu) =A0for_each_cpu((cpu), cpu_present_=
mask)
>>
>> =A0/* Wrappers for arch boot code to manipulate normally-constant masks =
*/
>> =A0void set_cpu_possible(unsigned int cpu, bool possible);
>> +void set_cpu_hotpluggable(unsigned int cpu, bool hotpluggable);
>> =A0void set_cpu_present(unsigned int cpu, bool present);
>> =A0void set_cpu_online(unsigned int cpu, bool online);
>> =A0void set_cpu_active(unsigned int cpu, bool active);
>> =A0void init_cpu_present(const struct cpumask *src);
>> =A0void init_cpu_possible(const struct cpumask *src);
>> +void init_cpu_hotpluggable(const struct cpumask *src);
>> =A0void init_cpu_online(const struct cpumask *src);
>>
>> =A0/**
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index 12b7458..8c397c9 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -536,6 +536,11 @@ static DECLARE_BITMAP(cpu_possible_bits, CONFIG_NR_=
CPUS) __read_mostly;
>> =A0const struct cpumask *const cpu_possible_mask =3D to_cpumask(cpu_poss=
ible_bits);
>> =A0EXPORT_SYMBOL(cpu_possible_mask);
>>
>> +static DECLARE_BITMAP(cpu_hotpluggable_bits, CONFIG_NR_CPUS) __read_mos=
tly;
>> +const struct cpumask *const cpu_hotpluggable_mask =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 to_cpumask(cpu_hotpluggable_bits);
>> +EXPORT_SYMBOL(cpu_hotpluggable_mask);
>> +
>> =A0static DECLARE_BITMAP(cpu_online_bits, CONFIG_NR_CPUS) __read_mostly;
>> =A0const struct cpumask *const cpu_online_mask =3D to_cpumask(cpu_online=
_bits);
>> =A0EXPORT_SYMBOL(cpu_online_mask);
>> @@ -556,6 +561,14 @@ void set_cpu_possible(unsigned int cpu, bool possib=
le)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpumask_clear_cpu(cpu, to_cpumask(cpu_possib=
le_bits));
>> =A0}
>>
>> +void set_cpu_hotpluggable(unsigned int cpu, bool hotpluggable)
>> +{
>> + =A0 =A0 if (hotpluggable)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpumask_set_cpu(cpu, to_cpumask(cpu_hotpluggab=
le_bits));
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpumask_clear_cpu(cpu, to_cpumask(cpu_hotplugg=
able_bits));
>> +}
>> +
>> =A0void set_cpu_present(unsigned int cpu, bool present)
>> =A0{
>> =A0 =A0 =A0 if (present)
>> @@ -590,6 +603,11 @@ void init_cpu_possible(const struct cpumask *src)
>> =A0 =A0 =A0 cpumask_copy(to_cpumask(cpu_possible_bits), src);
>> =A0}
>>
>> +void init_cpu_hotpluggable(const struct cpumask *src)
>> +{
>> + =A0 =A0 cpumask_copy(to_cpumask(cpu_hotpluggable_bits), src);
>> +}
>> +
>
> Just to be clear I understand this code, init_cpu_hotpluggable will be ca=
lled
> in arch code, right? e.g. arch/arm/kernel/smp.c or do you intend for it t=
o be
> called in platform-specific code?

It could be called in either, though I assume arch code is a better
place to call this.

This call is made redundant by patch 2 which populates the
hotpluggable bits in register_cpu, but some platforms might still need
it so it is included for completeness sake.  x86 and ARM will not call
this, for example.  In fact I could not find any users of the
init_cpu_xxx cpumask helpers on any architectures.

Thanks,
Mike

>> =A0void init_cpu_online(const struct cpumask *src)
>> =A0{
>> =A0 =A0 =A0 cpumask_copy(to_cpumask(cpu_online_bits), src);
>> --
>> 1.7.4.1
>
