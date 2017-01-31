From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 1/5] soc: samsung: pm_domains: Use full names in
 subdomains registration log
Date: Tue, 31 Jan 2017 21:35:13 +0200
Message-ID: <20170131193513.fvzi6ey52h6bkuqc@kozik-lap>
References: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130121913eucas1p22838794c26581e0b1757f2610ce9b32d@eucas1p2.samsung.com>
 <1485778740-30337-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33217 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbdAaTm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 14:42:27 -0500
Content-Disposition: inline
In-Reply-To: <1485778740-30337-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>

On Mon, Jan 30, 2017 at 01:18:56PM +0100, Marek Szyprowski wrote:
> Device tree none name for each power domain should be "power-domain", so
> use a bit more descriptive full node name in messages about subdomain
> registration. This way the following meaningless message:
> 
> power-domain has as child subdomain: power-domain.
> 
> is changed to a bit more meaningful one:
> 
> /soc/power-domain@105c40a0 has as child subdomain: /soc/power-domain@105c4020.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/soc/samsung/pm_domains.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof

