From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v7 4/7] cpufreq:boost:Kconfig: Provide support for
 software managed BOOST
Date: Mon, 26 Aug 2013 11:05:13 +0530
Message-ID: <CAKohpon0+A0y3toZg_ckYuW7U0BXsvBvxBkDDyY9w+sKdDw_rQ@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1376388505-30233-1-git-send-email-l.majewski@samsung.com>
	<1376388505-30233-5-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376388505-30233-5-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, "R, Durgadoss" <durgadoss.r@intel.com>
List-Id: linux-pm@vger.kernel.org

On 13 August 2013 15:38, Lukasz Majewski <l.majewski@samsung.com> wrote:
> For safety reasons new flag - CONFIG_CPU_FREQ_BOOST_SW has been added.
> Only after selecting "EXYNOS Frequency Overclocking - Software" Kconfig
> option the software managed boost is enabled. It also selects thermal
> subsystem to be compiled in. Thermal is necessary for disabling boost
> and cooling down the device when overheating detected.
>
> Boost _MUST_NOT_ work without thermal subsystem with properly defined
> overheating temperatures.
>
> This option doesn't affect x86's ACPI hardware managed boost support
> (i.e. Intel, AMD). In this situation boost management is embedded at
> hardware.
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
>
> ---
> Changes for v7:
> - Remove superfluous "default n" definition
> - Generic CPU_FREQ_BOOST_SW depends on THERMAL

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
