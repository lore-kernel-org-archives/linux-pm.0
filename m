From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] ARM: EXYNOS: add cpuidle-exynos.max_states kernel
 parameter
Date: Mon, 02 Sep 2013 17:52:15 +0200
Message-ID: <5224B42F.3090500@linaro.org>
References: <4002844.4ZqqJexTv4@amdc1032> <2459763.PzPngK0oec@amdc1032> <52249F97.4080807@linaro.org> <3870129.vNtjevCIAF@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:58508 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338Ab3IBPwU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2013 11:52:20 -0400
Received: by mail-bk0-f43.google.com with SMTP id mz13so1660462bkb.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2013 08:52:19 -0700 (PDT)
In-Reply-To: <3870129.vNtjevCIAF@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tomasz Figa <t.figa@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 09/02/2013 04:43 PM, Bartlomiej Zolnierkiewicz wrote:
> On Monday, September 02, 2013 04:24:23 PM Daniel Lezcano wrote:
>> On 09/02/2013 03:48 PM, Bartlomiej Zolnierkiewicz wrote:
>>> On Monday, September 02, 2013 03:18:51 PM Daniel Lezcano wrote:
>>>> On 09/02/2013 11:41 AM, Bartlomiej Zolnierkiewicz wrote:
>>>>> On Monday, September 02, 2013 10:54:17 AM Daniel Lezcano wrote:
>>>>>> On 08/30/2013 12:21 PM, Bartlomiej Zolnierkiewicz wrote:
>>>>>>> Add "cpuidle-exynos.max_states=3D" parameter to allow user to s=
pecify
>>>>>>> the maximum of allowed CPU idle states for ARM EXYNOS cpuidle d=
river.
>>>>>>>
>>>>>>> This change is needed because C1 state (AFTR mode) is often not=
 able
>>>>>>> to work properly due to incompatibility with some bootloader ve=
rsions.
>>>>>>>
>>>>>>> Usage examples:
>>>>>>>
>>>>>>> "cpuidle-exynos.max_states=3D1" disables C1 state (AFTR mode).
>>>>>>>
>>>>>>> "cpuidle-exynos.max_states=3D0" disables the driver completely.
>>>>>>>
>>>>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.=
com>
>>>>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>>>>> Cc: Tomasz Figa <t.figa@samsung.com>
>>>>>>> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>>>>>
>>>>>> There is a max_cstate option for acpi and intel idle. There is a=
lso the
>>>>>> cpuidle.off=3D1 option. As the semantic is the same, I think add=
ing a
>>>>>> common cpuidle option usable for all the drivers is better.
>>>>>
>>>>> I thought about making the option common for all cpuidle drivers =
first
>>>>> but due to support for multiple cpuidle drivers on one machine (i=
=2Ee.
>>>>> big.LITTLE), per-driver option looked like a better approach.
>>>>>
>>>>> Should I make the option common and not worry about multiple driv=
ers on
>>>>> one machine support?
>>>>
>>>> Mmh, that's a good point.
>>>>
>>>> I am not in favor of multiple options spread across the different
>>>> drivers. Furthermore the max_cstate is used in the intel platform =
to
>>>> 'discover' what states the firmware supports which is not the case=
 of
>>>> the cpuidle ARM drivers (except new PSCI based). This option does =
not
>>>> really fits well here.
>>>>
>>>> There is the kernel parameter 'cpuidle.off', so disabling the driv=
er is ok.
>>>>
>>>> You converted the cpuidle driver to a platform driver. Isn't possi=
ble to
>>>> pass information in the platform data field at boot time to tell A=
=46TR is
>>>> not supported and then act on the 'disabled' field of this state ?
>>>
>>> It might be possible but I don't know where the source of this data=
 would
>>> be, platform specific kernel parameter? It sounds just like moving =
the code
>>> around and adding superfluous platform->driver code because the sim=
ilar
>>> kernel parameter to disable just AFTR can be added in cpuidle-exyno=
s driver
>>> as well.
>>
>> It is to prevent to add a new kernel parameter (with the documentati=
on)
>> for a single driver which has a bogus idle state. If that could be
>> handled internally that would be cleaner.
>=20
> If I believed that it could be handled internally I wouldn't be tryin=
g to
> add a kernel parameter to handle it.. Would I? ;)
>=20
>> Can you shortly describe what happens with the bootloader and AFTR ?
>=20
> AFTR just doesn't work with the custom U-Boot version that we are usi=
ng
> (attempts to go into AFTR mode result in lockup) and using the upstre=
am
> version of U-Boot is not an option since it doesn't support the hardw=
are
> that we are using AFAIK. I also don't know exactly why it doesn't wor=
k
> (I just suspect that it reuses INFORM registers for some other purpos=
es).

You want to add a kernel option as a work around for a bug in U-Boot ?

IMO, you should drop the hot potato to the u-boot guys :)

>> I guess you are not interested in cpuidle.off=3D1 because you want c=
puidle
>> statistics for WFI, right ?
>=20
> Right. :)



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

