From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v5 0/5] ARM: EXYNOS: cpuidle: fix AFTR mode on boards
 with secure firmware enabled
Date: Tue, 05 Aug 2014 17:07:36 +0200
Message-ID: <53E0F338.8080006@linaro.org>
References: <1407245666-20016-1-git-send-email-b.zolnierkie@samsung.com> <53E0E420.8060207@linaro.org> <53E0E98F.5020706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:63658 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbaHEPHm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Aug 2014 11:07:42 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so1534382wiv.15
        for <linux-pm@vger.kernel.org>; Tue, 05 Aug 2014 08:07:40 -0700 (PDT)
In-Reply-To: <53E0E98F.5020706@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org

On 08/05/2014 04:26 PM, Krzysztof Kozlowski wrote:
> On 05.08.2014 16:03, Daniel Lezcano wrote:
>> On 08/05/2014 03:34 PM, Bartlomiej Zolnierkiewicz wrote:
>>> Hi,
>>>
>>> This patch series adds support for AFTR idle mode on boards with
>>> secure firmware enabled and allows EXYNOS cpuidle driver usage on
>>> Exynos4x12 SoCs.
>>>
>>> It has been tested on Trats2 board (using Exynos4412 SoC with secur=
e
>>> firmware enabled) on which AFTR mode reduces power consumption by ~=
12%
>>> when EXYNOS cpuidle driver is enabled (in both cases the default
>>> exynos_defconfig config is used and CPU1-3 are offlined).
>>
>> As a sidenote:
>>
>> On my odroid-U2:
>>   * 4 cpus online -> 130 mA
>>   * 3 cpus online -> 164 mA
>>   * 2 cpus online -> 160 mA
>>   * 1 cpu online  -> 157 mA
>>
>> So were are consuming more when there are unplugged cpu ... any idea=
s ?
>
> On which tree are you testing? Current next has ARMCLK down feature
> enabled. ARMCLK down may stop working after hotunplugging CPU:
> http://www.spinics.net/lists/arm-kernel/msg352890.html
>
> That was observed especially on Exynos4212 where ARMCLK down stops
> working permanently. On Trats2 (Exynos4412) the clock down stopped on=
ly
> a for short period after disabling CPU.

Hi Krzysztof,

I tested the patches you mentioned above on top of this patchset.

You are right this is directly related to the ARMCLK but the behavior=20
may be not as you expect I think.

When I boot:

4 cpus online =3D> 131 mA

Then I unplug one by one the cpus:

3 cpus online =3D> 127 mA
2 cpus online =3D> 123 mA
1 cpu online  =3D> 120 mA

This is consistent.

But now, I online the cpus:

2 cpus online =3D> 162 mA
3 cpus online =3D> 165 mA
4 cpus online =3D> 131 mA


-- side note --

Please note, I did not disable the cpuidle neither the AFTR state and=20
the kernel did not hang but I don't see the noticeable power saving we=20
should be observing when there is one cpu remaining entering the AFTR=20
state (cpuidle stats show we enter AFTR). So there is definitively=20
something wrong with this state.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

