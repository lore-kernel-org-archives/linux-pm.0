From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v6 0/7] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
Date: Thu, 28 Jan 2016 19:50:41 +0900
Message-ID: <56A9F281.2080906@samsung.com>
References: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
 <20151216021446.GC3111@ubuntu> <56A9F205.1060302@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <56A9F205.1060302@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Ben Gamari <ben@smart-cactus.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 28.01.2016 19:48, Krzysztof Kozlowski wrote:
> On 16.12.2015 11:14, Viresh Kumar wrote:
>> On 15-12-15, 18:33, Bartlomiej Zolnierkiewicz wrote:
>>> Hi,
>>>
>>> This patch series adds generic cpufreq-dt driver support for
>>> Exynos542x/5800 (using the new CPU clock type which allows it).
>>>
>>> It has been tested on Exynos5422 based ODROID-XU3 Lite board.
>>>
>>> Depends on:
>>> - next-20151211 branch of linux-next kernel tree
>>> - "[PATCH] ARM: dts: Make CPU configuration more readable for
>>>   exynos542x/5800" patch (https://lkml.org/lkml/2015/12/11/107)
>>>
>>> Changes since v5:
>>> - rebased over next-20151211 branch (something is broken in
>>>   newer branches, namely next-2015121[45])
>>> - rebased on top of "ARM: dts: Make CPU configuration more
>>>   readable for exynos542x/5800" patch
>>> - renamed cpu0_opp_table to cluster_a15_opp_table and
>>>   cpu1_opp_table to cluster_a7_opp_table
>>> - added Reviewed-by from Krzysztof
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Applied entire patchset to my krzk repo.

Wrong. Applied only Exynos part, which is DTS + mach-exynos. The clock
stuff was already in v4.5-rc1.

Best regards,
Krzysztof
