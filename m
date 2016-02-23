From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] thermal: exynos: List vtmu-supply as optional
 property in DT binding
Date: Tue, 23 Feb 2016 14:26:12 -0600
Message-ID: <20160223202612.GA10733@rob-hp-laptop>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
 <1455819551-4666-2-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43205 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbcBWU0S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Feb 2016 15:26:18 -0500
Content-Disposition: inline
In-Reply-To: <1455819551-4666-2-git-send-email-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Eduardo Valentin <edubezval@gmail.com>

On Thu, Feb 18, 2016 at 03:19:09PM -0300, Javier Martinez Canillas wrote:
> The Exynos Thermal Management Unit binding says that the vtmu-supply
> is optional but is listed in the required properties section. Add an
> optional properties section and move the regulator property there.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
