From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 6/7] cpufreq:boost:Kconfig: Enable software managed
 BOOST support at Kconfig
Date: Wed, 17 Jul 2013 10:54:55 +0530
Message-ID: <CAKohpo=XbUtYBVQ_y4_R18wpag_HAVvXrxfSfmaNSqq=wLpciQ@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1372927830-2949-1-git-send-email-l.majewski@samsung.com>
	<1372927830-2949-7-git-send-email-l.majewski@samsung.com>
	<CAKohpokR=jrcLQQ7VAD+vr7GWgSFBfuqbOhWHwA3FCgk__EJ3Q@mail.gmail.com>
	<20130716135022.64a102f8@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130716135022.64a102f8@amdc308.digital.local>
Sender: cpufreq-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 16 July 2013 17:20, Lukasz Majewski <l.majewski@samsung.com> wrote:
> On Tue, 16 Jul 2013 15:28:40 +0530 Viresh Kumar viresh.kumar@linaro.org
> wrote,
>> On 4 July 2013 14:20, Lukasz Majewski <l.majewski@samsung.com> wrote:
>> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
>>
>> > +config CPU_FREQ_BOOST_SW
>> > +       bool "CPU frequency overclocking (BOOST)"
>>
>> Name it "CPU Frequency Overclocking - Software"
>
> Thanks, I had a puzzle to came up with a good short name :-).
>
>>
>> > +       depends on ARM_EXYNOS_CPUFREQ && EXYNOS_THERMAL
>                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ [*]
>>
>> Remote Exynos from here. If you want to enable it for your platform by
>> default, then select it from EXYNOS.

I misread it a bit. I wanted to say make it dependent only on THERMAL and
not on Exynos.

> The purpose of the condition [*] here is to prevent from enabling
> boost when thermal for Exynos is not supported.

Why? Can't others use it? Its not exynos specific :)
