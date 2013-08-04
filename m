From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] thermal: imx: dynamic passive and SoC specific
 critical trip points
Date: Sun, 4 Aug 2013 22:20:59 +0800
Message-ID: <20130804142057.GI18119@S2101-09.ap.freescale.net>
References: <1375374792-32326-1-git-send-email-p.zabel@pengutronix.de>
 <1375374792-32326-2-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:33856
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753058Ab3HDOUI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 4 Aug 2013 10:20:08 -0400
Content-Disposition: inline
In-Reply-To: <1375374792-32326-2-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, kernel@pengutronix.de

On Thu, Aug 01, 2013 at 06:33:11PM +0200, Philipp Zabel wrote:
> Set passive and critical trip point values depending on the maximum die
> temperature stored in the OCOTP fuses. This allows higher trip points
> for industrial and automotive rated i.MX6 SoCs.
> Also allow to configure the passive trip point from userspace.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

