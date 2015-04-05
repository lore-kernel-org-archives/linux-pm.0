From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: Unreliable hibernation on Lenovo x230 (regression)
Date: Sun, 5 Apr 2015 00:51:19 -0700
Message-ID: <CAE9FiQV95==v5VAkOUnWkGGEVWe=JEBCnw7X6gm8m26eHDgifg@mail.gmail.com>
References: <20150401214743.20fbe2c5@porcupinefactory.org>
	<20150402152805.GA17021@amd>
	<20150403175825.79816fea@porcupinefactory.org>
	<3344848.SIHh1OazTO@vostro.rjw.lan>
	<20150404101243.5a229e3b@porcupinefactory.org>
	<20150405072441.GC27614@linux-rxt1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38151 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbbDEHvU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 5 Apr 2015 03:51:20 -0400
In-Reply-To: <20150405072441.GC27614@linux-rxt1.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: joeyli <jlee@suse.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: rhn <kebuac.rhn@porcupinefactory.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Sun, Apr 5, 2015 at 12:24 AM, joeyli <jlee@suse.com> wrote:
>> >
>>
>> I took the commit 8f778bbc542ddf8f6243b21d6aca087e709cabdc as the base for further checking (I started building before I read your message). It's a descendant of 4.0-rc6, so I hope it's not going to make a difference.
>>
>> Results:
>> 8f778bb : bad
>> 8f778bb + reverted 84c91b7 : good
>> 8f778bb + patch [1] : good
>
> Thanks for your dmesg on bko#96111.
> I checked and confirm there have the situation of setup_data reserved as E820_RESERVED_KERN.
> I will add comment on bugzilla.
>
>>
>> Thanks!
>>
>> [1]:
>> x86: Kill E820_RESERVED_KERN  https://lkml.org/lkml/2015/3/4/434 as suggested in joeyli's other email.
>
> I think just revert 84c91b7ae until Yinghai Lu's patches merged to v4.1.
> I will resend 84c91b7ae patch until Yinghai Lu's patches merged.

Can you please put https://lkml.org/lkml/2015/3/4/434
into tip?

Thanks

Yinghai
