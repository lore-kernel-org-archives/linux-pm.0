From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / clk: export symbols for existing pm_clk_<...> API fcns
Date: Thu, 16 Jun 2016 16:04:16 +0200
Message-ID: <3160821.3V0eYIUger@vostro.rjw.lan>
References: <1465149495-22961-1-git-send-email-paul.gortmaker@windriver.com> <20160606101647.GA22028@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606101647.GA22028@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, June 06, 2016 12:16:47 PM Pavel Machek wrote:
> On Sun 2016-06-05 13:58:15, Paul Gortmaker wrote:
> > While trying to convert a DMA driver from bool to tristate, we
> > encountered the following:
> > 
> > ERROR: "pm_clk_add_clk" [drivers/dma/tegra210-adma.ko] undefined!
> > ERROR: "pm_clk_create" [drivers/dma/tegra210-adma.ko] undefined!
> > ERROR: "pm_clk_destroy" [drivers/dma/tegra210-adma.ko] undefined!
> > ERROR: "pm_clk_suspend" [drivers/dma/tegra210-adma.ko] undefined!
> > ERROR: "pm_clk_resume" [drivers/dma/tegra210-adma.ko] undefined!
> > 
> > Since in principle there is nothing preventing these functions
> > from being used in modular code as well as builtin, we add the
> > export of them.  We expand the scope to also include:
> > 
> >    pm_clk_add
> >    of_pm_clk_add_clks
> >    pm_clk_remove
> >    pm_clk_remove_clk
> >    pm_clk_init
> >    pm_clk_runtime_suspend
> >    pm_clk_runtime_resume
> >    pm_clk_add_notifier
> > 
> > ...since these functions are also non-static and presumably form
> > part of the existing API used by other drivers that may become
> > modular in the future.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks!
