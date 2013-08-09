From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH] MAINTAINERS: drivers/power: add entry for SmartReflex
 AVS drivers
Date: Fri, 9 Aug 2013 11:44:10 -0700
Message-ID: <20130809184410.GA979@lizard.mcd26095.sjc.wayport.net>
References: <1375720177-20063-1-git-send-email-khilman@linaro.org>
 <20130806015147.GA16668@teo>
 <87mwoufk4l.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35955 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030353Ab3HISsr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2013 14:48:47 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so892186pdj.31
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2013 11:48:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87mwoufk4l.fsf@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Nishanth Menon <nm@ti.com>

On Tue, Aug 06, 2013 at 04:57:14PM -0700, Kevin Hilman wrote:
> Subject: [PATCH] MAINTAINERS: drivers/power: add entry for SmartReflex AVS
>  drivers
> 
> The SmartReflex AVS driver evolved out of the OMAP kernel and now
> lives under drivers/power/avs.
> 
> I've historically been maintainer of this but Nishanth Menon is doing
> most of the heavy lifting now.  Add us both as co-maintainers.
> 
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index defc053..93e9ba0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6450,6 +6450,14 @@ S:	Maintained
>  F:	include/linux/power_supply.h
>  F:	drivers/power/
>  
> +SMARTREFLEX DRIVERS FOR ADAPTIVE VOLTAGE SCALING (AVS)
> +M:	Kevin Hilman <khilman@kernel.org>
> +M:	Nishanth Menon <nm@ti.com>
> +S:	Maintained
> +F:	drivers/power/avs/smartreflex.c
> +F:	include/linux/power/smartreflex.h
> +L:	linux-pm@vger.kernel.org
> +

The file should be alphabetically sorted... I fixed it up and applied the
patch.

Thanks!

Anton

>  PNP SUPPORT
>  M:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>  M:	Bjorn Helgaas <bhelgaas@google.com>
> -- 
> 1.8.3
> 
