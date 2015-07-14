From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH] acpi-cpufreq: Add a miss ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
Date: Tue, 14 Jul 2015 10:52:35 +0800
Message-ID: <55A47973.5080900@intel.com>
References: <559F5D13.8050104@intel.com> <CAJZ5v0jwgtgC+01p8f5a7amPcTGUfps5f2Ph9rtt77=3BEk5Cg@mail.gmail.com> <55A35BA4.8020800@intel.com> <1591472.jfYRX9HXXv@vostro.rjw.lan> <55A46F6B.6030006@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47005 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbbGNCzR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Jul 2015 22:55:17 -0400
In-Reply-To: <55A46F6B.6030006@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

hi, Rafael,
	let me do more explanation :)

On 2015=E5=B9=B407=E6=9C=8814=E6=97=A5 10:09, Pan Xinhui wrote:
> hi, Rafael,
> 	thanks for you reply :)
> On 2015=E5=B9=B407=E6=9C=8814=E6=97=A5 07:26, Rafael J. Wysocki wrote=
:
>> On Monday, July 13, 2015 02:33:08 PM Pan Xinhui wrote:
>>> hi, Rafeal
>>> 	thanks for your reply. :)
>>>
>>> On 2015=E5=B9=B407=E6=9C=8811=E6=97=A5 04:44, Rafael J. Wysocki wro=
te:
>>>> Hi,
>>>>
>>>> On Fri, Jul 10, 2015 at 7:50 AM, Pan Xinhui <xinhuix.pan@intel.com=
> wrote:
>>>>>
>>>>> If CONFIG_X86_ACPI_CPUFREQ_CPB has not been defined, the placehol=
der for
>>>>> cpb is not needed. Add ifdef around it.
>>>>>
>>>>> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
>>>>> ---
>>>>>  drivers/cpufreq/acpi-cpufreq.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acp=
i-cpufreq.c
>>>>> index e7fcaa6..314a19e 100644
>>>>> --- a/drivers/cpufreq/acpi-cpufreq.c
>>>>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>>>>> @@ -884,7 +884,9 @@ static int acpi_cpufreq_resume(struct cpufreq=
_policy *policy)
>>>>>  static struct freq_attr *acpi_cpufreq_attr[] =3D {
>>>>>         &cpufreq_freq_attr_scaling_available_freqs,
>>>>>         &freqdomain_cpus,
>>>>> +#ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
>>>>>         NULL,   /* this is a placeholder for cpb, do not remove *=
/
>>>>> +#endif
>>>>
>>>> Adding the ifdef here doesn't change anything, because the next NU=
LL
>>>> will play the role of the one you've just #ifdefed and the structu=
re
>>>> will be filled with zeros from that point on anyway.
>>>>
>>> Yes, adding ifdef here does not change any binary codes. But I want=
 to make the codes more readable. :)
>>> Patch author has noticed two *NULL* here would confuse people, espe=
cially who first read this acpi-cpufreq.c file
>>> From code style point, it would be better to have #ifdef around it.=
=20
>>
>> Not really.
>>
>> Why don't you simply drop *both* NULLs?
>>
> Just like string end with *NULL* :)
>=20
> 1021 static int cpufreq_add_dev_interface(struct cpufreq_policy *poli=
cy,
> 1022                      struct device *dev)
> 1023 {
> 1024     struct freq_attr **drv_attr;
> 1025     int ret =3D 0;
> 1026=20
> 1027     /* set up files for this cpu device */
> 1028     drv_attr =3D cpufreq_driver->attr;
> 1029     while (drv_attr && *drv_attr) {
> 1030         ret =3D sysfs_create_file(&policy->kobj, &((*drv_attr)->=
attr));
> 1031         if (ret)
> 1032             return ret;
> 1033         drv_attr++;
> 1034     }
> If struct freq_attr *acpi_cpufreq_attr[] did not end with NULL, line =
1033 will access invalid data area.
> If *drv_attr(the data after struct freq_attr * array[]) happened to b=
e not NULL. panic may hit in sysfs_create_file :(
> So at least one *NULL* must be in the end of freq_attr *array[].
>=20
> Actually in acpi-cpufreq.c, in acpi_cpufreq_init function.
>  957         struct freq_attr **iter;
>  958=20
>  959         pr_debug("adding sysfs entry for cpb\n");
>  960=20
>  961         for (iter =3D acpi_cpufreq_attr; *iter !=3D NULL; iter++=
)
>  962             ;
>  963=20
>  964         /* make sure there is a terminator behind it */
>  965         if (iter[1] =3D=3D NULL)
>  966             *iter =3D &cpb;
>  967     }
> line965, check of iter[1] is not needed. Maybe the patch author was a=
fraid of an unexpected remove of first *NULL*.
> It might be a better solution to add ifdef CONFIG_X86_ACPI_CPUFREQ_CP=
B around that *NULL*, and remove this !iter[1] check.
>=20
According to line 961, the for loop, patch author assume the first *NUL=
L* may be *at any index* of struct freq_attr *acpi_cpufreq_attr[].

But according to line 965, and the comment also says *a terminator behi=
nd it*. patch author assume the first *NULL* is *just right before* the=
 second *NULL* which acts as a terminator.
The logic is incorrect. :(
Why not just
+		/* there must be two NULL in the end of acpi_cpufreq_attr[] */
+               struct freq_attr **iter =3D &acpi_cpufreq_attr[sizeof(a=
cpi_cpufreq_attr) - 2];
+               if (!WARN_ON(iter[0] || iter[1]))

I don't like that codes assume the index of first *NULL*, so maybe remo=
ving line 965, the check if iter[1] =3D=3D NULL, is more correct and be=
autiful :)


thanks
xinhui

> thanks
> xinhui
>=20
>>
>>>
>>>> You'd need to #ifdef it in the struct freq_attr definition, but I'=
m
>>>> not sure it's worth the effort.
>>>>
>>>
>>> struct freq_attr *cpb* is defined in #ifdef section. :)
>>
>> Ah, OK.
>>
>>
