From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 1/4] dmaengine: pl330: remove pdata based
 initialization
Date: Fri, 13 Jan 2017 15:20:41 +0200
Message-ID: <20170113132041.3k7sr7ciy46dd42q@kozik-lap>
References: <1484292400-29730-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170113072651eucas1p214662327fe5a3dfbaa79d11c2a0b195a@eucas1p2.samsung.com>
 <1484292400-29730-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33517 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbdAMNVV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2017 08:21:21 -0500
Content-Disposition: inline
In-Reply-To: <1484292400-29730-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>

On Fri, Jan 13, 2017 at 08:26:37AM +0100, Marek Szyprowski wrote:
> This driver is now used only on platforms which support device tree, so
> it is safe to remove legacy platform data based initialization code.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/plat-samsung/devs.c |  1 -

For plat-samsung:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

