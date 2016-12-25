From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 6/9] pinctrl: samsung: Replace syscore ops with standard
 platform device pm_ops
Date: Sun, 25 Dec 2016 20:47:38 +0200
Message-ID: <20161225184738.j5yn6q2jswv4kv5x@kozik-lap>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122535epcas1p475bc33007e9ea9b206dec6d10d019d7f@epcas1p4.samsung.com>
 <1482495889-6201-7-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1482495889-6201-7-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 23, 2016 at 01:24:46PM +0100, Marek Szyprowski wrote:
> Once the dependency on PMU driver (for pad retention control) has been
> removed, there is no reason to use syscore_ops based suspend/resume.
> This patch replaces it with standard platform device pm_ops based solution.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 72 ++++++-------------------------
>  1 file changed, 13 insertions(+), 59 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
