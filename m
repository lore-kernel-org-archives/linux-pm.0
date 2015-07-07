From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH] acpi-cpufreq.c: fix a memory leak in acpi_cpufreq_cpu_exit
Date: Tue, 07 Jul 2015 17:31:52 +0800
Message-ID: <559B9C88.4000909@intel.com>
References: <559A2073.1000301@intel.com> <20150707065449.GD14598@linux> <559B8537.5010309@intel.com> <20150707085342.GF14598@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8383 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbbGGJeY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 05:34:24 -0400
In-Reply-To: <20150707085342.GF14598@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

hi, Viresh
	thanks for your quick reply :)

On 2015=E5=B9=B407=E6=9C=8807=E6=97=A5 16:53, Viresh Kumar wrote:
> On 07-07-15, 15:52, Pan Xinhui wrote:
>> I have latest codes.
>> codes in cpufreq.c are below.
>> 1436     down_write(&policy->rwsem);
>> 1437     cpumask_clear_cpu(cpu, policy->cpus);
>> 1438=20
>> 1439     if (policy_is_inactive(policy)) {
>> 1440         if (has_target())
>> 1441             strncpy(policy->last_governor, policy->governor->na=
me,
>> 1442                 CPUFREQ_NAME_LEN);
>> 1443     } else if (cpu =3D=3D policy->cpu) {
>> 1444         /* Nominate new CPU */
>> 1445         policy->cpu =3D cpumask_any(policy->cpus);
>> 1446     }
>> 1447     up_write(&policy->rwsem);
>=20
> Sigh. Too bad. So what has changed is that the sysfs directory is
> allocated to policy->cpu during init and never changed. But
> policy->cpu can surely change.
>=20
> Sorry for that.
>=20

That's OKay. You are very busy reviewing codes written by still fresh g=
uys like me.

>> back to my previous patch, you suggest me to use policy->driver_data=
 to *store* data and don't need use per_cpu anymore.
>> codes in acpi-cpufreq.c are below.
>>  365 static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>>  366 {
>>  367     struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, cpu=
);
>>  368     unsigned int freq;
>>  369     unsigned int cached_freq;
>> =20
>> we get *data* through per_cpu for now, as the parameter is cpu only.
>> If we store *data* in policy->driver_data, we need call
>> struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu) to get poli=
cy.
>> We do a full codes review, and find there should be deadlock if we d=
oing so.
>=20
> Why?
>=20
sorry, after double check. it's not caused by cpufreq_cpu_get.
I am working on several branches, these codes are little different, it'=
s OKay here.
Sorry for mistakes.

>> But as cpufreq code offers
>> 238 /* Only for cpufreq core internal use */
>> 239 struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
>>
>> I have a small question,if we can use *cpufreq_cpu_get_raw* in ->get=
 callback, which is already lock hold,
>> But the comment(line 238) is... hmm.
>=20
> That is more internal to the core. Better don't use it.
>

yes, *cpufreq_cpu_get* is OKay. thanks.
=20
>> thanks for your kind reply. any advices or comments are welcome.
>=20
> Anyway, your patch is far from complete. You have just fixed a single
> place where per-cpu data is accessed with policy->cpu. What about res=
t
> of the code? Like target() :)
>=20
I have generated one patch which replacing all per_cpu with *driver_dat=
a*, it works well in our Intel's branch for at least 2 days.
Let me do more codes review and tests before sending to LKML. :)
thanks for your advices :) it's really good.

thanks
xinhui

> --
> viresh
>=20
