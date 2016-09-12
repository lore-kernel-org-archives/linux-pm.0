From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC/RFT][PATCH v2 5/7] PM / runtime: Flag to indicate PM sleep
 transitions in progress
Date: Tue, 13 Sep 2016 00:52:53 +0200
Message-ID: <20160912225253.GA1033@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <3677187.4hCpDgWMoX@vostro.rjw.lan>
 <20160912140727.GA591@wunner.de>
 <6063056.2MKrxSTWdb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:60943 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbcILWwk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2016 18:52:40 -0400
Content-Disposition: inline
In-Reply-To: <6063056.2MKrxSTWdb@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Mon, Sep 12, 2016 at 11:25:36PM +0200, Rafael J. Wysocki wrote:
> On Monday, September 12, 2016 04:07:27 PM Lukas Wunner wrote:
> > On Thu, Sep 08, 2016 at 11:29:48PM +0200, Rafael J. Wysocki wrote:
> > > Introduce a new flag in struct dev_pm_info, pm_sleep_in_progress, to
> > > indicate that runtime PM has been disabled because of a PM sleep
> > > transition in progress.
> > [...]
> > > That will allow helpers like pm_runtime_get_sync() to be called
> > > during system sleep transitions without worrying about possible
> > > error codes they may return because runtime PM is disabled at
> > > that point.
> > 
> > I have a suspicion that this patch papers over the direct_complete bug
> > I reported Sep 10 and that the patch is unnecessary once that bug is
> > fixed.
> 
> It doesn't paper over anything, but it may not be necessary anyway.
> 
> > AFAICS, runtime PM is only disabled in two places during the system
> > sleep process: In __device_suspend() for devices using direct_complete,
> > and __device_suspend_late() for all devices.
> > 
> > In both of these phases (dpm_suspend() and dpm_suspend_late()), the
> > device tree is walked bottom-up. Since we've reordered consumers to
> > the back of dpm_list, they will be treated *before* their suppliers.
> > Thus, runtime PM is disabled on the consumers first, and only later
> > on the suppliers.
> > 
> > Then how can it be that runtime PM is already disabled on the supplier?
> 
> Actually, I think that this was a consequence of a bug in
> device_reorder_to_tail() that was present in the previous iteration
> of the patchset (it walked suppliers instead of consumers).
> 
> > The only scenario I can imagine is that the supplier chose to exercise
> > direct_complete, thus was pm_runtime_disabled() in the __device_suspend()
> > phase, and the consumer did *not* choose to exercise direct_complete and
> > later tried to runtime resume its suppliers and itself.
> > 
> > I assume this patch is a replacement for Marek's [v2 08/10].
> > @Marek, does this scenario match with what you witnessed?
> 
> It is not strictly a replacement for it.  The Marek's patch was the
> reason to post it, but I started to think about this earlier.
> 
> Some people have complained to me about having to deal with error codes
> returned by the runtime PM framework during system suspend, so I thought
> it might be useful to deal with that too.
> 
> That said it probably is not necessary right now.

Understood, thanks for providing this context which was unknown to me.

I'm wondering if it's necessary to introduce a new "pm_sleep_in_progress"
flag. We've already got "is_prepared", "is_suspended", "is_late_suspended",
"is_noirq_suspended", so we should have a pretty good idea of the fact
that the device is going to sleep and which stage it's in.

E.g. (dev->power.direct_complete || dev->power.is_suspended) covers a bit
more than the time frame when runtime PM is disabled for system sleep,
but might perhaps still suffice as a proxy.

Should a new flag be unavoidable, setting it directly in
__device_suspend_late(), device_resume_early(), __device_suspend()
and device_resume() would result in a smaller patch. (E.g. you
wouldn't have to modify the prototype of pm_runtime_enable().)

Thanks,

Lukas
