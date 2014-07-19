From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v7 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
Date: Sat, 19 Jul 2014 22:54:06 +0200
Message-ID: <53CADAEE.2070009@gmail.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com> <53CAC4FB.9030703@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <53CAC4FB.9030703@gmx.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tobias Jakobi <liquid.acid@gmx.net>, Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com
List-Id: linux-pm@vger.kernel.org

Tobias,

On 19.07.2014 21:20, Tobias Jakobi wrote:
> Hello,
> 
> I have a question concerning an older version of this patchset, the one
> which still included exynos4x12 support and where the clocking data was
> provided through DT.
> 
> I tried to get this working for my ODROID-X2, which does work well,
> including the usage of the boost frequences. Since the X2 has an
> Exynos4412 Prime I added additional clocking data and operating points.
> 
> clocking data (comes from the vendor kernel):
> <1704000 3 7 0 6 1 2 7 0 7>
> <1600000 3 7 0 6 1 2 6 0 7>
> 
> operating points (again from vendor kernel):
> 1704000 1375000
> 1600000 1350000
> 
> Doing this I get correct output from scaling_available_frequencies and
> scaling_boost_frequencies and the driver seems to select these
> frequences. However when reading from cpufreq_cur_freq, which I think
> returns the frequency of the armclk, the maximum freq never exceeds
> 1.5GHz. So effectively the additional clocking data and opps are not used.
> 
> I wonder this happens? Is there some kind of limit enforced?

Have you also extended the array of allowed APLL settings in
drivers/clk/clk-exynos4.c?

Best regards,
Tomasz
