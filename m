From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] x86 TSC: set X86_FEATURE_TSC_RELIABLE, per CPUID
Date: Wed, 3 Jun 2015 15:03:36 -0400
Message-ID: <CAJvTdKmnzaOEi-j4J-yA2VP+EFT014gBKX7sEPrP2cz1v02avg@mail.gmail.com>
References: <f1643565587e70dd2fe2714e9afa566689211a9a.1433050960.git.len.brown@intel.com>
	<556CA704.1070000@kernel.org>
	<CAJvTdKm8mksFNnhchXepOanjCT4qiYTjmt3BtL81BepuPw+K1w@mail.gmail.com>
	<CALCETrWJSqeJsyo7p2cw-cfrt75igQy8FLddvS5adGQ2Wu+8ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:33907 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617AbbFCTDi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 15:03:38 -0400
In-Reply-To: <CALCETrWJSqeJsyo7p2cw-cfrt75igQy8FLddvS5adGQ2Wu+8ag@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Mon, Jun 1, 2015 at 9:12 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Mon, Jun 1, 2015 at 5:45 PM, Len Brown <lenb@kernel.org> wrote:
>> On Mon, Jun 1, 2015 at 2:40 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>> On 05/30/2015 10:44 PM, Len Brown wrote:
>>>>
>>>> From: Len Brown <len.brown@intel.com>
>>>>
>>>> Speed cpu_up() by believing CPUID's "invariant TSC" flag,
>>>> and skipping the TSC warp test on single socket systems.
>>>
>>>
>>> I'm typing this email on a "Intel(R) Core(TM) i7-3930K CPU @ 3.20GHz" with a
>>> "X79A-GD65 (8D) (MS-7760)" motherboard.  (DO NOT BUY THAT MOTHERBOARD!)
>>>
>>> The brilliant stock firmware breaks TSC sync on bootup.  Even with the
>>> updated firmware I'm using, it's broken on resume from S3.
>>
>> So the stock firmware broke the TSC on boot _and_ S3.
>> The updated firmware does not break the TSC on boot, but still breaks it on S3?
>
> Exactly.
>
>>
>> For this board, please send the output from
>> $ dmesg | grep -i tsc
>
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 3199.952 MHz processor
> [    0.192253] TSC deadline timer enabled
> [    1.712495] tsc: Refined TSC clocksource calibration: 3199.960 MHz
> [    2.712791] Switched to clocksource tsc
>
> ... suspend and resume ...
>
> [   61.414518] TSC synchronization [CPU#0 -> CPU#1]:
> [   61.414518] Measured 6137255520 cycles TSC warp between CPUs,
> turning off TS clock.
> [   61.414522] tsc: Marking TSC unstable due to check_tsc_sync_source failed


If you boot this machine with "tsc=reliable", to disable the cpu_up
check_tsc_sync,
what happens?  Does the run-time clocksource code detect the bogus TSC values?
If yes, how long does that take?

>> I would think we could detect this issue much faster than requesting
>> the full 2ms test.
>>
>>> If you want to make this depend on X86_FEATURE_TSC_ADJUST and confirm that
>>> all cores have the same IA32_TSC_ADJUST value, then maybe that would be
>>> okay.
>>
>> That suggestion sounds reasonable.
>>
>> BTW, it also begs the question if Linux could actually *repair* the BIOS damage?
>
> Quite possibly.  Is there such thing as a single-socket CPU that
> claims invariant CPU on which setting TSC_ADJUST to zero on all cores
> won't result in a synchronized TSC?  (This is moot for my CPU.  I
> don't have TSC_ADJUST.)
>
> On a somewhat related note, why are we still calibrating the TSC
> frequency based on the PIT?  intel_pstate appears to know how to read
> it off directly.

Okay, so it seems that TSC_ADJUST isn't going to help us here,
as it is independent of this problem.

thanks,
Len Brown, Intel Open Source Technology Center
