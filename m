From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: 3.9.0 + CONFIG_X86_INTEL_PSTATE=y  -> ThinkPad T420 with i5 lost
 ACPI functionality
Date: Mon, 13 May 2013 09:43:18 -0700
Message-ID: <51911826.907@gmail.com>
References: <5183EC09.9080208@gmx.de> <3715884.H8PIhhjRXL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3715884.H8PIhhjRXL@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>, Dirk Brandewie <dirk.brandewie@gmail.com>, linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
List-Id: linux-pm@vger.kernel.org

On 05/03/2013 12:36 PM, Rafael J. Wysocki wrote:
> On Friday, May 03, 2013 06:55:37 PM Toralf F=C3=B6rster wrote:
>> The following file doesn't exists at my Gentoo Linux
>> /sys/devices/system/cpu/cpufreq/ondemand/ignore_nice_load
>> in 3.9.0 if I activate CONFIG_X86_INTEL_PSTATE=3Dy
>>
>> That means, that a command like
>>
>> $> echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/ignore_nice_loa=
d
>>
>> in /etc/rc.local is now no longer working.
>> A high fan +  high temperature are the result, even if just the BOIN=
C client
>> is run with low prio (nice 19) in the back ground.
>>
>> Manually loading the missing module won't work too :
>>
>> $> modprobe acpi_cpufreq
>> modprobe: ERROR: could not insert 'acpi_cpufreq': Device or resource=
 busy
>>
>> Is the behaviour a bug or a feature ?
>
> The thermal management problem is not an intentional outcome, definit=
ely.
>
>> In the later case: How can I achieve the previous behaviour back ?
>>

I spent some more time looking for a solution to this you can get same =
behavior
by setting a config option in BOINC  "Use at most X % CPU time"
see: http://boinc.berkeley.edu/wiki/Local_preferences


>> This issue might affect the RH EL kernel too [1] where I observed a =
similar behaviour.
>>
>>
>> [1] http://elrepo.org/bugs/view.php?id=3D379
>
> Dirk, is this the problem we were talking about recently or something=
 else?
>
> Rafael
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
