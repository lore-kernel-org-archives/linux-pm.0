From: Sylwester nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 4/7] clk: samsung: exynos4x12: add cpu clock
 configuration data and instantiate cpu clock
Date: Wed, 15 Jul 2015 18:58:17 +0900
Message-ID: <55A62EB9.7040902@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-5-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1436456621-29839-5-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/10/2015 12:43 AM, Bartlomiej Zolnierkiewicz wrote:
> With the addition of the new Samsung specific cpu-clock type, the
> arm clock can be represented as a cpu-clock type. Add the CPU clock
> configuration data and instantiate the CPU clock type for Exynos4x12.
>
> Based on the earlier work by Thomas Abraham.
>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos4.c | 50 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)

I guess you prefer to have this whole series applied through one,
e.g samsung-soc tree? If so, here is my ack.

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
