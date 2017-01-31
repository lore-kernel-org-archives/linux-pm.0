From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 3/5] soc: samsung: pm_domains: Remove message about
 failed memory allocation
Date: Tue, 31 Jan 2017 21:39:47 +0200
Message-ID: <20170131193947.drcfpgwpe4ypabbm@kozik-lap>
References: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130121924eucas1p24f99bd1ca38a37d88d54aae96d0e141f@eucas1p2.samsung.com>
 <1485778740-30337-4-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485778740-30337-4-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 30, 2017 at 01:18:58PM +0100, Marek Szyprowski wrote:
> Memory subsystem already prints message about failed memory
> allocation, there is no need to do it in the drivers.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/soc/samsung/pm_domains.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
