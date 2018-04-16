From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 01/14] thermal: exynos: Reading temperature makes sense
 only when TMU is turned on
Date: Mon, 16 Apr 2018 14:06:41 +0200
Message-ID: <a49d9651-bb52-85bc-ffc0-2ba012e66dd5@linaro.org>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180416101339epcas2p171d462b70a85a6fff3bb939fca6d469d@epcas2p1.samsung.com>
 <1523873525-23718-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523873525-23718-2-git-send-email-b.zolnierkie@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> When thermal sensor is not yet enabled, reading temperature might return
> random value. This might even result in stopping system booting when such
> temperature is higher than the critical value. Fix this by checking if TMU
> has been actually enabled before reading the temperature.
> 
> This change fixes booting of Exynos4210-based board with TMU enabled (for
> example Samsung Trats board), which was broken since v4.4 kernel release.

Why not move the thermal_zone_of_sensor_register *after* initializing
the sensor ?

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 9e4249b40340 ("thermal: exynos: Fix first temperature read after registering sensor")
> CC: stable@vger.kernel.org # v4.6+
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
