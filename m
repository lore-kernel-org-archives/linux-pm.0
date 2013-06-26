From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 2/2] CPUFreq: Add new sysfs attribute freqdomain_cpus
 for acpi-freq driver
Date: Wed, 26 Jun 2013 10:17:53 +0800
Message-ID: <51CA4F51.7090508@intel.com>
References: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com> <CAKohpo=K8fN=AhSKRRNRq-UXNhJ3YFVe6YKG+mAbq079TD4Yyg@mail.gmail.com> <51C95282.3040305@intel.com> <1453366.xvWmsCZd02@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1453366.xvWmsCZd02@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2013=E5=B9=B406=E6=9C=8826=E6=97=A5 07:02, Rafael J. Wysocki wrote:
> On Tuesday, June 25, 2013 04:19:14 PM Lan Tianyu wrote:
>> On 2013=E5=B9=B406=E6=9C=8825=E6=97=A5 15:48, Viresh Kumar wrote:
>>> On 25 June 2013 12:24, Lan Tianyu <tianyu.lan@intel.com> wrote:
>>>> On 2013=E5=B9=B406=E6=9C=8825=E6=97=A5 11:56, Viresh Kumar wrote:
>>>
>>>>> This is generic file, don't add this information here. Add this i=
n
>>>>> acpi-cpufreq file.
>>>> I don't find acpi-cpufreq.txt under
>>>> Documentation/cpu-freq/acpi-cpufreq.txt. So I should create it?
>>>
>>> I meant acpi-cpufreq.c file
>> Ok. From my opinion, the new attribute is an ABI and it's better to =
add
>> descriptor under Document directory. The user can be easy to find ho=
w to
>> use it.
>=20
> Yes, this should be documented under Documentation/ABI/testing/.

I find the following descriptor in the
Documentation/ABI/testing/sysfs-devices-system-cpu. So I originally put
the new attribute descriptor in the user-guide.txt. Now, creating new
acpi-cpufreq file under Documentation/cpu-freq/ and adding the
descriptor in the new file maybe a good choice?


What:           /sys/devices/system/cpu/cpu#/cpufreq/*
Date:           pre-git history
Contact:        cpufreq@vger.kernel.org
Description:    Discover and change clock speed of CPUs

                Clock scaling allows you to change the clock speed of t=
he
                CPUs on the fly. This is a nice method to save battery
                power, because the lower the clock speed, the less powe=
r
                the CPU consumes.

                There are many knobs to tweak in this directory.

                See files in Documentation/cpu-freq/ for more informati=
on.

                In particular, read Documentation/cpu-freq/user-guide.t=
xt
                to learn how to control the knobs.


>=20
> Thanks,
> Rafael
>=20
>=20


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
