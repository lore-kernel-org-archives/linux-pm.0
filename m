From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH V2] acpi-cpufreq: replace per_cpu with driver_data of
 policy
Date: Wed, 08 Jul 2015 20:28:28 +0800
Message-ID: <559D176C.5000205@intel.com>
References: <559BC96E.8020804@intel.com> <20150707171126.GB12491@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150707171126.GB12491@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

hi, Dmitry=09
	thanks for your reply

On 2015=E5=B9=B407=E6=9C=8808=E6=97=A5 01:11, Dmitry Torokhov wrote:
> Hi Pan,
>=20
> On Tue, Jul 07, 2015 at 08:43:26PM +0800, Pan Xinhui wrote:
>> @@ -364,19 +363,24 @@ static u32 get_cur_val(const struct cpumask *m=
ask)
>> =20
>>  static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>>  {
>> -	struct acpi_cpufreq_data *data =3D per_cpu(acfreq_data, cpu);
>> +	struct acpi_cpufreq_data *data;
>> +	struct cpufreq_policy *policy;
>>  	unsigned int freq;
>>  	unsigned int cached_freq;
>> =20
>>  	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
>> =20
>> -	if (unlikely(data =3D=3D NULL ||
>> -		     data->acpi_data =3D=3D NULL || data->freq_table =3D=3D NULL)=
) {
>> +	policy =3D cpufreq_cpu_get(cpu);
>> +	if (unlikely(!policy))
>> +		return 0;
>> +
>> +	data =3D policy->driver_data;
>> +	cpufreq_cpu_put(policy);
>=20
> If we put policy here can we guarantee that memory pointed to by data
> stays valid? Shoudln't we issue cpufreq_cpu_put(policy) after we done
> assessing the pointer?
>=20

*driver_data* is used internal by acpi-cpufreq driver. So probably issu=
ing
cpufreq_cpu_put(policy) after we get *driver_data* is OKay.

The worry you have is about the race. we set *driver_data* to NULL then=
=20
free it in ->exit callback while ->get callback is using it.

CPU A                                   CPU B
->get					->exit
data =3D policy->driver_data;
if (!data ....)
					policy->driver_data =3D NULL;
					kfree(data);
access data ....

yes, it might happen in real world. As Viresh says, it is more like to =
be a core level work.
But this race exists in current codes, too. Maybe down_write policy->rw=
sem can avoid this race(need double check).

thanks for pointing out it. :)

thanks
xinhui

>> +	if (unlikely(!data || !data->acpi_data || !data->freq_table))
>>  		return 0;
>> -	}
>> =20
>>  	cached_freq =3D data->freq_table[data->acpi_data->state].frequency=
;
>> -	freq =3D extract_freq(get_cur_val(cpumask_of(cpu)), data);
>> +	freq =3D extract_freq(get_cur_val(cpumask_of(cpu), data), data);
>>  	if (freq !=3D cached_freq) {
>>  		/*
>>  		 * The dreaded BIOS frequency change behind our back.
>=20
> Thanks.
>=20
