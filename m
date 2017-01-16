From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 00/12] Move pad retention control to Exynos pin
 controller driver
Date: Mon, 16 Jan 2017 21:23:45 +0200
Message-ID: <20170116192345.4cywkpzsswitgclp@kozik-lap>
References: <CGME20170116064523eucas1p161a8e060b2883c076fc470ce7b522332@eucas1p1.samsung.com>
 <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 16, 2017 at 07:44:55AM +0100, Marek Szyprowski wrote:
> Hello,
> 
> This patchset is a follow-up of my work on adding runtime PM support
> to Exynos pin controller driver:
> http://www.spinics.net/lists/arm-kernel/msg550161.html
> 
> Runtime PM support itself needs a bit more discussion, so lets first focus on
> the prerequisites.
> 
> In case of Exynos pin controller driver it is a pad retention control. In
> current code it was handled by machine and PMU code and had no relation to
> what pin controller driver does. This patch series moves pad retention
> control to pin controller driver. While implmenting it, I also did a little
> cleanup of both Exynos PMU and pin controller drivers.
> 
> Patches are based on linux-next from 2017.01.16 with Exynos4415 support
> removal patch applied: https://lkml.org/lkml/2017/1/14/137

I didn't find explicit statement for dependency between the patches in
the patchset itself and also I could not find the usage of
EXYNOS_PMU_DEV_NAME by pinctrl driver.

Do the pinctrl changes depend on soc/samsung patches? If not, then
probably your future work will depend on this?

Best regards,
Krzysztof
