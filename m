From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] Thermal: thermal zone governor fix
Date: Thu, 27 Feb 2014 13:41:22 +0000
Message-ID: <20140227134122.GA4417@e102654-lin.cambridge.arm.com>
References: <1393483276.2637.7.camel@rzhang1-mobl4>
 <1393483668.2637.12.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:46806 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbaB0Nl1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 08:41:27 -0500
In-Reply-To: <1393483668.2637.12.camel@rzhang1-mobl4>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, eduardo <eduardo.valentin@ti.com>, "wni@nvidia.com" <wni@nvidia.com>

Hi Rui,

On Thu, Feb 27, 2014 at 06:47:48AM +0000, Zhang Rui wrote:
> On Thu, 2014-02-27 at 14:41 +0800, Zhang Rui wrote:
> > From cd587add3043ed7bf3347e5d956f65ec8adf04cf Mon Sep 17 00:00:00 2001
> > From: Zhang Rui <rui.zhang@intel.com>
> > Date: Fri, 24 Jan 2014 10:23:19 +0800
> > Subject: [PATCH] Thermal: thermal zone governor fix
> 
> oops. forgot to attach the updated version.
> 
> thanks,
> rui
> 
> From dff1b207825609e73c7722bc79dda0ea29974931 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Fri, 24 Jan 2014 10:23:19 +0800
> Subject: [PATCH] Thermal: thermal zone governor fix
> 
> This patch does a cleanup about the thermal zone govenor,
> setting and make the following rule.
> 1. For thermal zone devices that are registered w/o tz->tzp,
>    they can use the default thermal governor only.
> 2. For thermal zone devices w/ governor name specified in
>    tz->tzp->governor_name, we will use the default govenor
>    if the governor specified is not available at the moment,
>    and update tz->governor when the matched governor is registered.

Right, but this doesn't solve my problem.  What I was trying to say
was that we should get the default governor if tz->tzp->governor_name
is not initialized.  of_parse_thermal_zones() calls
thermal_zone_device_register() with a tzp that has an empty
governor_name and ends up with no governor.

I'll send a patch that gets you the default governor if you don't
specify a governor_name in tzp and add your patch on top.

Cheers,
Javi

