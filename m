From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] MAINTAINERS: drivers/power: add entry for SmartReflex AVS drivers
Date: Wed, 07 Aug 2013 00:54:43 +0200
Message-ID: <2468244.h36esXYJ6h@vostro.rjw.lan>
References: <1375720159-13684-1-git-send-email-khilman@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:58504 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756728Ab3HFWo0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 6 Aug 2013 18:44:26 -0400
In-Reply-To: <1375720159-13684-1-git-send-email-khilman@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Anton Vorontsov <anton@enomsg.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Nishanth Menon <nm@ti.com>

On Monday, August 05, 2013 09:29:19 AM Kevin Hilman wrote:
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

Who's supposed to take this patch?

Rafael


> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index defc053..466ca61 100644
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
> +F:      include/linux/power/smartreflex.h
> +L:	linux-pm@vger.kernel.org
> +
>  PNP SUPPORT
>  M:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>  M:	Bjorn Helgaas <bhelgaas@google.com>
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
