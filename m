From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] cpufreq: exynos: allow build for !THERMAL or !CPU_THERMAL
 cases
Date: Mon, 23 Mar 2015 17:43:40 +0100
Message-ID: <75115513.B5dLcdQ7nU@amdc1032>
References: <2275232.48muFcOOQv@amdc1032>
 <CAKohpomXnpdLtMpnWeFWdGDCE4t8iEz5aDxA=PhTcR-UKjQM6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKohpomXnpdLtMpnWeFWdGDCE4t8iEz5aDxA=PhTcR-UKjQM6A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


Hi,

On Monday, February 23, 2015 10:07:50 AM Viresh Kumar wrote:
> On 20 February 2015 at 21:50, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > Allow driver build for !THERMAL or !CPU_THERMAL cases.
> >
> > The new dependency rule is the same as the one that CPUFREQ_DT
> > option has (for cpufreq-dt driver which has the same issue with
> > using of_cpufreq_cooling_register()).
> >
> > Cc: Kukjin Kim <kgene@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Lukasz Majewski <l.majewski@samsung.com>
> > Fixes: 8b2b4a4e5366 ("cpufreq: exynos: allow modular build")
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/cpufreq/Kconfig.arm | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index 1b06fc4..f4df4af3 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -28,7 +28,8 @@ config ARM_VEXPRESS_SPC_CPUFREQ
> >  config ARM_EXYNOS_CPUFREQ
> >         tristate "SAMSUNG EXYNOS CPUfreq Driver"
> >         depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250
> > -       depends on THERMAL
> > +       # if CPU_THERMAL is on and THERMAL=m, ARM_EXYNOS_CPUFREQ cannot be =y:
> > +       depends on !CPU_THERMAL || THERMAL
> >         help
> >           This adds the CPUFreq driver for Samsung EXYNOS platforms.
> >           Supported SoC versions are:
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thank you for the ACK.

Would you pick this patch up or should I resend it to Rafael?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
