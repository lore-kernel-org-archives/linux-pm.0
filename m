From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [RFC PATCH 0/6] Thermal: step_wise governor fixes
Date: Tue, 18 Jun 2013 11:45:05 +0800
Message-ID: <20130618034502.GE28381@S2101-09.ap.freescale.net>
References: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:46540
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753803Ab3FRDoG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2013 23:44:06 -0400
Content-Disposition: inline
In-Reply-To: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, durgadoss.r@intel.com, ruslan.ruslichenko@ti.com

On Mon, Jun 17, 2013 at 09:24:22PM +0800, Zhang Rui wrote:
> Hi, all,
> 
> There are a lot of step_wise governor problems reported recently,
> and plus, there are already several patches avaible, but I'd like to do
> a cleanup for this piece of code altogether.
> 
> This patch set fixes several problem as addressed in the description
> of each patch.
> Please kindly review.
> 
> Note: I just run build test. It would be great that some of you
> can test it.

The series works fine on imx6q with the patch "thermal: add imx thermal
driver support" I submitted a few days ago, so for the series,

Tested-by: Shawn Guo <shawn.guo@linaro.org>

