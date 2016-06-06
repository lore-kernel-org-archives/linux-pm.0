From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / clk: export symbols for existing pm_clk_<...> API
 fcns
Date: Mon, 6 Jun 2016 12:16:47 +0200
Message-ID: <20160606101647.GA22028@amd>
References: <1465149495-22961-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:32843 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbcFFKQv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2016 06:16:51 -0400
Content-Disposition: inline
In-Reply-To: <1465149495-22961-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org

On Sun 2016-06-05 13:58:15, Paul Gortmaker wrote:
> While trying to convert a DMA driver from bool to tristate, we
> encountered the following:
> 
> ERROR: "pm_clk_add_clk" [drivers/dma/tegra210-adma.ko] undefined!
> ERROR: "pm_clk_create" [drivers/dma/tegra210-adma.ko] undefined!
> ERROR: "pm_clk_destroy" [drivers/dma/tegra210-adma.ko] undefined!
> ERROR: "pm_clk_suspend" [drivers/dma/tegra210-adma.ko] undefined!
> ERROR: "pm_clk_resume" [drivers/dma/tegra210-adma.ko] undefined!
> 
> Since in principle there is nothing preventing these functions
> from being used in modular code as well as builtin, we add the
> export of them.  We expand the scope to also include:
> 
>    pm_clk_add
>    of_pm_clk_add_clks
>    pm_clk_remove
>    pm_clk_remove_clk
>    pm_clk_init
>    pm_clk_runtime_suspend
>    pm_clk_runtime_resume
>    pm_clk_add_notifier
> 
> ...since these functions are also non-static and presumably form
> part of the existing API used by other drivers that may become
> modular in the future.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
