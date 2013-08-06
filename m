From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH] MAINTAINERS: drivers/power: add entry for SmartReflex
 AVS drivers
Date: Mon, 5 Aug 2013 18:51:48 -0700
Message-ID: <20130806015147.GA16668@teo>
References: <1375720177-20063-1-git-send-email-khilman@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1375720177-20063-1-git-send-email-khilman@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 05, 2013 at 09:29:37AM -0700, Kevin Hilman wrote:
> The SmartReflex AVS driver evolved out of the OMAP kernel and now
> lives under drivers/power/avs.
> 
> I've historically been maintainer of this but Nishanth Menon is doing
> most of the heavy lifting now.  Add us both as co-maintainers.
> 
...
> +M:	Kevin Hilman <khilman@kernel.org>
> +M:	Nishanth Menon <nm@ti.com>
> +S:	Maintained
> +F:	drivers/power/avs/smartreflex.c
> +F:      include/linux/power/smartreflex.h

This line is borken (whitespaces).

> +L:	linux-pm@vger.kernel.org
> +
>  PNP SUPPORT
>  M:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>  M:	Bjorn Helgaas <bhelgaas@google.com>
> -- 
> 1.8.3
