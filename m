From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] x86 TSC: set X86_FEATURE_TSC_RELIABLE, per CPUID
Date: Mon, 1 Jun 2015 20:45:25 -0400
Message-ID: <CAJvTdKm8mksFNnhchXepOanjCT4qiYTjmt3BtL81BepuPw+K1w@mail.gmail.com>
References: <f1643565587e70dd2fe2714e9afa566689211a9a.1433050960.git.len.brown@intel.com>
	<556CA704.1070000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33318 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbFBAp1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2015 20:45:27 -0400
In-Reply-To: <556CA704.1070000@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Mon, Jun 1, 2015 at 2:40 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On 05/30/2015 10:44 PM, Len Brown wrote:
>>
>> From: Len Brown <len.brown@intel.com>
>>
>> Speed cpu_up() by believing CPUID's "invariant TSC" flag,
>> and skipping the TSC warp test on single socket systems.
>
>
> I'm typing this email on a "Intel(R) Core(TM) i7-3930K CPU @ 3.20GHz" with a
> "X79A-GD65 (8D) (MS-7760)" motherboard.  (DO NOT BUY THAT MOTHERBOARD!)
>
> The brilliant stock firmware breaks TSC sync on bootup.  Even with the
> updated firmware I'm using, it's broken on resume from S3.

So the stock firmware broke the TSC on boot _and_ S3.
The updated firmware does not break the TSC on boot, but still breaks it on S3?

For this board, please send the output from
$ dmesg | grep -i tsc

I would think we could detect this issue much faster than requesting
the full 2ms test.

> If you want to make this depend on X86_FEATURE_TSC_ADJUST and confirm that
> all cores have the same IA32_TSC_ADJUST value, then maybe that would be
> okay.

That suggestion sounds reasonable.

BTW, it also begs the question if Linux could actually *repair* the BIOS damage?

thanks,
Len Brown, Intel Open Source Technology Center
