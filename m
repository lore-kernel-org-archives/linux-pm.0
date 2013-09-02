From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] ARM: EXYNOS: add cpuidle-exynos.max_states kernel
 parameter
Date: Mon, 02 Sep 2013 11:41:29 +0200
Message-ID: <7429815.RzOHxBbusd@amdc1032>
References: <4002844.4ZqqJexTv4@amdc1032> <52245239.4000903@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <52245239.4000903@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tomasz Figa <t.figa@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, September 02, 2013 10:54:17 AM Daniel Lezcano wrote:
> On 08/30/2013 12:21 PM, Bartlomiej Zolnierkiewicz wrote:
> > Add "cpuidle-exynos.max_states=" parameter to allow user to specify
> > the maximum of allowed CPU idle states for ARM EXYNOS cpuidle driver.
> > 
> > This change is needed because C1 state (AFTR mode) is often not able
> > to work properly due to incompatibility with some bootloader versions.
> > 
> > Usage examples:
> > 
> > "cpuidle-exynos.max_states=1" disables C1 state (AFTR mode).
> > 
> > "cpuidle-exynos.max_states=0" disables the driver completely.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Tomasz Figa <t.figa@samsung.com>
> > Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> 
> There is a max_cstate option for acpi and intel idle. There is also the
> cpuidle.off=1 option. As the semantic is the same, I think adding a
> common cpuidle option usable for all the drivers is better.

I thought about making the option common for all cpuidle drivers first
but due to support for multiple cpuidle drivers on one machine (i.e.
big.LITTLE), per-driver option looked like a better approach.

Should I make the option common and not worry about multiple drivers on
one machine support?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
