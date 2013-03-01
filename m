From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4 8/8] reset: Add driver for gpio-controlled reset pins
Date: Fri, 01 Mar 2013 13:13:58 -0700
Message-ID: <51310C06.2090909@wwwdotorg.org>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de> <1361878774-6382-9-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:58676 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab3CAUOE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Mar 2013 15:14:04 -0500
In-Reply-To: <1361878774-6382-9-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On 02/26/2013 04:39 AM, Philipp Zabel wrote:
> This driver implements a reset controller device that toggles gpios
> connected to reset pins of peripheral ICs. The delay between assertion
> and de-assertion of the reset signal can be configured.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
