From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/7] thermal: rcar: add interrupt and DT support
Date: Wed, 06 Feb 2013 13:48:17 +0800
Message-ID: <1360129697.2982.29.camel@rzhang1-mobl4>
References: <87y5f9pvxv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13046 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab3BFFsV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Feb 2013 00:48:21 -0500
In-Reply-To: <87y5f9pvxv.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On Thu, 2013-01-31 at 01:02 -0800, Kuninori Morimoto wrote:
> Hi Zhang
> 
> These patches add interrupt and DT support to R-Car thermal sensor driver.
> There are 2 versions of R-Car thermal sensor (old/new),
> but the interrupt methods were different.
> 
> This patch adds interrupt support for NEW generation chip only,
> since the OLD generation interrupt controller had never been used before,
> and will never be used in the future.
> 
> But this driver is still keeping compatible for Old generation sensor without interrupt support
> 
> Kuninori Morimoto (7):
>       thermal: rcar: use parenthesis on macro
>       thermal: rcar: enable CPCTL to use hardware TSC deciding
>       thermal: rcar: use mutex lock instead of spin lock
>       thermal: rcar: multi channel support
>       thermal: rcar: add read/write functions for common/priv data
>       thermal: rcar: add interrupt support
>       thermal: rcar: add Device Tree support
> 
patch 1~6, and patch 8 applied to thermal -next.

thanks,
rui
>  .../devicetree/bindings/thermal/rcar-thermal.txt   |   29 ++
>  drivers/thermal/rcar_thermal.c                     |  437 ++++++++++++++------
>  2 files changed, 341 insertions(+), 125 deletions(-)


