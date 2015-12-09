From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v4 0/8] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
Date: Wed, 9 Dec 2015 10:13:42 -0300
Message-ID: <56682906.50607@osg.samsung.com>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:49820 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbbLINNw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Dec 2015 08:13:52 -0500
In-Reply-To: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello Bartlomiej,

On 12/07/2015 03:18 PM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds generic cpufreq-dt driver support for
> Exynos542x/5800 (using the new CPU clock type which allows it).
> 
> It has been tested on Exynos5422 based ODROID-XU3 Lite board.
>

I tested on an Exynos5800 Peach Pi and all governors are working
as expected on both the Cortex-A7 and Cortex-A15 cores.

So for the whole series:

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
