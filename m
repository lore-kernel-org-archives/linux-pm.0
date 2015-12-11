From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v5 0/7] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
Date: Fri, 11 Dec 2015 10:34:13 +0900
Message-ID: <566A2815.2020908@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:19711 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbLKBeb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 20:34:31 -0500
In-reply-to: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, Ben Gamari <ben@smart-cactus.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 11.12.2015 01:58, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds generic cpufreq-dt driver support for
> Exynos542x/5800 (using the new CPU clock type which allows it).
> 
> It has been tested on Exynos5422 based ODROID-XU3 Lite board.
> 
> Depends on:
> - next-20151124 branch of linux-next kernel tree

Bartlomiej,
Thanks for update! Nice work. Everything looks good for me. As for
merging, my last pull requests are waiting on Kukjin, so I am not
grabbing more stuff till they get in. This (I hope) should happen this
weekend so:
1. Either Kukjin will pick it up directly,
2. I could apply this later and hopefully still send them for v4.5.


Sylwester,
However in case of any delay, how about merging clock changes now
through clock tree and preparing a tag for samsung-soc? If the series
won't make till v4.5 then at least dependency would be merged.

In that case you could also pick the first patch from Marek's GSCL clock.


Best regards,
Krzysztof

