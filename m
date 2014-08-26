From: Chander Kashyap <k.chander@samsung.com>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
Date: Tue, 26 Aug 2014 10:55:05 +0530
Message-ID: <CADWw7OgW+o3tB=ptnsy-PsmXmNv8oXzt_WfK6NswQiEWWwAzNA@mail.gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
	<1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
	<53DA8BB9.6020702@samsung.com>
	<53DA8D85.3050106@gmail.com>
	<7hbnrc6px3.fsf@paris.lan>
	<53F7DA13.6090305@gmail.com>
	<CADWw7OgAS-z-UOrJU-hL2fzuefJmLtCTg57jYk2Df7f5KfLJmA@mail.gmail.com>
	<7h8umc60we.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <7h8umc60we.fsf@paris.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Chander Kashyap <k.chander@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Amit Kucheria <amit.kucheria@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linaro-kernel@lists.linaro.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Kevin,

On Mon, Aug 25, 2014 at 9:02 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Hi Chander,
>
> Chander Kashyap <k.chander@samsung.com> writes:
>
> [...]
>
>>>> I'm trying it on the 5800/Chromebook2 and it's not terribly stable.  I'm
>>>> testing along with CPUidle, so there may be some untested interactions
>>>> there as it seems a bit more stable without CPUidle enabled.
>>>>
>>>> I'd love to hear from anyone else that's testing CPUidle and CPUfreq
>>>> together big.LITTLE 5420/5800, with or without the switcher.
>>
>> I have tested this patch series on SMDK5420 with cpuidle (with and
>> without b.L switcher enabled).
>>
>> As of now voltage scaling support is not there in generic big-little
>> cpufreq driver (arm_big_little.c).
>> Hence need to tie arm and kfc voltages to highest level for testing.
>
>> Without this change stability issues are there, but with this change
>> everything is stable.
>
> Can you clarify how you're setting the voltages to ensure stability?

below is the diff :  wip/exynos/integ

--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -225,7 +225,7 @@

                        buck2_reg: BUCK2 {
                                regulator-name = "vdd_arm";
-                               regulator-min-microvolt = <800000>;
+                               regulator-min-microvolt = <1500000>;
                                regulator-max-microvolt = <1500000>;
                                regulator-always-on;
                                regulator-boot-on;
@@ -260,7 +260,7 @@

                        buck6_reg: BUCK6 {
                                regulator-name = "vdd_kfc";
-                               regulator-min-microvolt = <800000>;
+                               regulator-min-microvolt = <1500000>;
                                regulator-max-microvolt = <1500000>;
                                regulator-always-on;
                                regulator-boot-on;

>
> Tomasz, I didn't mean to suggest this isn't ready for mainline.  For the
> 5420/5800 it seems cpufreq support is a new feature, so this isn't a
> regression against previous (mainline) behavior.  Maybe the big.LITTLE
> cpufreq support should've been separated out from the cleanup since it's
> more of a new feature, but that's up to you.
>
> Kevin
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

regards,
Chander
