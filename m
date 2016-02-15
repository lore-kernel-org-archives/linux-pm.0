From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor:
 Replace timers with utilization ...'
Date: Mon, 15 Feb 2016 11:46:27 -0800
Message-ID: <20160215194627.GA25882@roeck-us.net>
References: <20160215170527.GA24453@roeck-us.net>
 <56C22105.6050900@arm.com>
 <CAJZ5v0gXGzzJ7CcbgNNO-ULrtd9Z2hbqHeuXRYJLFLrh+BWVWA@mail.gmail.com>
 <1508162.Id3YElPxB2@vostro.rjw.lan>
 <20160215194227.GY19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58232 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbcBOTq3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 14:46:29 -0500
Content-Disposition: inline
In-Reply-To: <20160215194227.GY19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-next@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Mon, Feb 15, 2016 at 11:42:27AM -0800, Tony Lindgren wrote:
> * Rafael J. Wysocki <rjw@rjwysocki.net> [160215 11:28]:
> > 
> > Guenter, Tony,
> > 
> > Below is a patch to try, on top of linux-next.
> 
> Fixes the issue on UP for me:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>
> 
> > Please let me know if the problem is still around with that patch applied.
> 
> It seems we still have another issue with SMP systems, see below.
> 
Try https://patchwork.kernel.org/patch/8318221

Guenter
