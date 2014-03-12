From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 0/4] devfreq: exynos4: Support dt and use common ppmu driver
Date: Wed, 12 Mar 2014 16:35:54 +0100
Message-ID: <25377064.TEmkdt3qR8@amdc1032>
References: <1394624882-2989-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:27755 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754943AbaCLPg3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Mar 2014 11:36:29 -0400
In-reply-to: <1394624882-2989-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, nm@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org


Hi,

On Wednesday, March 12, 2014 08:47:58 PM Chanwoo Choi wrote:
> This patchset support devicetree and use common ppmu driver instead of
> individual code of exynos4_bus.c to remove duplicate code. Also this patchset
> get the resources for busfreq from dt data by using DT helper function.
> - PPMU register address
> - PPMU clock
> - Regulator for INT/MIF block
> 
> This patchset use SET_SYSTEM_SLEEP_PM_OPS macro intead of legacy method.
> To remove power-leakage in suspend state, before entering suspend state,
> disable ppmu clocks.
> 
> Chanwoo Choi (4):
>   devfreq: exynos4: Support devicetree to get device id of Exynos4 SoC
>   devfreq: exynos4: Use common ppmu driver and get ppmu address from dt data
>   devfreq: exynos4: Add ppmu's clock control and code clean about regulator control
>   devfreq: exynos4: Use SET_SYSTEM_SLEEP_PM_OPS macro instead of legacy method
> 
>  drivers/devfreq/exynos/exynos4_bus.c | 396 ++++++++++++++++++++++++-----------
>  1 file changed, 271 insertions(+), 125 deletions(-)

The patchset generally looks OK, for my review comments please see separate
mails.  One thing I forgot to mention yet: please also fix DTS files so
exynos4_bus driver is finally functional (currently even with this patchset
it is not).

PS Please also add linux-samsung-soc@vger.kernel.org to Cc: when sending
the next revision of this patchset.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

