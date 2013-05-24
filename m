From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC v2 0/3][TESTS] LAB: Support for Legacy Application Booster
 governor - tests results
Date: Fri, 24 May 2013 12:28:40 +0200
Message-ID: <519F40D8.7040500@linaro.org>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com> <CAKohpokXNUmMbk0KOh58-0=sAs7yzD=cQe24eaoArpRSwM__Gg@mail.gmail.com> <20130522122700.104ca5cd@amdc308.digital.local> <CAKohpo=9dRXb1jjauvhzuje9rOgH82k-3DeL2zqiwHDHOwSo4g@mail.gmail.com> <20130522164453.29cd3a7d@amdc308.digital.local> <20130524075640.0a5b80ff@amdc308.digital.local> <CAKohpoksymD76rDvg_+PwU7r3JXp1oydHBbJE4-y6TBHOomZHg@mail.gmail.com> <20130524103007.7bb206ee@amdc308.digital.local> <CAKohponbX7u_k9ZYQ7KyBeyKh93Qu+niGZj60t9c1n+AmaA6pg@mail.gmail.com> <519F2D89.5030602@linaro.org> <CAKohpom+wsGj=1nurNtoiRaZCD7KRbx0BO+tNXpoqO+FmmzehA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpom+wsGj=1nurNtoiRaZCD7KRbx0BO+tNXpoqO+FmmzehA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, "Rafael J. Wysocky" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Vicent Guittot <vincent.guittot@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>
List-Id: linux-pm@vger.kernel.org

On 05/24/2013 11:13 AM, Viresh Kumar wrote:
> On 24 May 2013 14:36, Daniel Lezcano <daniel.lezcano@linaro.org> wrot=
e:
>> I agree with Viresh, a new governor is not necessary here for that.
>=20
> Their patchset had two parts.. One is LAB and other is overclocking.
> We are trying to solve overclocking for which they never wanted a
> new governor. :)
>=20
>> There is the /sys/devices/system/cpufreq/boost option existing for x=
86
>> platform, why do not reuse it ? It is supposed to do exactly what yo=
u
>> want to achieve.
>=20
> The problem is that it was added at the wrong place.. It should have
> been at cpu/cpuX/cpufreq/boost...

Yes, I saw in the commit log (615b7300717b9ad5c23d1f391843484fe30f6c12)=
,
that should be done.

> Consider how will we achieve it for big LITTLE.. We know we can
> go to overdrive only for a single core in big but for two cores in
> LITTLE at the same time.. So, we need that in the location I just
> mentioned...

I thought the constraints should be hardcoded in the driver and only on=
e
option is exposed to the userspace. If the user sets
ondemand|performance + boost, then the exynos's or b.L's drivers know
when they can go to boost (1x core, 1x big core, 2x little core, ...).

> Over that.. I believe it is governor specific too.. It shouldn't be p=
art
> of conservative as it should be conservative rather then aggressive :=
)

Yes, it is part of the governor policy and maybe that could fall in the
common cpufreq framework.

>> IMO, the logic of boosting one core when the other are idle should b=
e in
>> the driver itself and certainly not setup by the user, except if we
>> consider acceptable the user can burn its board ... :)
>=20
> I didn't get it completely.. So, with the options I gave user can onl=
y
> say.. boost if required and only when few cores are active. User
> can't just set max freq continuously if he wishes..

Ok, may be I misunderstood. You suggested to define 'overdrive_cores'
where the user can setup when to overdrive a core. If the user set an
incorrect value, IIUC, the thermal value can go beyond the thermal limi=
t
and break the board. I am just worried this option is dangerous.




--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
