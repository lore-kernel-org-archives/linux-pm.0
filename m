From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 0/3] thermal: exynos: Fixes for vtmu-supply regulator
 handling
Date: Fri, 19 Feb 2016 13:29:54 +0900
Message-ID: <20160219042954.GD27936@samsunx.samsung>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:40747 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757273AbcBSE34 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 23:29:56 -0500
Content-disposition: inline
In-reply-to: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-samsung-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>

Hi Javier,

> Javier Martinez Canillas (3):
>   thermal: exynos: List vtmu-supply as optional property in DT binding
>   thermal: exynos: Use devm_regulator_get_optional() for vtmu
>   thermal: exynos: Defer probe if vtmu is present but not registered
> 
>  Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 9 ++++++---
>  drivers/thermal/samsung/exynos_tmu.c                         | 4 +++-
>  2 files changed, 9 insertions(+), 4 deletions(-)

for all of them:

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Andi
