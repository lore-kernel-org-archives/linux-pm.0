From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/8] soc: samsung: pm_domains: Add new exynos5433
 compatible
Date: Fri, 27 Jan 2017 09:42:07 +0200
Message-ID: <20170127074207.rtciuztyvpoh3f7c@kozik-lap>
References: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115559eucas1p22d097adf456c6854c73d1bac9632776c@eucas1p2.samsung.com>
 <1485345342-3273-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485345342-3273-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 25, 2017 at 12:55:35PM +0100, Marek Szyprowski wrote:
> From: Chanwoo Choi <cw00.choi@samsung.com>
> 
> This patch adds the new compatible string for exynos5433 because the exynos5433
> use the '0xf' value to turn on and off instead of '0x7'.
> 
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/power/pd-samsung.txt | 1 +
>  drivers/soc/samsung/pm_domains.c                       | 7 +++++++
>  2 files changed, 8 insertions(+)
>

Applied with commit msg changes.

Best regards,
Krzysztof
