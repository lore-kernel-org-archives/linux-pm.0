From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: exynos5250: Set APLL rate using CCF API
Date: Thu, 21 Nov 2013 11:02:51 +0530
Message-ID: <CAKohpomksAg4RpgTJ=mgtRnKHCidzEjfYHVeLQku1Jck_URmxg@mail.gmail.com>
References: <1385009046-22070-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1385009046-22070-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 21 November 2013 10:14, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Use common clock framework (CCF) APIs to set the clock rates
> instead of direct register manipulation. This now updates the
> sysfs entry (cpuinfo_cur_freq) correctly which did not reflect
> the correct value until now. While at it clean up the PLL s-div
> parameter setting as it is handled by the PLL driver.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> To fully test this, the following 2 patches would be necessary:
> * clk: exynos5250: register APLL rate table
> http://www.spinics.net/lists/arm-kernel/msg285103.html
> * clk: exynos5250: Add CLK_SET_RATE_PARENT flag to mout_apll
> http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/24906
> ---
>
>  drivers/cpufreq/exynos5250-cpufreq.c |   74 +++++-----------------------------
>  1 file changed, 10 insertions(+), 64 deletions(-)

Nice cleanup..

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
