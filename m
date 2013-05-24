From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC v2 0/3][TESTS] LAB: Support for Legacy Application Booster
 governor - tests results
Date: Fri, 24 May 2013 11:06:17 +0200
Message-ID: <519F2D89.5030602@linaro.org>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com> <CAKohpokXNUmMbk0KOh58-0=sAs7yzD=cQe24eaoArpRSwM__Gg@mail.gmail.com> <20130522122700.104ca5cd@amdc308.digital.local> <CAKohpo=9dRXb1jjauvhzuje9rOgH82k-3DeL2zqiwHDHOwSo4g@mail.gmail.com> <20130522164453.29cd3a7d@amdc308.digital.local> <20130524075640.0a5b80ff@amdc308.digital.local> <CAKohpoksymD76rDvg_+PwU7r3JXp1oydHBbJE4-y6TBHOomZHg@mail.gmail.com> <20130524103007.7bb206ee@amdc308.digital.local> <CAKohponbX7u_k9ZYQ7KyBeyKh93Qu+niGZj60t9c1n+AmaA6pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:47843 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059Ab3EXJGV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 May 2013 05:06:21 -0400
Received: by mail-wg0-f47.google.com with SMTP id e11so2509566wgh.26
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2013 02:06:20 -0700 (PDT)
In-Reply-To: <CAKohponbX7u_k9ZYQ7KyBeyKh93Qu+niGZj60t9c1n+AmaA6pg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, "Rafael J. Wysocky" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Vicent Guittot <vincent.guittot@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>

On 05/24/2013 10:51 AM, Viresh Kumar wrote:
> On 24 May 2013 14:00, Lukasz Majewski <l.majewski@samsung.com> wrote:
>> The overclock frequency (1.5 GHz) is possible to set as an ordinary,
>> available frequency (policy->max) for ondemand.
>>
>> Unfortunately with our load patterns, this frequency rapidly increas=
es
>> internal chip temperature (chip goes out of available power/thermal
>> dissipation range), and consumes extra power when not needed.
>>
>> The core idea with overclock is to increase ("boost") the frequency
>> when conditions allow to do it (for example load is affined to a sin=
gle
>> core, other are idle). Then we will not exceed power/thermal budget,=
 but
>> increase performance (and even save power).
>>
>>
>> Overclocking is efficiently utilized by LAB, which relies on a numbe=
r of
>> idle cpus. Thus, we can easily asses if we can enable it.
>>
>> I also foresee potential use of overclocking, when scheduler will ta=
ke a
>> major role of power saver for mobile (ARM) linux. Since it will try =
to
>> pack as much tasks as possible to a single core - it will need a
>> framework/API to "boost" their execution.
>=20
> Okay.. so its exactly what I thought the reason would be.
>=20
> What I would have done if I was in your place is:
>=20
> Add following sysfs tunables to ondemand governor:
>=20
> - overdrive_freq: We will go over this frequency only when
> number of busy cores is <=3D overdrive_cores..
> For your case it will be 1.4 GHz
>=20
> - overdrive_cores: We will enable overdrive frequencies only if no. o=
f
> busy cores is <=3D overdrive_cores. Zero by default (So, that this fe=
ature
> is disabled by default) and 1 for your case.
>=20
> And your driver will include all the available frequencies in the fre=
q
> table.
>=20
> I hope this will be the most generic solution to your problem..

I agree with Viresh, a new governor is not necessary here for that.

There is the /sys/devices/system/cpufreq/boost option existing for x86
platform, why do not reuse it ? It is supposed to do exactly what you
want to achieve.

IMO, the logic of boosting one core when the other are idle should be i=
n
the driver itself and certainly not setup by the user, except if we
consider acceptable the user can burn its board ... :)

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

