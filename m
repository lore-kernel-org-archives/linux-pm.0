From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: stable 3-10-3: strange output of  "lsmod | grep ^acpi_cpufreq"
Date: Mon, 29 Jul 2013 17:14:25 +0530
Message-ID: <51F65599.6050209@linux.vnet.ibm.com>
References: <51F40612.2050403@gmx.de> <2368277.VjYrsHUseA@vostro.rjw.lan> <51F638D9.7050904@linux.vnet.ibm.com> <10771278.LGR8ezfsZF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:49562 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab3G2LsF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2013 07:48:05 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 30 Jul 2013 08:43:10 +1000
In-Reply-To: <10771278.LGR8ezfsZF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On 07/29/2013 05:19 PM, Rafael J. Wysocki wrote:
> On Monday, July 29, 2013 03:11:45 PM Srivatsa S. Bhat wrote:
>> On 07/29/2013 04:50 AM, Rafael J. Wysocki wrote:
>>> On Monday, July 29, 2013 12:43:59 AM Rafael J. Wysocki wrote:
>>>> On Monday, July 29, 2013 12:11:18 AM Rafael J. Wysocki wrote:
>>>>> On Sunday, July 28, 2013 12:21:22 PM Toralf F=C3=B6rster wrote:
>>>>>> On 07/28/2013 01:39 AM, Rafael J. Wysocki wrote:
>>>>>>> On Saturday, July 27, 2013 07:40:34 PM Toralf F=C3=B6rster wrot=
e:
>>>>>>>> it gives at a ThinkPad T420:
>>>>>>>>
>>>>>>>> tfoerste@n22 ~/tmp $ lsmod | grep ^acpi_cpufreq
>>>>>>>> acpi_cpufreq           12902  2147483647
>>>>>>>
>>>>>>> That is -1, which indicates some module refcount woes.
>>>>>>
>>>>>> yes, ofc.
>>>>>>
>>>>>> The issue apears after 1 s2ram/resume cycle, before s2ram the re=
fcount is 1.
>>>>>>
>>>>>>> I definitely can't see that with the mainline on my machines.
>>>>>>
>>>>>> It is in mainline too.
>>>>>
>>>>> Does the appended patch help?
>>>>
>>>> Actually, something as simple as this also should help:
>>>>
>>>> ---
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> Subject: cpufreq: Fix cpufreq driver module refcount balance after=
 suspend/resume
>>>>
>>>> Since cpufreq_cpu_put() called by __cpufreq_remove_dev() drops the
>>>> driver module refcount, __cpufreq_remove_dev() causes that refcoun=
t
>>>> to become negative after a suspend/resume cycle, for example.
>>>>
>>>> To prevent this from happening make __cpufreq_remove_dev() put
>>>> the policy kobject only instead of calling cpufreq_cpu_put().
>>>
>>> Having a deeper look at it, though, I see that in fact the whole
>>> cpufreq_cpu_put() is needed if the CPU is not the last one for the =
given
>>> policy and is not needed at all otherwise (as described in the chan=
gelog
>>> of the patch below).
>>>
>>> Srivatsa, does this make sense to you?
>>>
>>
>> Code-wise, your patch looks good to me. But one thing in the existin=
g code
>> struck me as a little strange.
>>
>> I'm assuming that the module_get() is used in the cpufreq core to en=
sure that
>> until the cpufreq core is managing (atleast one) CPU(s), the cpufreq=
 backend
>> driver module (eg: acpi-cpufreq) can't be removed.
>=20
> Quite frankly, I'm not sure about that.  If that were the case,
> cpufreq_add_dev() would not call module_put() which it does.
>=20
> That may be a bug, I agree, but that's not for the present release cy=
cle.  For
> now, we need to ensure that the reference counts are *balanced* .
>=20

Sure, in that case, I agree that your patch is the right fix at this po=
int,
since it resolves the immediate problem that we have with the refcounts=
=2E

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

