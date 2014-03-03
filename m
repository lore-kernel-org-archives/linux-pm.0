From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] Thermal: thermal zone governor fix
Date: Mon, 3 Mar 2014 10:00:37 +0000
Message-ID: <20140303100035.GA3576@e102654-lin.cambridge.arm.com>
References: <1393825573.2199.3.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:49418 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbaCCKAn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Mar 2014 05:00:43 -0500
In-Reply-To: <1393825573.2199.3.camel@rzhang1-mobl4>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, eduardo <eduardo.valentin@ti.com>, "wni@nvidia.com" <wni@nvidia.com>

Hi Rui,

On Mon, Mar 03, 2014 at 05:46:13AM +0000, Zhang Rui wrote:
> From 635a1f41a8f95a35d1bf24c9cc018ffb018a93e6 Mon Sep 17 00:00:00 2001
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
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

This solves my issue.  You can add my Acked-by.

I was a bit worried about dereferencing def_governor in
handle_non_critical_trips() without checking if it's initialised.  I
guess that all the thermal zones initialise in device_initcall or
later so by the time they run thermal_zone_device_update(),
thermal_register_governors() must have initialised the default
governor.  So it's not an issue.

Thanks,
Javi

