From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v3 1/4] clk: samsung: exynos5250: add cpu clock
 configuration data and instantiate cpu clock
Date: Thu, 2 Jul 2015 13:14:03 +0200
Message-ID: <CABxcv=kypxFJeFFciaz5=+M-AcFbtS1OEXMzRWMM+Zt272THjQ@mail.gmail.com>
References: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
 <1435756238-845-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1435756238-845-2-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, linux-clk@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Bartlomiej,

On Wed, Jul 1, 2015 at 3:10 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
>
> With the addition of the new Samsung specific cpu-clock type, the
> arm clock can be represented as a cpu-clock type. Add the CPU clock
> configuration data and instantiate the CPU clock type for Exynos5250.
>
> Changes by Bartlomiej:
> - split Exynos5250 support from the original patch
> - moved E5250_CPU_DIV[0,1]() macros to clk-exynos5250.c
>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5250.c   | 31 +++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/exynos5250.h |  1 +
>  2 files changed, 32 insertions(+)

Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>

and on an Exynos5250 Snow Chromebook:

Tested-by: Javier Martinez Canillas <javier@dowhile0.org>

Best regards,
Javier
