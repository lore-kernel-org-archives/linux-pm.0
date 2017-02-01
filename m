From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 4/5] soc: samsung: pm_domains: Read domain name from
 the new label property
Date: Wed, 1 Feb 2017 10:25:54 -0600
Message-ID: <20170201162554.airhzowkqpyaxqpf@rob-hp-laptop>
References: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130121915eucas1p23aa4f4be912bcd64f9521f6e6b51132f@eucas1p2.samsung.com>
 <1485778740-30337-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35859 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbdBAQZ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2017 11:25:56 -0500
Content-Disposition: inline
In-Reply-To: <1485778740-30337-5-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, devicetree@vger.kernel.org

On Mon, Jan 30, 2017 at 01:18:59PM +0100, Marek Szyprowski wrote:
> Device tree nodes for each power domain should use generic "power-domain"
> name, so using it as a domain name doesn't give much benefits. This patch
> adds support for human readable names defined in 'label' property. Such
> names are visible to userspace and makes debugging much easier. When no
> 'label' property is found, driver keeps using the name constructed from
> full node name.

I'm not sure this is really a good use of label. label is intended for 
end user visible things like ports/connectors on a board. It's fine 
here, but I wouldn't want to see it used everywhere.

> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/power/pd-samsung.txt |  4 ++++
>  drivers/soc/samsung/pm_domains.c                       | 12 ++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
