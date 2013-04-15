From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: linux-next: Tree for Apr 9 [cpufreq: NULL pointer deref]
Date: Mon, 15 Apr 2013 10:42:09 -0700
Message-ID: <516C3BF1.6050902@gmail.com>
References: <CA+icZUU_K9PiFMqMsOEk1+c2DX8LrUojZptPiRVarv4dcB2qFA@mail.gmail.com> <CA+icZUUsAqJ3kyCZivYeTpY7n=EDMv1UcC2VNwQro4h7NHDWag@mail.gmail.com> <CA+icZUW+TB3q58bL+d=A355S4vtRhwMq8AV+tqjv6MgDtHRCaA@mail.gmail.com> <1923819.6Nb81T2TR8@vostro.rjw.lan> <CA+icZUXUGOjGUAFxgQk0780pcBB-YjiujDLXF+gJFegi+pd+dA@mail.gmail.com> <516C25AE.4050503@intel.com> <516C3868.40903@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <516C3868.40903@sgi.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, sedat.dilek@gmail.com, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 04/15/2013 10:27 AM, Nathan Zimmer wrote:
> On 04/15/2013 11:07 AM, Dirk Brandewie wrote:
>> On 04/13/2013 02:55 AM, Sedat Dilek wrote:
>>> On Sat, Apr 13, 2013 at 12:51 AM, Rafael J. Wysocki <rjw@sisk.pl> w=
rote:
>>>> On Friday, April 12, 2013 11:08:37 PM Sedat Dilek wrote:
>>>>> On Fri, Apr 12, 2013 at 6:27 PM, Sedat Dilek <sedat.dilek@gmail.c=
om> wrote:
>>>>>> On Fri, Apr 12, 2013 at 5:45 PM, Sedat Dilek <sedat.dilek@gmail.=
com> wrote:
>>>>>>> On Fri, Apr 12, 2013 at 4:24 PM, Sedat Dilek <sedat.dilek@gmail=
=2Ecom> wrote:
>>>>>>>> On Fri, Apr 12, 2013 at 10:23 AM, Viresh Kumar <viresh.kumar@l=
inaro.org>
>>>>>>>> wrote:
>>>>>>>>> On 10 April 2013 11:44, Sedat Dilek <sedat.dilek@gmail.com> w=
rote:
>>>>>>>>>> I found this "[RFC PATCH] kbuild: Build linux-tools package =
with 'make
>>>>>>>>>> deb-pkg'" from February 2012.
>>>>>>>>>> Can't say what happened to it...
>>>>>>>>>
>>>>>>>>> Sedat,
>>>>>>>>>
>>>>>>>>> Sorry for being late. I am down with Fever and throat infecti=
on since
>>>>>>>>> few days.
>>>>>>>>> Still struggling with it..
>>>>>>>>>
>>>>>>>>> There are few things i tried. Firstly the tag: next-20130326 =
is bad as
>>>>>>>>> there are
>>>>>>>>> some bad commits in cpufreq core in it.
>>>>>>>>>
>>>>>>>>> I then tried latest linux-next/master on my Thinkpad (model n=
ame
>>>>>>>>> : Intel(R)
>>>>>>>>> Core(TM) i7-2640M CPU @ 2.80GHz) and couldn't boot it up. My =
ubuntu
>>>>>>>>> just hanged.
>>>>>>>>>
>>>>>>>>> Then i tried Rafael's linux-next branch
>>>>>>>>>
>>>>>>>>> 079576f Merge branch 'pm-cpufreq-next' into linux-next
>>>>>>>>>
>>>>>>>>> And couldn't find any issues with it. I am easily able to rem=
ove/add
>>>>>>>>> cpus at
>>>>>>>>> runtime..
>>>>>>>>>
>>>>>>>>> Can you give this branch a try?
>>>>>>>>>
>>>>>>>>
>>>>>>>> OK, you seem to be well again, nice to hear.
>>>>>>>>
>>>>>>>> I was doing the whole week spring-cleaning in the apartment of=
 my parents.
