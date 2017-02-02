From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 3/3] thermal: zx2967: add thermal driver for ZTE's
 zx2967 family
Date: Wed, 1 Feb 2017 21:04:27 -0800
Message-ID: <20170202050425.GA7360@localhost.localdomain>
References: <1484714522-26651-1-git-send-email-baoyou.xie@linaro.org>
 <1484714522-26651-3-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34890 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbdBBFEc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2017 00:04:32 -0500
Content-Disposition: inline
In-Reply-To: <1484714522-26651-3-git-send-email-baoyou.xie@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: jun.nie@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shawnguo@kernel.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn

Hey Bao,

On Wed, Jan 18, 2017 at 12:42:02PM +0800, Baoyou Xie wrote:
> This patch adds thermal driver for ZTE's zx2967 family.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

<cut>

> +
> +	/*
> +	 * Calculate temperature
> +	 *   922	initial value of calibration cure
> +	 *   1.951	slope of calibration cure
> +	 */
> +	*temp = DIV_ROUND_CLOSEST((val - 922) * 1000, 1951);

You can describe the offset and slope using DT and avoid this to be hard
coded in your driver. Besides, if you read offset and slope from DT,
your driver will be ready for any upcoming sensor addition that you may
want to support in future, given that would required slope and offset
change, per sensor, per chip version.

Can you please check if you can move these to DT?

BR,
> -- 
> 2.7.4
> 
