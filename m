From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH 1/2] thermal: Add support for thermal sensor for Kirkwood
 SoC
Date: Fri, 7 Dec 2012 16:59:04 -0700
Message-ID: <20121207235904.GA15078@obsidianresearch.com>
References: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
 <20121207232459.GA4304@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:53992 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892Ab2LGX7H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 7 Dec 2012 18:59:07 -0500
Content-Disposition: inline
In-Reply-To: <20121207232459.GA4304@obsidianresearch.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org

On Fri, Dec 07, 2012 at 04:24:59PM -0700, Jason Gunthorpe wrote:
> On Sat, Dec 08, 2012 at 08:15:50AM +0900, Nobuhiro Iwamatsu wrote:
> > Some kirkwood SoC has thermal sensor.
> > This patch adds support for 88F6282 and 88F6283.
> 
> Thanks! I was just about to write this.. Looks good here.

Ah, looking closer:

$ cat /sys/class/thermal/thermal_zone0/temp 
37

That should be 37000, the value out of the driver should be in
milli-Celsius.

I'd use this equation instead:

	*temp = ((322 - reg) * 10000 * 1000) / 13625;

Regards,
Jason
