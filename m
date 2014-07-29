From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v8 4/6] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4210/5250/5420
Date: Tue, 29 Jul 2014 12:32:38 +0200
Message-ID: <53D77846.4060700@gmail.com>
References: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com> <1406611711-25112-5-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406611711-25112-5-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com
List-Id: linux-pm@vger.kernel.org

On 29.07.2014 07:28, Thomas Abraham wrote:
> The new CPU clock type allows the use of generic CPUfreq drivers. So for
> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
> which did not have CPUfreq driver support, enable the use of generic
> CPUfreq driver.
> 
> Suggested-by: Tomasz Figa <t.figa@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c |   24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
