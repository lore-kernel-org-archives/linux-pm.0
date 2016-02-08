From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v4 00/13] arm64: kernel: Add support for hibernate/suspend-to-disk
Date: Mon, 08 Feb 2016 13:20:35 -0800
Message-ID: <7h8u2uc318.fsf@baylibre.com>
References: <1453977766-20907-1-git-send-email-james.morse@arm.com>
	<7hvb6chv5e.fsf@baylibre.com> <56AF1D07.3000604@arm.com>
	<7hmvrid3pv.fsf@baylibre.com> <56B4AF2A.2070503@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36487 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980AbcBHVUh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 16:20:37 -0500
Received: by mail-pa0-f54.google.com with SMTP id yy13so79414165pab.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 13:20:37 -0800 (PST)
In-Reply-To: <56B4AF2A.2070503@arm.com> (James Morse's message of "Fri, 05 Feb
	2016 14:18:18 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Marc Zyngier <marc.zyngier@arm.com>

James Morse <james.morse@arm.com> writes:

> Hi Kevin,
>
> On 03/02/16 00:42, Kevin Hilman wrote:
>> James Morse <james.morse@arm.com> writes:
>>> On 29/01/16 22:34, Kevin Hilman wrote:
>>>> James Morse <james.morse@arm.com> writes:
>>>> I'd like to help in testing this so I'm just curious which platforms
>>>> you've been testing this on.  I'm assuming a Juno (r2?), anything else?
>>>
>>> That would be great - thanks!
>>>
>>> I've done most of the testing on a Juno r1, but also gave it a spin on a
>>> stray Seattle.
>> 
>> OK, I'm using a very recently arrived Juno R2, and I did get it
>> working.  I have a few other arm64 boards around that ar part of
>> kernelci.org and will try those as well.
>
> Great,
> It would be good to have a Tested-by if it works to your satisfaction...

Yes, feel free to add

Tested-by: Kevin Hilman <khilman@baylibre.com> # Tested on Juno R2

I tried to also test on the qcom 96boards, but that platform doesn't
support suspend/resume yet. :(

Kevin

