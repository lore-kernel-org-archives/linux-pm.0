From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/2] PM / OPP : export symbol consolidation
Date: Wed, 30 Jan 2013 14:34:22 +0800
Message-ID: <20130130063420.GA24697@S2100-06.ap.freescale.net>
References: <1359397576-26131-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:16651
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751385Ab3A3GFY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jan 2013 01:05:24 -0500
Content-Disposition: inline
In-Reply-To: <1359397576-26131-1-git-send-email-nm@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Rafael <rjw@sisk.pl>, Mark Langsdorf <mark.langsdorf@calxeda.com>

On Mon, Jan 28, 2013 at 12:26:14PM -0600, Nishanth Menon wrote:
> Hi,
> This is a consolidation of Rafael's request for usage of EXPORT_SYMBOL_GPL
> and requirement for cpufreq helpers to be exported to be used by cpufreq
> drivers which may be modules.
> 
> https://patchwork.kernel.org/patch/1847261/ is patch #2 in this series.
> 
> Mark Langsdorf (1):
>   PM / OPP: Export more symbols for module usage
> 
> Nishanth Menon (1):
>   PM / OPP: switch exported symbols to GPL variant
> 
The series is needed by cpufreq-cpu0 and imx6q-cpufreq module build.
So, for both patches,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

