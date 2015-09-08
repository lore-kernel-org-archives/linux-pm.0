From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 4/4] ARM: dts: add suspend opp to exynos4412
Date: Tue, 08 Sep 2015 09:34:28 +0900
Message-ID: <55EE2D14.2080203@samsung.com>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
 <1441640501-13613-5-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33244 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbIHAek (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 20:34:40 -0400
In-reply-to: <1441640501-13613-5-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 08.09.2015 00:41, Bartlomiej Zolnierkiewicz wrote:
> Mark 800MHz OPP as a suspend opp for Exynos4412 based
> boards so effectively cpufreq-dt driver behavior w.r.t.
> suspend frequency matches what the old exynos-cpufreq
> driver has been doing.
> 
> This patch fixes suspend/resume support on Exynos4412 based
> Trats2 board and reboot hang on Exynos4412 based Odroid U3
> board.
> 
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof


