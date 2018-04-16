From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 07/14] thermal: exynos: remove parsing of
 samsung,tmu_noise_cancel_mode property
Date: Mon, 16 Apr 2018 15:03:39 +0200
Message-ID: <bb3f5efc-a53b-52cc-c863-9c29d356feef@linaro.org>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101406epcas2p267a664bb26a00bdca6c4c176f9ce08ed@epcas2p2.samsung.com>
 <1523873525-23718-8-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523873525-23718-8-git-send-email-b.zolnierkie@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> All SoCs use the same value (4) for the noise cancel mode so just
> make it explicit and remove parsing of samsung,tmu_noise_cancel_mode
> property.
> 
> There should be no functional changes caused by this patch.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
