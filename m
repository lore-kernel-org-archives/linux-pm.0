From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [intel-pstate driver regression] processor frequency very high even if in idle
Date: Fri, 1 Apr 2016 00:20:32 -0700
Message-ID: <000d01d18be6$fae22a80$f0a67f80$@net>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>	<CADDKRnCH3yCut7A4Gvk3gHw4OpOYXoG0VQRe5mh2nTjptYU0gw@mail.gmail.com>	<4187911.uaFVupaTVL@vostro.rjw.lan>	<CADDKRnCr0riAu4pjYRkuguoCoAjWxFoc+pU1NBymPr+3JnVanQ@mail.gmail.com>	<CAJZ5v0i48Xxyp880SQ1iVDzct--vhTVggCS_wHHA7bt7D+_sFg@mail.gmail.com>	<1459352017.13525.45.camel@intel.com>	<CADDKRnA5x9dK=6KZWijiP_ihrUA9Afpmqw8TSzYn9oaBeaOfKw@mail.gmail.com>	<002401d18ab5$0bf84a30$23e8de90$@net>	<1459364336.13525.69.camel@linux.intel.com>	<CAJZ5v0gDNYRNaLKFCnPRomOhavLPD=zgp1oJdRv6OtHLb031Bw@mail.gmail.com>	<1459369587.13525.75.camel@linux.intel.com> <CADDKRnCfaG35EXp_thOqfG=6sjov7f1q521LSGL8oFqRfCqSaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta2.telus.net ([209.171.16.75]:53995 "EHLO cmta2.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428AbcDAHUj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 03:20:39 -0400
In-Reply-To: <CADDKRnCfaG35EXp_thOqfG=6sjov7f1q521LSGL8oFqRfCqSaw@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?'J=C3=B6rg_Otte'?= <jrg.otte@gmail.com>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>

On 2016.03.31 02:24 J=C3=B6rg Otte wrote:
> 2016-03-30 22:26 GMT+02:00 Srinivas Pandruvada wrote:
>> On Wed, 2016-03-30 at 22:12 +0200, Rafael J. Wysocki wrote:
>>> On Wed, Mar 30, 2016 at 8:58 PM, Srinivas Pandruvada wrote:
>>>> On Wed, 2016-03-30 at 11:50 -0700, Doug Smythies wrote:

=2E.. [cut]...

>>>>>> Distro: Ubuntu 14.04.4 LTS
>>>>>> Note that with Ubuntu 14.04, I had issues where my CPU
>>>>>> would lock at pstate 24 (not always 24, but usually),
>>>>>> regardless of load.
>>>>>> However, it was always after an S3 suspend, occurred 100%
>>>>>> of the time, and was independent of intel_pstate or
>>>>>> acpi-cpufreq CPU frequency scaling drivers.
>>>>>>
>>>>>> Since changing my test server to Ubuntu server edition 16.04
>>>>>> (development version), I have not had those issues. While I have
>>>>>> no proof, I have assumed the issue elimination was somehow
>>>>>> related
>>>>>> to the change to systemd.
>>>>>>
>>>>>> It might be worth observing both what the intel_pstate is asking
>>>>>> for and what the processor is actually doing.
>>>> If J=C3=B6rg runs with
>>>>
>> turbostat -i 1 --msr=3D0x199
>>
>> We can tell whether if we requested or the same problem you had.

Yes, it proves that pstate was requested, but it does not disprove that
the processor is in the locked up state.

=2E..[cut]...

> jojo@fichte:/sys/devices/system/cpu/cpufreq/policy0$ cat scaling_gove=
rnor
> powersave

> turbostat -i 1 --msr=3D0x199
> CPUID(7): No-SGX
>     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
>       -      45    1.74    2590    2496  0x00000000
>       0      45    1.76    2565    2498  0x00000a00
>       1      72    2.84    2548    2496  0x00000800
>       2      30    1.11    2661    2496  0x00001a00
>       3      33    1.23    2661    2495  0x00001a00
>     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
>       -       9    0.35    2525    2495  0x00000000
>       0       1    0.04    2735    2495  0x00000800
>       1       1    0.05    2501    2495  0x00000800
>       2      17    0.65    2540    2495  0x00001a00
>       3      16    0.64    2501    2495  0x00001a00
>     CPU Avg_MHz   Busy% Bzy_MHz TSC_MHz   MSR 0x199
>       -      11    0.43    2523    2495  0x00000000
>       0       3    0.11    2631    2495  0x00000c00
>       1       7    0.27    2524    2495  0x00000800
>       2      18    0.72    2527    2495  0x00001a00
>       3      15    0.61    2501    2495  0x00001a00

While there are other scenarios that would explain the
data, it is consistent with the processor locked pstate
scenario.

The suggestion is to limit what the intel_pstate driver will ask
for, and observe what is being given.

Example (using my computer, which is working fine):

1.) What is the minimum?

$ cat /sys/devices/system/cpu/intel_pstate/min_perf_pct
42

2.) Set the maximum the same as the minimum?

$ sudo su
root@s15:/home/doug/temp#
root@s15:/home/doug/temp# echo "42" > /sys/devices/system/cpu/intel_pst=
ate/max_perf_pct

3.) check it:

root@s15:/home/doug/temp# cat /sys/devices/system/cpu/intel_pstate/max_=
perf_pct
42

3.) Observe what is being asked for and given:

root@s15:/home/doug/temp# modprobe msr
root@s15:/home/doug/temp# rdmsr --bitfield 15:8 -d -a 0x198
16
16
16
16
16
16
16
16
root@s15:/home/doug/temp# rdmsr --bitfield 15:8 -d -a 0x199
16
16
16
16
16
16
16
16

J=C3=B6rg: As Srinivas mentioned, your kernel configuration is very
odd. You mentioned you are using Ubuntu 14.04.4. Could you try
the Ubuntu mainline kernel 4.6-rc1? You can get it here:

http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.6-rc1-wily/

The reason I have been asking for trace data via a different
method than Rafael and Srinivas, is because I use a set
of post processing tools, originally created by the=20
original intel_pstate driver maintainer.

=2E.. Doug