>>>>>>>> Now, I have some minutes for a compilation run.
>>>>>>>>
>>>>>>>> I guess "cpufreq: Call __cpufreq_governor() with correct polic=
y->cpus
>>>>>>>> mask" could be the correct fix, but will try the GIT branch yo=
u have
>>>>>>>> mentioned.
>>>>>>>>
>>>>>>>> - Sedat -
>>>>>>>>
>>>>>>>> [1]
>>>>>>>> http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.gi=
t/commit/?h=3Dlinux-next&id=3De4969ebac83fdea78d89c779331396728a4e6199
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> Both BROKEN here, specific pm-next commitid and pulling
>>>>>>> pm.git#linux-next into next-20130411 (see attached files).
>>>>>>>
>>>>>>> Is "cpufreq: convert cpufreq_driver to using RCU" the root caus=
e of this
>>>>>>> all?
>>>>>>>
>>>>>>
>>>>>> [ CC Nathan ]
>>>>>>
>>>>>> NO, wrong assumption.
>>>>>>
>>>>>> 2013-04-12 18:04 Sedat Dilek        o [revert-cpufreq-rcu] Rever=
t
>>>>>> "cpufreq: convert cpufreq_driver to using RCU"
>>>>>> 2013-04-12 18:04 Sedat Dilek        o Revert "cpufreq: Call
>>>>>> __cpufreq_governor() with correct policy->cpus mask"
>>>>>> 2013-04-11 23:24 Rafael J. Wysocki  M=E2=94=80=E2=94=90 [pm-next=
-079576f] Merge branch
>>>>>> 'pm-cpufreq-next' into linux-next
>>>>>>
>>>>>> - Sedat -
>>>>>>
>>>>>>
>>>>>>> - Sedat -
>>>>>>>
>>>>>>> [1]
>>>>>>> http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git=
/commit/?h=3Dlinux-next&id=3D5800043b2488a1c4c6e859af860644d37419d58b
>>>>>>>
>>>>>>>
>>>>>>>>> --
>>>>>>>>> viresh
>>>>>
>>>>> [ TO Dirk (Author of Intel pstate driver) ]
>>>>>
>>>>> With CONFIG_X86_INTEL_PSTATE=3Dn (unset) I do not see the call-tr=
ace!
>>>>>
>>>>> My kernel-config and dmesg are attached.
>>>>
>>>> You're seeing a trouble with a new driver, then, so that's not a r=
egression.
>>>>
>>
>> This IS a regression.
>>
>> If the intel_pstate driver is being used __cpufreq_governor() should=
 NOT be
>> called intel_pstate does not implement the target() callback.
>>
>> Nathan's commit 5800043b2 changed the fence around the call to
>> __cpufreq_governor() in __cpufreq_remove_dev() here is the relevant =
hunk.
>>
>> @@ -1007,9 +1068,12 @@ static int __cpufreq_remove_dev(struct device=
 *dev,
>> struct subsys_interface *sif
>>      unsigned int cpu =3D dev->id, ret, cpus;
>>      unsigned long flags;
>>      struct cpufreq_policy *data;
>> +    struct cpufreq_driver *driver;
>>      struct kobject *kobj;
>>      struct completion *cmp;
>>      struct device *cpu_dev;
>> +    bool has_target;
>> +    int (*exit)(struct cpufreq_policy *policy);
>>
>>      pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
>>
>> @@ -1025,14 +1089,19 @@ static int __cpufreq_remove_dev(struct devic=
e *dev,
>> struct subsys_interface *sif
>>          return -EINVAL;
>>      }
>>
>> -    if (cpufreq_driver->target)
>> +    rcu_read_lock();
>> +    driver =3D rcu_dereference(cpufreq_driver);
>> +    has_target =3D driver->target ? true : false;
>> +    exit =3D driver->exit;
>> +    if (has_target)
>>          __cpufreq_governor(data, CPUFREQ_GOV_STOP);
>>
>>  #ifdef CONFIG_HOTPLUG_CPU
>> -    if (!cpufreq_driver->setpolicy)
>> +    if (!driver->setpolicy)
>>          strncpy(per_cpu(cpufreq_cpu_governor, cpu),
>>              data->governor->name, CPUFREQ_NAME_LEN);
>>  #endif
>> +    rcu_read_unlock();
>>
>>      WARN_ON(lock_policy_rwsem_write(cpu));
>>      cpus =3D cpumask_weight(data->cpus);
>>
>
> I am not clear at what is at issue.  Are you saying __cpufreq_governo=
r can
> change the value of cpufreq_driver->target?  I hadn't thought that wa=
s allowed
> but if it is the code would need to be fixed.
>

Sorry I think pointing to your patch may have red herring see viresh's =
mail.

The issue is that __cpufreq_governor() is being called when intel_pstat=
e is the
scaling driver intel_pstate does not implement ->target().  From the st=
ack
trace it looked like this was happening in __cpufreq_remove_dev() so I =
"assumed"
it was the first instance of the target fence that was failing.

I am rebuilding using the next tree with viresh's patch I will let you =
know what
I find sorry for the noise.

--Dirk
> Nate

