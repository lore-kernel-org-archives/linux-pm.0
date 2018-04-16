From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 01/14] thermal: exynos: Reading temperature makes sense
 only when TMU is turned on
Date: Mon, 16 Apr 2018 14:17:44 +0200
Message-ID: <60958515.5KCaPvLZ9i@amdc3058>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <1523873525-23718-2-git-send-email-b.zolnierkie@samsung.com>
        <a49d9651-bb52-85bc-ffc0-2ba012e66dd5@linaro.org>
        <CGME20180416121746eucas1p1de1cf16bcf7d8fdccd87ac41db735ef6@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a49d9651-bb52-85bc-ffc0-2ba012e66dd5@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Monday, April 16, 2018 02:06:41 PM Daniel Lezcano wrote:
> On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
> > From: Marek Szyprowski <m.szyprowski@samsung.com>
> > 
> > When thermal sensor is not yet enabled, reading temperature might return
> > random value. This might even result in stopping system booting when such
> > temperature is higher than the critical value. Fix this by checking if TMU
> > has been actually enabled before reading the temperature.
> > 
> > This change fixes booting of Exynos4210-based board with TMU enabled (for
> > example Samsung Trats board), which was broken since v4.4 kernel release.
> 
> Why not move the thermal_zone_of_sensor_register *after* initializing
> the sensor ?

For initializing the sensor we need data obtained from
therm_zone_of_sensor_register() so it cannot be easily
done (especially since we also want the fix to be
ported to -stable kernels). For more detailed description
please see:

https://lkml.org/lkml/2018/4/10/376

> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Fixes: 9e4249b40340 ("thermal: exynos: Fix first temperature read after registering sensor")
> > CC: stable@vger.kernel.org # v4.6+
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
