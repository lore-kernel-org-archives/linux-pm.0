From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
Date: Mon, 01 Jul 2013 11:09:03 +0200
Message-ID: <51D1472F.2010103@linaro.org>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com> <2484012.IH9WOi4iIR@amdc1032> <51CE0485.8020109@linaro.org> <2055030.cNBSJEZ4PB@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:48987 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3GAJIs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2013 05:08:48 -0400
Received: by mail-bk0-f49.google.com with SMTP id mz10so1566510bkb.36
        for <linux-pm@vger.kernel.org>; Mon, 01 Jul 2013 02:08:47 -0700 (PDT)
In-Reply-To: <2055030.cNBSJEZ4PB@flatron>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, Amit Kachhap <amit.daniel@samsung.com>, rjw@sisk.pl, kyungmin.park@samsung.com

On 06/29/2013 12:47 AM, Tomasz Figa wrote:
> On Friday 28 of June 2013 23:47:49 Daniel Lezcano wrote:
>> On 06/28/2013 06:27 PM, Bartlomiej Zolnierkiewicz wrote:
>>> On Friday, June 28, 2013 01:20:09 PM Daniel Lezcano wrote:
>>>> On 06/28/2013 12:11 PM, Tomasz Figa wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> I've been fighting with this whole AFTR state as well, before
>>>>> Bartlomiej. Let me share my thoughts on this.
>>
>> [ ... ]
>>
>>>>> If you don't unplug all the CPUs >0 the state is obviously never
>>>>> reached. Otherwise the whole system hangs after it tries to enter
>>>>> this mode without any reaction for external events, other than
>>>>> reset.
>>>>
>>>> Need investigation.
>>>>
>>>> What is the exynos board version where that occurs ?
>>>
>>> Could you please tell me what exactly do you mean by that?
>>>
>>> I already wrote that we can reproduce the problem on EXYNOS4210 rev=
0
>>> and rev1.1 (we don't have rev1.0). Tomek has also reproduced the
>>> problem on some later SoCs (I hope that he can give you exact
>>> revisions).
>>>
>>> In our testing we didn't encounter the board on which the problem
>>> doesn't occur. Our current working theory is that the problem may b=
e
>>> u-boot (or first stage bootloader) related.
>>
>> Ok, the status for what I know:
>>
>> Origen Exynos4210, board ver A: works for me
>> Arndale Exynos5250: works for me but only if u-boot does not enable =
the
>> hypervisor mode.
>> Chromebook Exynos5250: works for me
>>
>> I found the following drivers:
>>
>> https://github.com/AndreiLux/Perseus-UNIVERSAL5410/blob/samsung/arch=
/arm
>> /mach-exynos/cpuidle.c
>>
>> https://github.com/CyanogenMod/hardkernel-kernel-4412/blob/cm-10.1/a=
rch/
>> arm/mach-exynos/cpuidle-exynos4.c
>>
>> Sounds like the num cpus > 1 is still there.
>=20
> As far as I know (and I can read from the documentation), AFTR is a s=
tate=20
> in which program execution context (e.g. PC, CPU registers, etc.) is =
lost.=20
> This is like sleep mode, but with much more state saved (all the=20
> peripherals and L2 cache), which lets you resume much faster.
>=20
> Based on that, the execution flow is as following:
>  - kernel stops all secondary cores,
>  - kernel configures PMU to enter AFTR mode,
>  - WFI is executed on boot CPU, which lets PMU enter the requested lo=
w=20
> power mode,
>  - the system stays with all CPU cores powered off until a wake-up ev=
ent=20
> happens,
>  - a wake-up event causes a wake-up reset of the boot CPU, which resu=
mes=20
> operation from reset vector (usually IROM),
>  - here exactly the same procedure is used as on wake-up from sleep m=
ode,=20
> with the exception that some assumptions can be made about kept state=
,=20
> like BL1 being still in IRAM/SYSRAM, without the need to reload it fr=
om=20
> boot device,
>  - after going through all the boot code, it finally jumps to the res=
ume=20
> handler saved by kernel in one of those INFORM registers or somewhere=
 in=20
> SYSRAM,
>  - resume handler reinitializes boot CPU, restores things like MMU,=20
> coprocessors, etc. and finally boots secondary cores again,
>  - the system is operating normally again.
>=20
> This is simplified a lot, with all things happened internally in PMU =
and=20
> boot code skipped, but should give the general picture. See all the=20
> analogies to normal sleep mode, which (IMHO) makes it understandable =
that=20
> this mode can't be entered with more than one core active.=20
>=20
> However, with something like coupled cpuidle, when possible, this mod=
e can=20
> be entered by powering down remaining cores automatically, so this is=
 not=20
> a problem with this mode itself, but rather with current approach of=20
> entering it.

Are you saying only CPU0 can program the PMU to enter the AFTR mode ?
And only CPU0 can be woken up ?

Is it possible to have CPU0 to enter the AFTR idle state (without
switching to this mode), save its context and go to WFI. And then when
CPU1 goes to this state also, it saves its context and set the PMU to
enter the AFTR mode ?



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

