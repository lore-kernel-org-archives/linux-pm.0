From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/1] x86 TSC: set X86_FEATURE_TSC_RELIABLE, per CPUID
Date: Mon, 1 Jun 2015 18:12:29 -0700
Message-ID: <CALCETrWJSqeJsyo7p2cw-cfrt75igQy8FLddvS5adGQ2Wu+8ag@mail.gmail.com>
References: <f1643565587e70dd2fe2714e9afa566689211a9a.1433050960.git.len.brown@intel.com>
 <556CA704.1070000@kernel.org> <CAJvTdKm8mksFNnhchXepOanjCT4qiYTjmt3BtL81BepuPw+K1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33158 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbbFBBMw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2015 21:12:52 -0400
Received: by lbcue7 with SMTP id ue7so95007374lbc.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2015 18:12:50 -0700 (PDT)
In-Reply-To: <CAJvTdKm8mksFNnhchXepOanjCT4qiYTjmt3BtL81BepuPw+K1w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Mon, Jun 1, 2015 at 5:45 PM, Len Brown <lenb@kernel.org> wrote:
> On Mon, Jun 1, 2015 at 2:40 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> On 05/30/2015 10:44 PM, Len Brown wrote:
>>>
>>> From: Len Brown <len.brown@intel.com>
>>>
>>> Speed cpu_up() by believing CPUID's "invariant TSC" flag,
>>> and skipping the TSC warp test on single socket systems.
>>
>>
>> I'm typing this email on a "Intel(R) Core(TM) i7-3930K CPU @ 3.20GHz" with a
>> "X79A-GD65 (8D) (MS-7760)" motherboard.  (DO NOT BUY THAT MOTHERBOARD!)
>>
>> The brilliant stock firmware breaks TSC sync on bootup.  Even with the
>> updated firmware I'm using, it's broken on resume from S3.
>
> So the stock firmware broke the TSC on boot _and_ S3.
> The updated firmware does not break the TSC on boot, but still breaks it on S3?

Exactly.

>
> For this board, please send the output from
> $ dmesg | grep -i tsc

[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3199.952 MHz processor
[    0.192253] TSC deadline timer enabled
[    1.712495] tsc: Refined TSC clocksource calibration: 3199.960 MHz
[    2.712791] Switched to clocksource tsc

... suspend and resume ...

[   61.414518] TSC synchronization [CPU#0 -> CPU#1]:
[   61.414518] Measured 6137255520 cycles TSC warp between CPUs,
turning off TS clock.
[   61.414522] tsc: Marking TSC unstable due to check_tsc_sync_source failed

>
> I would think we could detect this issue much faster than requesting
> the full 2ms test.
>
>> If you want to make this depend on X86_FEATURE_TSC_ADJUST and confirm that
>> all cores have the same IA32_TSC_ADJUST value, then maybe that would be
>> okay.
>
> That suggestion sounds reasonable.
>
> BTW, it also begs the question if Linux could actually *repair* the BIOS damage?

Quite possibly.  Is there such thing as a single-socket CPU that
claims invariant CPU on which setting TSC_ADJUST to zero on all cores
won't result in a synchronized TSC?  (This is moot for my CPU.  I
don't have TSC_ADJUST.)

On a somewhat related note, why are we still calibrating the TSC
frequency based on the PIT?  intel_pstate appears to know how to read
it off directly.

--Andy
