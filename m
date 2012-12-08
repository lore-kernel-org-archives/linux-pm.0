From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] thermal: Add support for thermal sensor for
	Kirkwood SoC
Date: Sat, 8 Dec 2012 00:08:50 +0000
Message-ID: <20121208000850.GZ14363@n2100.arm.linux.org.uk>
References: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org> <20121207232459.GA4304@obsidianresearch.com> <20121207235904.GA15078@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56459 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab2LHAOL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Dec 2012 19:14:11 -0500
Content-Disposition: inline
In-Reply-To: <20121207235904.GA15078@obsidianresearch.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, rui.zhang@intel.com, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Fri, Dec 07, 2012 at 04:59:04PM -0700, Jason Gunthorpe wrote:
> On Fri, Dec 07, 2012 at 04:24:59PM -0700, Jason Gunthorpe wrote:
> > On Sat, Dec 08, 2012 at 08:15:50AM +0900, Nobuhiro Iwamatsu wrote:
> > > Some kirkwood SoC has thermal sensor.
> > > This patch adds support for 88F6282 and 88F6283.
> > 
> > Thanks! I was just about to write this.. Looks good here.
> 
> Ah, looking closer:
> 
> $ cat /sys/class/thermal/thermal_zone0/temp 
> 37
> 
> That should be 37000, the value out of the driver should be in
> milli-Celsius.
> 
> I'd use this equation instead:
> 
> 	*temp = ((322 - reg) * 10000 * 1000) / 13625;

Be careful of math overflows... make sure you do this calculation using
unsigned arithmetic as temperatures above 157 degress will cause this
to look like a negative number using signed math... However, that
probably won't ever be noticed because at 157 degrees, you'll definitely
be outside the operating limits of the device.
