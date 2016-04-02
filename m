From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Sat, 2 Apr 2016 08:12:42 +0200
Message-ID: <CA+icZUX2ZtsO8pa7ZY0JKW3vm5veVCJ08q3p0ai3FxdMNgvKww@mail.gmail.com>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>
	<1459376311.13525.108.camel@linux.intel.com>
	<003b01d18ad6$831941c0$894bc540$@net>
	<CA+icZUXaoeQz5vMzPxjOaAzbzdQ4D1MV2dG5EvXAM54k6EOz1g@mail.gmail.com>
	<002301d18b59$d208fe50$761afaf0$@net>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36169 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbcDBGMn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 2 Apr 2016 02:12:43 -0400
In-Reply-To: <002301d18b59$d208fe50$761afaf0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thu, Mar 31, 2016 at 4:30 PM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2016.03.31 01:11 Sedat Dilek wrote:
>> On Thu, Mar 31, 2016 at 12:50 AM, Doug Smythies <dsmythies@telus.net> wrote:
>>> On 2106.03.30 15:19 Srinivas Pandruvada wrote:
>>>>>
>>>>> Please see attached files.
>>>>>
>>>> Thanks. Your logs make sense. You have config set to performance mode
>>>> by default (Which I believe default in all kernel Ubuntu).
>>>
>>> Yes, but via a startup script, by default Ubuntu sets the governor
>>> to powersave 1 minute after boot (or ondemand if acpi-cpufreq).
>>>
>>
>> Can you give more and precise informations on this?
>> script-name etc.
>
> The script is /etc/init.d/ondemand
> It sleeps for 1 minute and then sets the scaling
> governor, based on availability, in the following order:
> interactive
> ondemand
> powersave
>

Thanks for these informations.

$ dpkg -S /etc/init.d/ondemand
initscripts: /etc/init.d/ondemand

For the followers...

[ /etc/init.d/ondemand ]

#! /bin/sh
### BEGIN INIT INFO
# Provides:          ondemand
# Required-Start:    $remote_fs $all
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:
# Short-Description: Set the CPU Frequency Scaling governor to "ondemand"
### END INIT INFO


PATH=/sbin:/usr/sbin:/bin:/usr/bin

. /lib/init/vars.sh
. /lib/lsb/init-functions

case "$1" in
    start)
        start-stop-daemon --start --background --exec
/etc/init.d/ondemand -- background
        ;;
    background)
        sleep 60 # probably enough time for desktop login

        for CPUFREQ in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
        do
                [ -f $CPUFREQ ] || continue
                echo -n ondemand > $CPUFREQ
        done
        ;;
    restart|reload|force-reload)
        echo "Error: argument '$1' not supported" >&2
        exit 3
        ;;
    stop)
        ;;
    *)
        echo "Usage: $0 start|stop" >&2
        exit 3
        ;;
esac

[ /etc/init.d/ondemand ]

Will check...

$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

> See also:
>
> $ ls -l /etc/rc?.d/S06ondemand
> lrwxrwxrwx 1 root root 18 Mar  8 09:51 /etc/rc2.d/S06ondemand -> ../init.d/ondemand
> lrwxrwxrwx 1 root root 18 Mar  8 09:51 /etc/rc3.d/S06ondemand -> ../init.d/ondemand
> lrwxrwxrwx 1 root root 18 Mar  8 09:51 /etc/rc4.d/S06ondemand -> ../init.d/ondemand
> lrwxrwxrwx 1 root root 18 Mar  8 09:51 /etc/rc5.d/S06ondemand -> ../init.d/ondemand
>

Here it is S99...

$ LC_ALL=C ls -l /etc/rc?.d/S*ondemand
lrwxrwxrwx 1 root root 18 Mar 27  2012 /etc/rc2.d/S99ondemand ->
../init.d/ondemand
lrwxrwxrwx 1 root root 18 Mar 27  2012 /etc/rc3.d/S99ondemand ->
../init.d/ondemand
lrwxrwxrwx 1 root root 18 Mar 27  2012 /etc/rc4.d/S99ondemand ->
../init.d/ondemand
lrwxrwxrwx 1 root root 18 Mar 27  2012 /etc/rc5.d/S99ondemand ->
../init.d/ondemand

> From your other e-mail:
>
>> is somehow showing higher
>> values than TSC_MHz.
>> Not sure if this really make sense if TSC_MHz is a max-value (which I
>> don't know it is).
>
> That is normal, and is turbo mode. Example:
>
> $ sudo turbostat -i 3 --msr=0x199
>      CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz   MSR 0x199
>        -     478   12.53    3798    3413  0x00000000
>        0       3    0.09    3595    3413  0x00002500
>        4       1    0.03    3568    3413  0x00001000
>        1       4    0.11    3649    3413  0x00001200
>        5       2    0.07    3592    3413  0x00001000
>        2       3    0.08    3628    3413  0x00001000
>        6       1    0.03    3546    3413  0x00001000
>        3       1    0.02    3733    3413  0x00001000
>        7    3808   99.91    3799    3411  0x00002600
>

Ah, OK.

Thanks again.
That helped me.

I am trying CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y from
linux-pm.git#linux-next out of curiosity...

$ ./scripts/diffconfig /boot/config-$(uname -r) .config
 CPU_FREQ_DEFAULT_GOV_PERFORMANCE y -> n
+CPU_FREQ_DEFAULT_GOV_SCHEDUTIL y
+CPU_FREQ_GOV_ATTR_SET y
+CPU_FREQ_GOV_SCHEDUTIL y

...will report.

- sed@ -

[1] https://en.wikipedia.org/wiki/Curiosity_killed_the_cat
