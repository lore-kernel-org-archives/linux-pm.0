From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 4/5] soc: samsung: pm_domains: Read domain name from
 the new label property
Date: Tue, 31 Jan 2017 21:40:11 +0200
Message-ID: <20170131194011.6gxzzveulvtgjg4o@kozik-lap>
References: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130121915eucas1p23aa4f4be912bcd64f9521f6e6b51132f@eucas1p2.samsung.com>
 <1485778740-30337-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33250 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751939AbdAaTkm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 14:40:42 -0500
Content-Disposition: inline
In-Reply-To: <1485778740-30337-5-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>

On Mon, Jan 30, 2017 at 01:18:59PM +0100, Marek Szyprowski wrote:
> Device tree nodes for each power domain should use generic "power-domain"
> name, so using it as a domain name doesn't give much benefits. This patch
> adds support for human readable names defined in 'label' property. Such
> names are visible to userspace and makes debugging much easier. When no
> 'label' property is found, driver keeps using the name constructed from
> full node name.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/power/pd-samsung.txt |  4 ++++
>  drivers/soc/samsung/pm_domains.c                       | 12 ++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof

