From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: 3.9.0 + CONFIG_X86_INTEL_PSTATE=y  -> ThinkPad T420 with i5 lost
 ACPI functionality
Date: Fri, 03 May 2013 14:10:44 -0700
Message-ID: <518427D4.3050104@gmail.com>
References: <5183EC09.9080208@gmx.de> <3715884.H8PIhhjRXL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:65168 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763484Ab3ECVKr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 17:10:47 -0400
In-Reply-To: <3715884.H8PIhhjRXL@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>, Dirk Brandewie <dirk.brandewie@gmail.com>, linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>

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


ignore_nice_load is a feature of the ondemand governor.

The intel_pstate driver is seeing the load presented by the BOINC clien=
t and
is adjusting the pstate accordingly.

>> Manually loading the missing module won't work too :
>>
>> $> modprobe acpi_cpufreq
>> modprobe: ERROR: could not insert 'acpi_cpufreq': Device or resource=
 busy
>>
>> Is the behaviour a bug or a feature ?

The intel_pstate drive has already registered as a scaling driver so wh=
en
acpi_cpufreq tries to register as a scaling driver the registration fai=
ls

>
> The thermal management problem is not an intentional outcome, definit=
ely.
>
>> In the later case: How can I achieve the previous behaviour back ?
>>

If you require the ondemand governor you can remove CONFIG_X86_INTEL_PS=
TATE
from your configuration or add "intel_pstate=3Ddisable" to your kernel =
command
line.

--Dirk
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

