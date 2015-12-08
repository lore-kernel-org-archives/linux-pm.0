From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 3/8] ARM: dts: Exynos5420: add CPU OPP properties
Date: Tue, 8 Dec 2015 11:58:24 +0530
Message-ID: <20151208062824.GV3294@ubuntu>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
 <1449512300-17230-4-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35279 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932757AbbLHG23 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 01:28:29 -0500
Received: by pacej9 with SMTP id ej9so6994737pac.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2015 22:28:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449512300-17230-4-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Andreas Faerber <afaerber@suse.de>, Sachin Kamat <sach>

On 07-12-15, 19:18, Bartlomiej Zolnierkiewicz wrote:
> +	cpu1_opp_table: opp_table1 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +		opp00@1300000000 {

This should be just opp@1300000000, you don't need 00/01/02... anymore
now. Same for the other patch as well..

Fix that in other patches in this series and you also need to fix it
for arch/arm/boot/dts/exynos4212.dtsi based on what I see in
linux-next.

-- 
viresh
