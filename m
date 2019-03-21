From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] PM / Domains: Avoid a potential deadlock
Date: Fri, 22 Mar 2019 00:27:33 +0100
Message-ID: <14940273.hSlFUEJerr@aspire.rjw.lan>
References: <20190312065128.24994-1-jiada_wang@mentor.com> <CAPDyKFodmgkpLkJDiMqh3vm+Ynuo852biZkY7uB5sm9UeAJ63A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFodmgkpLkJDiMqh3vm+Ynuo852biZkY7uB5sm9UeAJ63A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jiada Wang <jiada_wang@mentor.com>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 13, 2019 8:35:02 AM CET Ulf Hansson wrote:
> On Tue, 12 Mar 2019 at 07:51, Jiada Wang <jiada_wang@mentor.com> wrote:
> >
> > Lockdep warns that prepare_lock and genpd->mlock can cause a deadlock
> > the deadlock scenario is like following:
> > First thread is probing cs2000
> > cs2000_probe()
> >   clk_register()
> >     __clk_core_init()
> >       clk_prepare_lock()                            ----> acquires prepare_lock
> >         cs2000_recalc_rate()
> >           i2c_smbus_read_byte_data()
> >             rcar_i2c_master_xfer()
> >               dma_request_chan()
> >                 rcar_dmac_of_xlate()
> >                   rcar_dmac_alloc_chan_resources()
> >                     pm_runtime_get_sync()
> >                       __pm_runtime_resume()
> >                         rpm_resume()
> >                           rpm_callback()
> >                             genpd_runtime_resume()   ----> acquires genpd->mlock
> >
> > Second thread is attaching any device to the same PM domain
> > genpd_add_device()
> >   genpd_lock()                                       ----> acquires genpd->mlock
> >     cpg_mssr_attach_dev()
> >       of_clk_get_from_provider()
> >         __of_clk_get_from_provider()
> >           __clk_create_clk()
> >             clk_prepare_lock()                       ----> acquires prepare_lock
> >
> > Since currently no PM provider access genpd's critical section
> > in .attach_dev, and .detach_dev callbacks, so there is no need to protect
> > these two callbacks with genpd->mlock.
> > This patch avoids a potential deadlock by moving out .attach_dev and .detach_dev
> > from genpd->mlock, so that genpd->mlock won't be held when prepare_lock is acquired
> > in .attach_dev and .detach_dev
> 
> Thanks for the detailed description, this seems like a reasonable change to me!
> 
> >
> > Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied, thanks!
