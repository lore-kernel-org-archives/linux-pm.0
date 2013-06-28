From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
Date: Sat, 29 Jun 2013 00:27:04 +0200
Message-ID: <51CE0DB8.5040407@linaro.org>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com> <19893620.AhWB5HomTT@amdc1227> <51CD7169.6010905@linaro.org> <1721255.XMYjiW81jp@amdc1227>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38793 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab3F1W0u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2013 18:26:50 -0400
Received: by mail-wi0-f174.google.com with SMTP id k10so1292540wiv.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Jun 2013 15:26:49 -0700 (PDT)
In-Reply-To: <1721255.XMYjiW81jp@amdc1227>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, Amit Kachhap <amit.daniel@samsung.com>, rjw@sisk.pl, kyungmin.park@samsung.com

On 06/28/2013 07:31 PM, Tomasz Figa wrote:
> On Friday 28 of June 2013 13:20:09 Daniel Lezcano wrote:

[ ... ]

>> The kernel is not a playground where you can upstream code and then
>> remove it because a feature seems broken and you don't have an idea =
of
>> why.
>=20
> Well, first of all, it has not been upstreamed correctly: a) without =
any=20
> given rationale (or at least without any I could find) and b) without=
 enough=20
> testing.

+1

>> I asked several times the reasons of why the AFTR state couldn't wor=
k
>> with multiple CPUs and I had no answer.
>>
>> Frankly speaking I have a couple of hypothesis:
>>
>> 1. something is not correctly setup and the PMU does not wake up the=
 CPU1
>> 2. there is a silicon bug and no one wants to tell it is the case
>>
>> In any case, this must be investigated and identified. And then we c=
an
>> take a decision about this state.
>=20
> Well, everything you're saying is correct, assuming that this feature=
 is=20
> useful, which needs confirmation. I'd still want any evidence of this=
=20
> feature being of any use first, to not waste time on something that i=
s=20
> useless.

IMHO, it is useful. That's sure a highly integrated hardware with a lot
of peripherals, the power saving is lost in the noise but with a small
embedded device, the power saving is significant.

What I am worried about is the different SoCs being introduced in this
driver without investigating this cpu1 restriction and it sounds like
the AFTR seems to work (I have an odroid-u2 with a 4412 I will test to
check if the AFTR works on it) and nobody seems to be hurt by this and,
as you stated, there is no rational about it. That means the Exynos wil=
l
become really more and more power aggressive with 4/A15 or 8/A15 based
boards if the AFTR state is not correctly supported.

AFAICT, there is also the LPA state and the DEEPSLEEP, right ? If the
AFTR does not work, I don't see these states working too.

The cpuidle driver is critical for the new b.L architecture. If we
aren't able to put a cluster of big cpus in a power down state, we lose
the benefit of all the work made up-front at the scheduler level (eg.
small task packing, workqueue/timer migration) and more generally we
lose the benefit of the b.L architecture (except if we do some hacks
which are orthogonal to the generic approach).

I should have added this point to 4) to the mail I sent previously to
Bartlomiej...

  -- Daniel


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

