From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/1] x86 TSC: set X86_FEATURE_TSC_RELIABLE, per CPUID
Date: Mon, 8 Jun 2015 16:24:21 -0700
Message-ID: <CALCETrUvkBLQZXQYKs2nNTgUeBQvP1jntFPEkh0m6r_-CQt3-w@mail.gmail.com>
References: <f1643565587e70dd2fe2714e9afa566689211a9a.1433050960.git.len.brown@intel.com>
 <556CA704.1070000@kernel.org> <CAJvTdKm8mksFNnhchXepOanjCT4qiYTjmt3BtL81BepuPw+K1w@mail.gmail.com>
 <CALCETrWJSqeJsyo7p2cw-cfrt75igQy8FLddvS5adGQ2Wu+8ag@mail.gmail.com> <CAJvTdKmnzaOEi-j4J-yA2VP+EFT014gBKX7sEPrP2cz1v02avg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:36138 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbbFHXYn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 19:24:43 -0400
Received: by laar3 with SMTP id r3so1283035laa.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2015 16:24:42 -0700 (PDT)
In-Reply-To: <CAJvTdKmnzaOEi-j4J-yA2VP+EFT014gBKX7sEPrP2cz1v02avg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Wed, Jun 3, 2015 at 12:03 PM, Len Brown <lenb@kernel.org> wrote:
> On Mon, Jun 1, 2015 at 9:12 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Mon, Jun 1, 2015 at 5:45 PM, Len Brown <lenb@kernel.org> wrote:
>>> On Mon, Jun 1, 2015 at 2:40 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>>> On 05/30/2015 10:44 PM, Len Brown wrote:
>>>>>
>>>>> From: Len Brown <len.brown@intel.com>
>>>>>
>>>>> Speed cpu_up() by believing CPUID's "invariant TSC" flag,
>>>>> and skipping the TSC warp test on single socket systems.
>>>>
>>>>
>>>> I'm typing this email on a "Intel(R) Core(TM) i7-3930K CPU @ 3.20GHz" with a
>>>> "X79A-GD65 (8D) (MS-7760)" motherboard.  (DO NOT BUY THAT MOTHERBOARD!)
>>>>
>>>> The brilliant stock firmware breaks TSC sync on bootup.  Even with the
>>>> updated firmware I'm using, it's broken on resume from S3.
>>>
>>> So the stock firmware broke the TSC on boot _and_ S3.
>>> The updated firmware does not break the TSC on boot, but still breaks it on S3?
>>
>> Exactly.
>>
>>>
>>> For this board, please send the output from
>>> $ dmesg | grep -i tsc
>>
>> [    0.000000] tsc: Fast TSC calibration using PIT
>> [    0.000000] tsc: Detected 3199.952 MHz processor
>> [    0.192253] TSC deadline timer enabled
>> [    1.712495] tsc: Refined TSC clocksource calibration: 3199.960 MHz
>> [    2.712791] Switched to clocksource tsc
>>
>> ... suspend and resume ...
>>
>> [   61.414518] TSC synchronization [CPU#0 -> CPU#1]:
>> [   61.414518] Measured 6137255520 cycles TSC warp between CPUs,
>> turning off TS clock.
>> [   61.414522] tsc: Marking TSC unstable due to check_tsc_sync_source failed
>
>
> If you boot this machine with "tsc=reliable", to disable the cpu_up
> check_tsc_sync,
> what happens?  Does the run-time clocksource code detect the bogus TSC values?
> If yes, how long does that take?

They didn't detect it in the time I watched it.

[    0.000000] Command line: rd.md=0 rd.dm=0
rd.lvm.lv=vg_amaluto_2014/root  KEYTABLE=us
rd.luks.uuid=luks-1dd64d38-40c0-4e20-ad67-aa2590991023 SYSFONT=True ro
root=/dev/mapper/vg_amaluto_2014-root LANG=en_US.UTF-8 rhgb quiet
modprobe.blacklist=nvidia tsc=reliable
[    0.000000] Kernel command line: rd.md=0 rd.dm=0
rd.lvm.lv=vg_amaluto_2014/root  KEYTABLE=us
rd.luks.uuid=luks-1dd64d38-40c0-4e20-ad67-aa2590991023 SYSFONT=True ro
root=/dev/mapper/vg_amaluto_2014-root LANG=en_US.UTF-8 rhgb quiet
modprobe.blacklist=nvidia tsc=reliable
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3200.188 MHz processor
[    0.186542] TSC deadline timer enabled
[    0.312543] Skipped synchronization checks as TSC is reliable.
[    1.683795] tsc: Refined TSC clocksource calibration: 3199.967 MHz
[    1.685339] Switched to clocksource tsc
[  147.158279] Skipped synchronization checks as TSC is reliable.
[  149.086532] Skipped synchronization checks as TSC is reliable.
[  149.098287] Skipped synchronization checks as TSC is reliable.
[  149.110045] Skipped synchronization checks as TSC is reliable.
[  149.121809] Skipped synchronization checks as TSC is reliable.
[  149.133186] Skipped synchronization checks as TSC is reliable.
[  149.144560] Skipped synchronization checks as TSC is reliable.
[  149.155948] Skipped synchronization checks as TSC is reliable.
[  149.167349] Skipped synchronization checks as TSC is reliable.
[  149.178758] Skipped synchronization checks as TSC is reliable.
[  149.190186] Skipped synchronization checks as TSC is reliable.


--Andy
