From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [linux-pm] acpi_idle and max_cpus
Date: Mon, 18 Jun 2012 14:54:22 +0200
Message-ID: <4FDF24FE.1010108@linaro.org>
References: <4FDB549F.1020002@linaro.org> <4FDE3B96.8030306@linaro.org> <4FDF1E3A.6010200@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4FDF1E3A.6010200@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 06/18/2012 02:25 PM, Deepthi Dharwar wrote:
> Hi Daniel,
>=20
> On 06/18/2012 01:48 AM, Daniel Lezcano wrote:
>=20
>> On 06/15/2012 05:28 PM, Daniel Lezcano wrote:
>>>
>>> Hi all,
>>>
>>> I have a dual core Intel T9500.
>>>
>>> I boot the cpu with the acpi_idle driver and intel_idle enabled in =
the
>>> config.
>>>
>>> The kernel is booted with maxcpus=3D1.
>>>
>>> After the system has boot, I put cpu1 online via sysfs.
>>>
>>> But I don't see any 'cpuidle' directory in the cpu's sysfs entry:
>>>
>>> /sys/devices/system/cpu/cpu1/cpuidle (?)
>>>
>>> When I look at the code I see the notifier is present for hotplug i=
n
>>> processor_driver.c and the cpuidle intel init routine should be cal=
led
>>> there.
>>>
>=20
>=20
> Yes, we have a hotplug notifier.
> Commit 99b72508  by Thomas Renninger fixed this issue.
>=20
> Please let me know which kernel version you are running and what is i=
dle
> driver registered ?

The kernel version is 3.5.0-rc1
The registered driver is acpi_idle (with intel_idle if I am not wrong).

Thomas's patch is in this version.

Maybe I am wrong but I think the patch is not correct because:

static int __cpuinit acpi_processor_add(struct acpi_device *device)
{

 ...

#ifdef CONFIG_SMP
	if (pr->id >=3D setup_max_cpus && pr->id !=3D 0)
		return 0;
#endif

 ...

	per_cpu(processors, pr->id) =3D pr;

=2E..
}

With max_cpus=3D1 we exit before setting up 'pr'.

So the condition in:

static int acpi_cpu_soft_notify(...)
{

	unsigned int cpu =3D (unsigned long)hcpu;
	struct acpi_processor *pr =3D per_cpu(processors, cpu);

	if (action =3D=3D CPU_ONLINE && pr) {

=2E..
}

Is always false because pr =3D=3D NULL

I did the change but I don't still see the 'cpuidle' directory
appearing, I suspect also pr->flags.need_hotplug_init is not correctly
initialized but I did not investigate more.

>>> I am wondering is it a bug or an expected behavior ?
>>
>> Any thoughts on that ?
>>
>> Thanks
>>   -- Daniel
>>
>>
>=20
>=20
> Cheers
> Deepthi
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
