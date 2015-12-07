From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v3 06/10] clk: samsung: exynos5800: fix cpu clock
 configuration data
Date: Mon, 07 Dec 2015 16:25:37 +0100
Message-ID: <5665A4F1.8000504@samsung.com>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
 <1449250235-9613-7-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1449250235-9613-7-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/12/15 18:30, Bartlomiej Zolnierkiewicz wrote:
> Fix cpu clock configuration data for Exynos5800 (it uses
> higher PCLK_DBG divider values than Exynos5420 and supports
> additional frequencies).
> 
> Based on Hardkernel's kernel for ODROID-XU3 board.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Regards,
Sylwester
