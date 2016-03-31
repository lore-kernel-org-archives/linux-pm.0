From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [intel-pstate driver regression] processor frequency very high even if in idle
Date: Thu, 31 Mar 2016 07:30:04 -0700
Message-ID: <002301d18b59$d208fe50$761afaf0$@net>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>	<1459376311.13525.108.camel@linux.intel.com>	<003b01d18ad6$831941c0$894bc540$@net> <CA+icZUXaoeQz5vMzPxjOaAzbzdQ4D1MV2dG5EvXAM54k6EOz1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+icZUXaoeQz5vMzPxjOaAzbzdQ4D1MV2dG5EvXAM54k6EOz1g@mail.gmail.com>
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, =?utf-8?Q?'J=C3=B6rg_Otte'?= <jrg.otte@gmail.com>, linux-pm@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2016.03.31 01:11 Sedat Dilek wrote:
> On Thu, Mar 31, 2016 at 12:50 AM, Doug Smythies <dsmythies@telus.net> wrote:
>> On 2106.03.30 15:19 Srinivas Pandruvada wrote:
>>>>
>>>> Please see attached files.
>>>>
>>> Thanks. Your logs make sense. You have config set to performance mode
>>> by default (Which I believe default in all kernel Ubuntu).
>>
>> Yes, but via a startup script, by default Ubuntu sets the governor
>> to powersave 1 minute after boot (or ondemand if acpi-cpufreq).
>>
>
> Can you give more and precise informations on this?
> script-name etc.

The script is /etc/init.d/ondemand
It sleeps for 1 minute and then sets the scaling
governor, based on availability, in the following order:
interactive
ondemand
powersave

See also:

$ ls -l /etc/rc?.d/S06ondemand
lrwxrwxrwx 1 root root 18 Mar  8 09:51 /etc/rc2.d/S06ondemand -> ../init.d/ondemand
lrwxrwxrwx 1 root root 18 Mar  8 09:51 /etc/rc3.d/S06ondemand -> ../init.d/ondemand
lrwxrwxrwx 1 root root 18 Mar  8 09:51 /etc/rc4.d/S06ondemand -> ../init.d/ondemand
lrwxrwxrwx 1 root root 18 Mar  8 09:51 /etc/rc5.d/S06ondemand -> ../init.d/ondemand

>From your other e-mail:

> is somehow showing higher
> values than TSC_MHz.
> Not sure if this really make sense if TSC_MHz is a max-value (which I
> don't know it is).

That is normal, and is turbo mode. Example:

$ sudo turbostat -i 3 --msr=0x199
     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz   MSR 0x199
       -     478   12.53    3798    3413  0x00000000
       0       3    0.09    3595    3413  0x00002500
       4       1    0.03    3568    3413  0x00001000
       1       4    0.11    3649    3413  0x00001200
       5       2    0.07    3592    3413  0x00001000
       2       3    0.08    3628    3413  0x00001000
       6       1    0.03    3546    3413  0x00001000
       3       1    0.02    3733    3413  0x00001000
       7    3808   99.91    3799    3411  0x00002600

... Doug
