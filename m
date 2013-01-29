From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4] cpufreq: add imx6q-cpufreq driver
Date: Tue, 29 Jan 2013 10:56:54 +0800
Message-ID: <20130129025652.GB11546@S2101-09.ap.freescale.net>
References: <1359214303-3319-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:27115
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753360Ab3A2C4n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jan 2013 21:56:43 -0500
Content-Disposition: inline
In-Reply-To: <1359214303-3319-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Eric Nelson <eric.nelson@boundarydevices.com>

On Sat, Jan 26, 2013 at 11:31:43PM +0800, Shawn Guo wrote:
> Add an imx6q-cpufreq driver for Freescale i.MX6Q SoC to handle the
> hardware specific frequency and voltage scaling requirements.
> 
> The driver supports module build and is instantiated by the platform
> device/driver mechanism, so that it will not be instantiated on other
> platforms, as IMX is built with multiplatform support.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Rafael,

I think the patch needs to go via cpufreq tree, as it has dependency
on Nishanth's "PM / OPP : export symbol consolidation" series.

Shawn

