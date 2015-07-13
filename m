From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH] acpi-cpufreq: Add a miss ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
Date: Mon, 13 Jul 2015 14:33:08 +0800
Message-ID: <55A35BA4.8020800@intel.com>
References: <559F5D13.8050104@intel.com> <CAJZ5v0jwgtgC+01p8f5a7amPcTGUfps5f2Ph9rtt77=3BEk5Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58526 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbbGMGfr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Jul 2015 02:35:47 -0400
In-Reply-To: <CAJZ5v0jwgtgC+01p8f5a7amPcTGUfps5f2Ph9rtt77=3BEk5Cg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

hi, Rafeal
	thanks for your reply. :)

On 2015=E5=B9=B407=E6=9C=8811=E6=97=A5 04:44, Rafael J. Wysocki wrote:
> Hi,
>=20
> On Fri, Jul 10, 2015 at 7:50 AM, Pan Xinhui <xinhuix.pan@intel.com> w=
rote:
>>
>> If CONFIG_X86_ACPI_CPUFREQ_CPB has not been defined, the placeholder=
 for
>> cpb is not needed. Add ifdef around it.
>>
>> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
>> ---
>>  drivers/cpufreq/acpi-cpufreq.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-c=
pufreq.c
>> index e7fcaa6..314a19e 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -884,7 +884,9 @@ static int acpi_cpufreq_resume(struct cpufreq_po=
licy *policy)
>>  static struct freq_attr *acpi_cpufreq_attr[] =3D {
>>         &cpufreq_freq_attr_scaling_available_freqs,
>>         &freqdomain_cpus,
>> +#ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
>>         NULL,   /* this is a placeholder for cpb, do not remove */
>> +#endif
>=20
> Adding the ifdef here doesn't change anything, because the next NULL
> will play the role of the one you've just #ifdefed and the structure
> will be filled with zeros from that point on anyway.
>=20
Yes, adding ifdef here does not change any binary codes. But I want to =
make the codes more readable. :)
Patch author has noticed two *NULL* here would confuse people, especial=
ly who first read this acpi-cpufreq.c file
=46rom code style point, it would be better to have #ifdef around it.=20

> You'd need to #ifdef it in the struct freq_attr definition, but I'm
> not sure it's worth the effort.
>=20

struct freq_attr *cpb* is defined in #ifdef section. :)

thanks
xinhui

>>         NULL,
>>  };
>=20
> Thanks,
> Rafael
>=20
