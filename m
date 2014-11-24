From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v12 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
Date: Mon, 24 Nov 2014 16:14:17 +0100
Message-ID: <54734B49.9050109@samsung.com>
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, mturquette@linaro.org, kgene.kim@samsung.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, tomasz.figa@gmail.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com, khilman@linaro.org, Kukjin Kim <kgene@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi All,

On 21/11/14 14:31, Thomas Abraham wrote:
> Changes since v11:
> - Rebased on top of git://linuxtv.org/snawrocki/samsung.git for-v3.19-exynos-clk
> 
> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
> drivers and enables the use of cpufreq-dt driver for these platforms. This
> series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
> driver.
> 
> This series is based on the following branch.
> git://linuxtv.org/snawrocki/samsung.git for-v3.19-exynos-clk
> 
> This series depends on the following patch which can be picked from
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git samsung/dt
> e540920cf21c (ARM: dts: add CPU nodes for Exynos4 SoCs).
> 
> This patch series has been tested on Exynos4210/5250/5420 based boards.
> Tomasz Figa had plans to take this in the Samsung clock tree for v3.19
> (http://www.spinics.net/lists/linux-samsung-soc/msg37933.html).
> Sylwester, could you consider to merge this in your tree?

This patch series has already conflicts in arch/arm/boot/dts/ with
the arm-soc tree. It touches quite many files at arch/arm. Perhaps
we could still have it merged through Kukjin's and arm-soc tree ?

Feel free to add for the whole series:
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Thanks,
Sylwester
