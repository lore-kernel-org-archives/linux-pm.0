From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] ARM: EXYNOS: remove non-working AFTR mode support
Date: Mon, 01 Jul 2013 11:23:43 +0200
Message-ID: <51D14A9F.6000407@linaro.org>
References: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com> <1721255.XMYjiW81jp@amdc1227> <51CE0DB8.5040407@linaro.org> <23262498.GmEHQP5Xlz@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <23262498.GmEHQP5Xlz@flatron>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Tomasz Figa <t.figa@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, jc.lee@samsung.com, lorenzo.pieralisi@arm.com, Amit Kachhap <amit.daniel@samsung.com>, rjw@sisk.pl, kyungmin.park@samsung.com
List-Id: linux-pm@vger.kernel.org

On 06/29/2013 01:07 AM, Tomasz Figa wrote:
> On Saturday 29 of June 2013 00:27:04 Daniel Lezcano wrote:
>> On 06/28/2013 07:31 PM, Tomasz Figa wrote:
>>> On Friday 28 of June 2013 13:20:09 Daniel Lezcano wrote:
>> [ ... ]
>>
>>>> The kernel is not a playground where you can upstream code and the=
n
>>>> remove it because a feature seems broken and you don't have an ide=
a
>>>> of
>>>> why.
>>>
>>> Well, first of all, it has not been upstreamed correctly: a) withou=
t
>>> any given rationale (or at least without any I could find) and b)
>>> without enough testing.
>>
>> +1
>>
>>>> I asked several times the reasons of why the AFTR state couldn't w=
ork
>>>> with multiple CPUs and I had no answer.
>>>>
>>>> Frankly speaking I have a couple of hypothesis:
>>>>
>>>> 1. something is not correctly setup and the PMU does not wake up t=
he
>>>> CPU1 2. there is a silicon bug and no one wants to tell it is the
>>>> case
>>>>
>>>> In any case, this must be investigated and identified. And then we
>>>> can
>>>> take a decision about this state.
>>>
>>> Well, everything you're saying is correct, assuming that this featu=
re
>>> is useful, which needs confirmation. I'd still want any evidence of
>>> this feature being of any use first, to not waste time on something
>>> that is useless.
>>
>> IMHO, it is useful. That's sure a highly integrated hardware with a =
lot
>> of peripherals, the power saving is lost in the noise but with a sma=
ll
>> embedded device, the power saving is significant.
>=20
> Be aware that we might be talking here about savings of single=20
> milliamperes, because the highest, dynamic, power consumption is alre=
ady=20
> bypassed in WFI idle mode, with stopped core clock.
>=20
> Our measurements have shown that static leakage is pretty low on SoCs=
 we=20
> checked, that is Exynos 4210 and Exynos 4412. I don't remember exactl=
y=20
> ATM, because it was some time ago, but it was something around 2 mA p=
er=20
> core.

Ok I don't know exactly the values but I am a bit surprised by this
small value. When I measured the power consumption with a core offline
it saved roughly 100mA (AFAIR). Of course, there is no dynamic with the
hotplugging but there is really a big difference here.

With another board with similar hardware (but a different SoC), just
putting the cores in retention mode in the cpuidle drivers saved 13mA.

Is it possible for the exynos board, the target residency is too large
for AFTR mode ? Is this value really resulting from a measurement or
just put there arbitrarily ? And, may be, it does not enter enough in
this state to have a significant power saving.

> Now it depends on overall power consumption of given system, whether =
such=20
> saving is significant or ignorable - in our case it is the latter, be=
cause=20
> consumption caused by rest of the system (think of display, wireless=20
> radios, etc.) is much higher.
>=20
>> What I am worried about is the different SoCs being introduced in th=
is
>> driver without investigating this cpu1 restriction and it sounds lik=
e
>> the AFTR seems to work (I have an odroid-u2 with a 4412 I will test =
to
>> check if the AFTR works on it) and nobody seems to be hurt by this a=
nd,
>> as you stated, there is no rational about it. That means the Exynos =
will
>> become really more and more power aggressive with 4/A15 or 8/A15 bas=
ed
>> boards if the AFTR state is not correctly supported.
>=20
> See my other reply, for a bit more information about this state and C=
PU1=20
> restriction.
>=20
>> AFAICT, there is also the LPA state and the DEEPSLEEP, right ? If th=
e
>> AFTR does not work, I don't see these states working too.
>=20
> Yes, there are other states as well. With similar execution flow, but=
=20
> different set of preserved and lost context, requiring more or less s=
ave=20
> and restore on kernel side.
>=20
>> The cpuidle driver is critical for the new b.L architecture. If we
>> aren't able to put a cluster of big cpus in a power down state, we l=
ose
>> the benefit of all the work made up-front at the scheduler level (eg=
=2E
>> small task packing, workqueue/timer migration) and more generally we
>> lose the benefit of the b.L architecture (except if we do some hacks
>> which are orthogonal to the generic approach).
>=20
> In this case just simple power down of CPU cores is enough, which doe=
sn't=20
> require entering system-wide low power state, such as AFTR and friend=
s.=20
> Such low power mode is needed only when you want to power off all the=
=20
> cores, which makes you lose program execution state.
>=20
> When at least one of the cores is still active, the whole system is i=
n=20
> control of kernel and no special care must be taken to bring up cores=
 that=20
> are down and back, just standard SMP/hotplug ops.

Yes but unfortunately this approach has been nacked by the community
last year with the OMAP4.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

  * English - detected
  * English
  * French

  * English
  * French

 <javascript:void(0);>
