From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH-Resend] thermal: Exynos: Add missing dependency
Date: Thu, 15 Nov 2012 12:37:21 +0530
Message-ID: <CAK44p23C3bcTjc8AktXRR=K_Kf_HeVR7EXvMyWmsWGy_Xj9MKQ@mail.gmail.com>
References: <1352961579-13807-1-git-send-email-sachin.kamat@linaro.org>
	<CAK44p21smO8rrKoJF=47ywRCeagDudvFzZ7DhJ7TZCT7Mqv7kA@mail.gmail.com>
	<1352963065.2080.12.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1352963065.2080.12.camel@rzhang1-mobl4>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-pm@vger.kernel.org, patches@linaro.org, akpm@linux-foundation.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 15 November 2012 12:34, Zhang Rui <rui.zhang@intel.com> wrote:
> On Thu, 2012-11-15 at 12:31 +0530, Amit Kachhap wrote:
>> On 15 November 2012 12:09, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> > CPU_FREQ_TABLE depends on CPU_FREQ. Selecting CPU_FREQ_TABLE without checking
>> > for dependencies gives the following compilation warnings:
>> > warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC && UX500_SOC_DB8500 &&
>> > CPU_THERMAL && EXYNOS_THERMAL) selects CPU_FREQ_TABLE which has unmet
>> > direct dependencies (ARCH_HAS_CPUFREQ && CPU_FREQ)
>> >
>> > Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> > ---
>> >  drivers/thermal/Kconfig |    3 +--
>> >  1 files changed, 1 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> > index 266c15e..6124c4b 100644
>> > --- a/drivers/thermal/Kconfig
>> > +++ b/drivers/thermal/Kconfig
>> > @@ -50,8 +50,7 @@ config RCAR_THERMAL
>> >
>> >  config EXYNOS_THERMAL
>> >         tristate "Temperature sensor on Samsung EXYNOS"
>> > -       depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && THERMAL
>> > -       select CPU_FREQ_TABLE
>> Hi Sachin/Rui,
>>
>> "select CPU_FREQ_TABLE" should be there even if CONFIG_CPU_FREQ is
>> enabled. Only some governors enable it.
>
> But CPU_THERMAL will select it, right?
Ohh yes correct. Thanks
>
>>  See drivers/cpufreq/Kconfig
>> Also "depends THERMAL" should be there otherwise menuconfig
>> parent/child relationship is broken.
>>
> this should be solved by my patch 1/2. :)
>
> thanks,
> rui
>
>> Thanks,
>> Amit Daniel
>>
>> > +       depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5) && CPU_THERMAL
>> >         help
>> >           If you say yes here you get support for TMU (Thermal Managment
>> >           Unit) on SAMSUNG EXYNOS series of SoC.
>> > --
>> > 1.7.4.1
>> >
>
>
