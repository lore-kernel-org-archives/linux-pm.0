From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] cpufreq: highbank: fix ARM_HIGHBANK_CPUFREQ dependency
 warning
Date: Thu, 10 Apr 2014 11:06:17 +0800
Message-ID: <53460AA9.7030801@huawei.com>
References: <1397010873-11020-1-git-send-email-wangkefeng.wang@huawei.com> <CAKohponpGAm4J2shQRV8doMZGT22eJ2MnU0+GzF-GkZirGPW5g@mail.gmail.com> <1453884.JQRzhD9Q31@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1453884.JQRzhD9Q31@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mark Langsdorf <mark.langsdorf@calxeda.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, guohanjun@huawei.com
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 04/10 10:18, Rafael J. Wysocki wrote:
> On Wednesday, April 09, 2014 09:58:26 AM Viresh Kumar wrote:
>> On 9 April 2014 08:04, Kefeng Wang <wangkefeng.wang@huawei.com> wrot=
e:
>>> When make ARCH=3Darm multi_v7_defconfig, we get the following warni=
ngs:
>>>
>>> warning: (ARM_HIGHBANK_CPUFREQ) selects GENERIC_CPUFREQ_CPU0 which =
has
>>> unmet direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ && HAVE_CLK
>>> && REGULATOR && OF && THERMAL && CPU_THERMAL)
>>>
>>> To fix this, make ARM_HIGHBANK_CPUFREQ depend on ARCH_HAS_CPUFREQ a=
nd
>>> REGULATOR instead of selecting them, PM_OPP will be selected by ARC=
H_HAS_CPUFREQ.
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>=20
> Well, it doesn't work as intended, I'm afraid:
>=20
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
=2Egit bleeding-edge
> head:   588bc73d890c5dea35b7982a368c0e95089d5389
> commit: 51be80edc69390521622df71855d86da4e358488 [67/68] cpufreq: hig=
hbank: fix ARM_HIGHBANK_CPUFREQ dependency warning
> config: make ARCH=3Di386 allyesconfig
>=20
> All warnings:
>=20
> warning: (GENERIC_CPUFREQ_CPU0 && ARM_BIG_LITTLE_CPUFREQ && ARM_EXYNO=
S5440_CPUFREQ) selects PM_OPP which has unmet direct dependencies (ARCH=
_HAS_OPP)

I don't think this is my issue, without this patch=EF=BC=8Cthe warning =
is still there.

warning: (GENERIC_CPUFREQ_CPU0 && ARM_BIG_LITTLE_CPUFREQ && ARM_EXYNOS5=
440_CPUFREQ && ARM_HIGHBANK_CPUFREQ) selects PM_OPP which has unmet dir=
ect dependencies (ARCH_HAS_OPP)

this warning is caused by commit 109df086e(cpufreq: Select PM_OPP rathe=
r than depending on it),
so could you merge this patch? I will send a revert patch to solve this=
 issue, what is your opinion?

Regards,
Kefeng

>=20
>>> ---
>>>  drivers/cpufreq/Kconfig.arm | 6 +-----
>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> --
>> To unsubscribe from this list: send the line "unsubscribe cpufreq" i=
n
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


