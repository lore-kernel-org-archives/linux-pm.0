From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/1] x86 TSC: set X86_FEATURE_TSC_RELIABLE, per CPUID
Date: Sat, 6 Jun 2015 09:12:06 -0700
Message-ID: <CALCETrWOOhU-FmEDBsngRTEWU1fh+4Tvg3=rTykpovPviTnXrQ@mail.gmail.com>
References: <f1643565587e70dd2fe2714e9afa566689211a9a.1433050960.git.len.brown@intel.com>
 <556CA704.1070000@kernel.org> <CAJvTdKm8mksFNnhchXepOanjCT4qiYTjmt3BtL81BepuPw+K1w@mail.gmail.com>
 <556FFB81.8080507@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35786 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbbFFQM2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 6 Jun 2015 12:12:28 -0400
Received: by lbbtu8 with SMTP id tu8so44716944lbb.2
        for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2015 09:12:27 -0700 (PDT)
In-Reply-To: <556FFB81.8080507@zytor.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Thu, Jun 4, 2015 at 12:17 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 06/01/2015 05:45 PM, Len Brown wrote:
>>
>> BTW, it also begs the question if Linux could actually *repair* the BIOS damage?
>>
>
> We may very well be able to by setting the TSC offset register to zero
> on all CPUs.

What TSC offset register?  IIRC before Ivy Bridge (i.e. TSC_ADJUST),
there's a writable TSC register but no visible offset register.

--Andy
