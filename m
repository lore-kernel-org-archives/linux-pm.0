From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: exynos: remove dead ->need_apll_change method
Date: Sat, 28 Mar 2015 08:51:55 +0530
Message-ID: <CAKohpokU=1XM2BHsF-vLizAbLqdkCb5ZwHmeP_O4kD6xnuLyQA@mail.gmail.com>
References: <2557080.JPtuM0lETZ@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2557080.JPtuM0lETZ@amdc1032>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sachin Kamat <sachin.kamat@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27 March 2015 at 22:02, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Commit 26ab1c62b6e1 ("cpufreq: exynos5250: Set APLL rate
> using CCF API") removed the last user of ->need_apll_change
> method.  Remove it and then cleanup exynos_cpufreq_scale()
> accordingly.
>
> This patch was tested on Exynos4412 SoC based Trats2 board.
>
> There should be no functional changes caused by this patch.
>
> Cc: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/exynos-cpufreq.c |   30 +++---------------------------
>  drivers/cpufreq/exynos-cpufreq.h |    1 -
>  2 files changed, 3 insertions(+), 28 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Kukjin: please take it through your tree.
