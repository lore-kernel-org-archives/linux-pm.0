From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v9 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
Date: Thu, 31 Jul 2014 16:15:15 +0200
Message-ID: <53DA4F73.5040400@gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Thomas,

On 30.07.2014 10:07, Thomas Abraham wrote:
> Changes since v8:
> - Fixes suggested by Tomasz Figa.
> 
> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
> drivers and enables the use of cpufreq-cpu0 driver for these platforms. This
> series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
> driver.
> 
> This patch series is dependent on two other patches
> 1. ARM: dts: add CPU nodes for Exynos4 SoCs
>    - https://lkml.org/lkml/2014/7/21/315
> 2. ARM: dts: smdk5250: Specify MAX77686 pmic interrupt
>    - http://www.spinics.net/lists/arm-kernel/msg351134.html
> 3. clk: exynos4: remove duplicate div_core2 divider clock instantiation
>    - http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg34859.html

I think we are at final stage of works on this series. Thanks for your
cooperation.

After addressing remaining minor comments from this thread, feel free to
add:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
