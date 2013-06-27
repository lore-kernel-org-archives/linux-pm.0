From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4] thermal: add imx thermal driver support
Date: Thu, 27 Jun 2013 09:15:31 +0800
Message-ID: <20130627011529.GA3942@shlinux1.ap.freescale.net>
References: <1372055444-5286-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:52670
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751460Ab3F0C4K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 22:56:10 -0400
Content-Disposition: inline
In-Reply-To: <1372055444-5286-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, Jun 24, 2013 at 02:30:44PM +0800, Shawn Guo wrote:
> This is based on the initial imx thermal work done by
> Rob Lee <rob.lee@linaro.org> (Not sure if the email address is still
> valid).  Since he is no longer interested in the work and I have
> rewritten a significant amount of the code, I just took the authorship
> over from him.
> 
> It adds the imx thermal support using Temperature Monitor (TEMPMON)
> block found on some Freescale i.MX SoCs.  The driver uses syscon regmap
> interface to access TEMPMON control registers and calibration data, and
> supports cpufreq as the cooling device.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Rui,

Can this patch be applied for 3.11?

Shawn

