From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] thermal: add imx thermal driver support
Date: Thu, 20 Jun 2013 22:08:48 +0800
Message-ID: <20130620140846.GH19896@S2101-09.ap.freescale.net>
References: <1371280241-31699-1-git-send-email-shawn.guo@linaro.org>
 <51C0C8D8.5090301@ti.com>
 <20130619073739.GA3280@S2101-09.ap.freescale.net>
 <51C1BA1A.5010704@ti.com>
 <20130620024749.GB19896@S2101-09.ap.freescale.net>
 <51C2F12B.2090205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:37586 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935370Ab3FTOIr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2013 10:08:47 -0400
Content-Disposition: inline
In-Reply-To: <51C2F12B.2090205@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

On Thu, Jun 20, 2013 at 08:10:19AM -0400, Eduardo Valentin wrote:
> Well, I think just mentioning IMX6DQRM should be ok. I didnt really mean
> you need to put a link.
> 
Ok, will mention SoC Reference Manual in there.

<snip>

> Ok. If you dont care about the overhead, it is fine, as it is your call
> to design the driver accessors. FYI, this is a nice explanation of what
> is my concern:
> http://www.spinics.net/lists/linux-omap/msg92370.html
> 
Thanks for the pointer.  As the IO access here is not on the hot path
and is only at second basis, I'm not so concerned by the overhead.

Shawn

