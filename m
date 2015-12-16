From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/4] ARM: bcm2835: add rpi power domain driver
Date: Wed, 16 Dec 2015 11:06:11 +0100
Message-ID: <CAPDyKFqPk5XPPYMYe6HZc=b8-b-Y2VB6mQfZP8_TS8KOFZjsUw@mail.gmail.com>
References: <1450215622-27394-1-git-send-email-eric@anholt.net>
	<1450215622-27394-3-git-send-email-eric@anholt.net>
	<567093CD.1020208@gmail.com>
	<87oadrmfmi.fsf@eliezer.anholt.net>
	<5670AAB2.1080102@gmail.com>
	<87mvtbkyd0.fsf@eliezer.anholt.net>
	<20151216011110.GA13147@earth>
	<CAJKOXPes85hu6Jnd5p6dqhgdBGF4kmZuJQekM73O83DuZvcyoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35675 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934053AbbLPKGN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 05:06:13 -0500
Received: by mail-qk0-f176.google.com with SMTP id u65so36602098qkh.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2015 02:06:12 -0800 (PST)
In-Reply-To: <CAJKOXPes85hu6Jnd5p6dqhgdBGF4kmZuJQekM73O83DuZvcyoQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@ring0.de>, Eric Anholt <eric@anholt.net>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lee Jones <lee@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 16 December 2015 at 02:27, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> 2015-12-16 10:11 GMT+09:00 Sebastian Reichel <sre@ring0.de>:
>> Hi,
>>
>> On Tue, Dec 15, 2015 at 04:53:31PM -0800, Eric Anholt wrote:
>>> >>> What motivated the location of this power domain driver in
>>> >>> arch/arm/mach-bcm? Should not we have this in drivers/power/ or
>>> >>> somewhere in drivers/ at the very least?
>>> >>
>>> >> ls stronly suggests that power contains drivers for power supplies and
>>> >> batteries, not power domains.
>>
>> Indeed it's used for fuel gauges and chargers, but also for
>> reboot/powerdown and adaptive voltage scaling, so another
>> subdirectory for power-domains wouldn't be that odd.
>>
>>> >> There are 6 power domain drivers in
>>> >> arch/arm, 3 in drivers/clk, and 3 in drivers/soc.
>>> >
>>> > If we ever have to support a different architecture which happens to use
>>> > a similar power domain, then we want it to be in a location which makes
>>> > it easy for sharing it in the first place. As it stands today, it does
>>> > not seem useful to me to have this code in arch/arm/mach-bcm/ at all.
>>> >
>>> > Maybe there is room from a drivers/power/domains/ of some kind?
>>
>> I like the idea, but let's include generic power domain maintainers
>> in this discussion, as I suggested here (I got a power domain driver
>> patch for drivers/power just a few days ago):
>>
>> https://lkml.org/lkml/2015/12/15/815
>>
>> Also somebody would have to step up to maintain that directory.
>
> This could go into drivers/soc. We put there a lot of mach-specific
> stuff which we want to make a little more generic (like generic enough
> multiplatform, multiarchitecture etc). Rockchip has its own power
> domains there. Dove and Mediatek seem as well but I am not sure. Some
> other architectures keep this still in arm/mach (exynos, ux500, zx,
> imx, s34c64xx, shmobile) but this looks more of like a legacy choice.

Agree, drivers/soc is good.

>
> However, since the generic power domains have its own maintainers entry
> and reside under drivers/base/power, maybe making a separate directory
> for power domains drivers makes sense?

That could work as well, but I have no strong opinion.
Perhaps it would become a bit more clear, although in that case I
would also move drivers/base/power/domain* in there.

If that happens, I am willing to help maintain it.

Kind regards
Uffe
