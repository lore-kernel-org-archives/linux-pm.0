From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 06/14] thermal: exynos: remove parsing of
 samsung,tmu_[first,second]_point_trim properties
Date: Mon, 16 Apr 2018 14:57:48 +0200
Message-ID: <56dc5d6f-5345-2df5-109e-29109917d55e@linaro.org>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101403epcas2p23c050a54c2cc8af9c8be76061d560937@epcas2p2.samsung.com>
 <1523873525-23718-7-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523873525-23718-7-git-send-email-b.zolnierkie@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> All SoCs use the same values (25, 85) for trim points (except
> Exynos5440 which currently specifices value 70 for the second trim
> point -> it seems to be a mistake because documentation uses value
> 85 and two points based trimming has never been used by the driver
> for this SoC anyway) so just make it explicit and remove parsing of
> samsung,tmu_[first,second]_point_trim properties.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
