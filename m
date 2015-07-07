From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH] acpi-cpufreq.c: fix a memory leak in acpi_cpufreq_cpu_exit
Date: Tue, 07 Jul 2015 15:52:23 +0800
Message-ID: <559B8537.5010309@intel.com>
References: <559A2073.1000301@intel.com> <20150707065449.GD14598@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49060 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbbGGHy4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 03:54:56 -0400
In-Reply-To: <20150707065449.GD14598@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

hi, Viresh
	thanks for your reply.

On 2015=E5=B9=B407=E6=9C=8807=E6=97=A5 14:54, Viresh Kumar wrote:
> On 06-07-15, 14:30, Pan Xinhui wrote:
>>
>> policy->cpu in acpi_cpufreq_cpu_init/exit is the same cpu in most ca=
ses.
>> However during cpu hotplug,
>> cpufreq core might nominate a new cpu for policy->cpu.
>=20
> Why aren't above lines well aligned? A simple trick to share for vim
> users:
>=20
> - Select lines you want to auto-align with shift+v and up-down keys
> - press gq
> - That's it and vim will do it for you. You need to set vim's
>   'textwidth' to 72 or 80, based on what you are editing, so that vim
>   knows where you need to break the line. I have this in vimrc
>=20
>         set textwidth=3D80
>         au FileType gitcommit set textwidth=3D72
>=20

thanks, that will save me time.

>=20
>=20
> Back to the real stuff. Few core changes have gone into v4.2-rc1 and
> policy->cpu doesn't change any longer on hotplug (unless its a
> physical hotplug). So you shouldn't see any issues.
>=20
I have latest codes.
codes in cpufreq.c are below.
1436     down_write(&policy->rwsem);
1437     cpumask_clear_cpu(cpu, policy->cpus);
1438=20
1439     if (policy_is_inactive(policy)) {
1440         if (has_target())
1441             strncpy(policy->last_governor, policy->governor->name,
1442                 CPUFREQ_NAME_LEN);
1443     } else if (cpu =3D=3D policy->cpu) {
1444         /* Nominate new CPU */
1445         policy->cpu =3D cpumask_any(policy->cpus);
1446     }
1447     up_write(&policy->rwsem);

line 1445 will change the policy->cpu.
for example, cpu2,3 has same policy, and policy->cpu is 2 at beginning.
If we disable cpu2, policy->cpu is 3.
yes, at most time, cpu0,1,2,3,,etc share the same policy, and policy->c=
pu is 0 which can't be offline.
So no memory leak. it is just lucky. :)

back to my previous patch, you suggest me to use policy->driver_data to=
 *store* data and don't need use per_cpu anymore.
codes in acpi-cpufreq.c are below.
 365 static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 366 {
 367     struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, cpu);
 368     unsigned int freq;
 369     unsigned int cached_freq;
=20
we get *data* through per_cpu for now, as the parameter is cpu only.
If we store *data* in policy->driver_data, we need call
struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu) to get policy.
We do a full codes review, and find there should be deadlock if we doin=
g so.
But as cpufreq code offers
238 /* Only for cpufreq core internal use */
239 struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)

I have a small question,if we can use *cpufreq_cpu_get_raw* in ->get ca=
llback, which is already lock hold,
But the comment(line 238) is... hmm.

thanks for your kind reply. any advices or comments are welcome.

thanks
xinhui
