From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v6 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
Date: Wed, 16 Dec 2015 09:43:57 +0900
Message-ID: <5670B3CD.8010604@samsung.com>
References: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
 <1450200801-24539-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:35916 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434AbbLPAoF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 19:44:05 -0500
In-reply-to: <1450200801-24539-4-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ben Gamari <ben@smart-cactus.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>

On 16.12.2015 02:33, Bartlomiej Zolnierkiewicz wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> For Exynos542x/5800 platforms, add CPU operating points
> for migrating from Exynos specific cpufreq driver to using
> generic cpufreq driver.
> 
> Changes by Bartlomiej:
> - split Exynos5420 support from the original patch
> - merged Exynos5422 fixes from Ben
> 
> Changes by Ben Gamari:
> - Port to operating-points-v2
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Andreas Faerber <afaerber@suse.de>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Ben Gamari <ben@smart-cactus.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-cpus.dtsi |  10 +++
>  arch/arm/boot/dts/exynos5420.dtsi      | 110 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-cpus.dtsi |  10 +++
>  3 files changed, 130 insertions(+)
> 

Thanks for rebasing on "exynos5422-cpus.dtsi" patch, I appreciate this.

Looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

