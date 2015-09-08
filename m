From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 0/4] cpufreq-dt: add suspend frequency support
Date: Tue, 08 Sep 2015 12:56:41 +0900
Message-ID: <55EE5C79.2030604@samsung.com>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
 <20150908024659.GF26760@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33595 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbbIHD4x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 23:56:53 -0400
In-reply-to: <20150908024659.GF26760@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 08.09.2015 11:46, Viresh Kumar wrote:
> On 07-09-15, 17:41, Bartlomiej Zolnierkiewicz wrote:
>> Hi,
>>
>> This patch series adds suspend frequency support (using opp-v2
>> bindings and suspend-opp functionality) to cpufreq-dt driver and
>> then adds suspend opp for Exynos4412 based boards.
>>
>> This patch series fixes suspend/resume support on Exynos4412
>> based Trats2 board and reboot hang on Exynos4412 based Odroid
>> U3 board.
>>
>> Changes since v3:
>> - fixed dev_pm_opp_get_suspend_opp() locking
>> - shortened variable name in dev_pm_opp_get_suspend_opp()
>> - adjusted cpufreq_generic_suspend() to work with cpufreq-dt
>> - removed no longer needed cpufreq_dt_suspend()
>> - added Acked-by tag from Viresh to patch #4
> 
> Just a minor comment on 3/4 and after fixing that:
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Dear Kukjin,

There were no comments from your side for this patchset nor for previous
Marek's fix. After mentioned change and Bart's re-spin, do you plan to
grab this patchset and send it for current v4.3 cycle?

Best regards,
Krzysztof

