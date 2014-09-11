From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v8 6/8] drivers: cpuidle: CPU idle ARM64 driver
Date: Thu, 11 Sep 2014 10:28:06 +0200
Message-ID: <54115D16.30206@linaro.org>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com> <1409585324-3678-7-git-send-email-lorenzo.pieralisi@arm.com> <20140903173740.GJ1824@e102568-lin.cambridge.arm.com> <20140904160320.GB22354@arm.com> <20140904172909.GA14822@e102568-lin.cambridge.arm.com> <20140905092120.GG13515@arm.com> <20140905153457.GA26306@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:64944 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbaIKI2M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Sep 2014 04:28:12 -0400
Received: by mail-wi0-f174.google.com with SMTP id n3so469897wiv.13
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2014 01:28:11 -0700 (PDT)
In-Reply-To: <20140905153457.GA26306@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Ami

On 09/05/2014 05:34 PM, Lorenzo Pieralisi wrote:
> On Fri, Sep 05, 2014 at 10:21:20AM +0100, Will Deacon wrote:
>> On Thu, Sep 04, 2014 at 06:29:10PM +0100, Lorenzo Pieralisi wrote:
>>> On Thu, Sep 04, 2014 at 05:03:20PM +0100, Catalin Marinas wrote:
>>>> On Wed, Sep 03, 2014 at 06:37:40PM +0100, Lorenzo Pieralisi wrote:
>>>>> This patch should be ready to go too, is it ok if I split the ser=
ies
>>>>> in arm64 arch specific patches (will ask Catalin to pull) and CPU=
idle ones
>>>>> (inclusive of DT bindings and !!this patch!!) and send two separa=
te pull
>>>>> requests ?
>>>>
>>>> If Daniel/Rafael don't have any objection, I can take the whole se=
ries
>>>> through the arm64 tree (it seems that patches have been already ac=
ked by
>>>> Daniel).
>>>
>>> Thanks a lot Catalin. Since this one is a brand new CPUidle driver =
and it
>>> follows a different pattern from arm legacy drivers I would like to=
 get
>>> Daniel's ack on this patch too before pushing it. For the records I=
 have
>>> just added two pr_err to signal driver probing error, ultraminor ch=
anges
>>> that do not justify a repost.
>>>
>>> If Samsung guys do not manifest themselves I would drop patch 8 fro=
m
>>> the series till it gets tested and its patch dependency queued too.
>>
>> The last patch also has a dependency, as you mentioned to Daniel. I =
think
>> we can certainly merge the arm64 parts, and if Daniel doesn't object=
, then
>> we can take the driver stuff too but leaving the exynos bits out (i.=
e. drop
>> the last patch).
>>
>> Anyway, if you could repost with the acks you've collected and rearr=
ange it
>> so the arm64 patches are first in the series, that would be great.
>
> I can repost it with the acks and rearrange the patches, but for the
> pull request I have to know what code can be merged, since there are
> some arm64 patches (PSCI and CPUidle arm64 back-end) that are strictl=
y
> tied to the arm64 CPUidle driver, so I *have* to know if the arm64
> CPUidle driver (this patch) can get merged and that requires an ack.
>
> If I do not hear from Samsung guys I will drop patch 8.

Well I would prefer to have this patch merged (Cc'ing Tomasz).

> I will wait till Monday (ie -rc4) and repost, I hope that's acceptabl=
e.

There is a procedure to solve this branch dependency.

1. Create a patchset with only the changes in drivers/cpuidle (+ misc d=
t=20
stuff)

2. Send the patchset to me.

3. I create a branch with these patches (which will be merged in my=20
cpuidle next branch)

4. Merge this branch to a new branch (based on 3.17-rcX) and put on top=
=20
of that your changes for ARM[64]

5. Send the PR to Catalin and Arnd (one for each branch or one for both=
=20
arch)

I will ensure the base branch is not removed until the next merge windo=
w.

Does it sound good ?

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

