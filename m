From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v7 7/7] cpufreq:exynos4x12: Change L0 driver data to CPUFREQ_BOOST_FREQ
Date: Mon, 26 Aug 2013 11:07:25 +0530
Message-ID: <CAKohponJ_7s39Meg4di_BF-KCcby+LAuOtvedHPRzONG=MN-8w@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1376388505-30233-1-git-send-email-l.majewski@samsung.com>
	<1376388505-30233-8-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376388505-30233-8-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, "R, Durgadoss" <durgadoss.r@intel.com>
List-Id: linux-pm@vger.kernel.org

On 13 August 2013 15:38, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Special driver data flag (CPUFREQ_BOOST_FREQ) has been added to indicate
> frequency, which can be only enabled for BOOST mode.
> This frequency shall be used only for limited time, since it might cause
> target device to overheat.
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
>
> ---
> Changes for v7:
> - None

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
