From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 6/6 v6] cpufreq, highbank: add support for highbank
 cpufreq
Date: Wed, 28 Nov 2012 23:17:44 +0800
Message-ID: <20121128151741.GC28170@S2100-06.ap.freescale.net>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354046672-7392-7-git-send-email-mark.langsdorf@calxeda.com>
 <20121128023240.GA28170@S2100-06.ap.freescale.net>
 <50B60E9C.9000405@calxeda.com>
 <20121128145759.GB28170@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:54157
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753233Ab2K1Owz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Nov 2012 09:52:55 -0500
Content-Disposition: inline
In-Reply-To: <20121128145759.GB28170@S2100-06.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Wed, Nov 28, 2012 at 10:58:02PM +0800, Shawn Guo wrote:
> On Wed, Nov 28, 2012 at 07:16:12AM -0600, Mark Langsdorf wrote:
> > I'd
> > have to move most of the logic of hb_set_target() into
> > clk_highbank.c:clk_pll_set_rate() and then add extra logic for when
> > cpufreq is not enabled/loaded.
> 
> You only need to move hb_voltage_change() into cpu clock's .set_rate()
> hook with no need of checking if cpufreq is enabled or not.
> 
Need to also check whether frequency or voltage should be changed first
in .set_rate() though.

Shawn

