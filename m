From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v2 5/7] PM / runtime: Flag to indicate PM sleep transitions in progress
Date: Wed, 14 Sep 2016 01:59:41 +0200
Message-ID: <3066752.zjH0tZW1Ns@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <6063056.2MKrxSTWdb@vostro.rjw.lan> <ca933135-5d87-8813-f1cc-ac3bd0443aff@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ca933135-5d87-8813-f1cc-ac3bd0443aff@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Lukas Wunner <lukas@wunner.de>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 13, 2016 09:21:23 AM Marek Szyprowski wrote:
> Hi Rafael,
> 
> 
> On 2016-09-12 23:25, Rafael J. Wysocki wrote:
> > On Monday, September 12, 2016 04:07:27 PM Lukas Wunner wrote:
> >> On Thu, Sep 08, 2016 at 11:29:48PM +0200, Rafael J. Wysocki wrote:
> >>> Introduce a new flag in struct dev_pm_info, pm_sleep_in_progress, to
> >>> indicate that runtime PM has been disabled because of a PM sleep
> >>> transition in progress.
> >> [...]
> >>> That will allow helpers like pm_runtime_get_sync() to be called
> >>> during system sleep transitions without worrying about possible
> >>> error codes they may return because runtime PM is disabled at
> >>> that point.
> >> I have a suspicion that this patch papers over the direct_complete bug
> >> I reported Sep 10 and that the patch is unnecessary once that bug is
> >> fixed.
> > It doesn't paper over anything, but it may not be necessary anyway.
> >
> >> AFAICS, runtime PM is only disabled in two places during the system
> >> sleep process: In __device_suspend() for devices using direct_complete,
> >> and __device_suspend_late() for all devices.
> >>
> >> In both of these phases (dpm_suspend() and dpm_suspend_late()), the
> >> device tree is walked bottom-up. Since we've reordered consumers to
> >> the back of dpm_list, they will be treated *before* their suppliers.
> >> Thus, runtime PM is disabled on the consumers first, and only later
> >> on the suppliers.
> >>
> >> Then how can it be that runtime PM is already disabled on the supplier?
> > Actually, I think that this was a consequence of a bug in device_reorder_to_tail()
> > that was present in the previous iteration of the patchset (it walked suppliers
> > instead of consumers).
> >
> >> The only scenario I can imagine is that the supplier chose to exercise
> >> direct_complete, thus was pm_runtime_disabled() in the __device_suspend()
> >> phase, and the consumer did *not* choose to exercise direct_complete and
> >> later tried to runtime resume its suppliers and itself.
> >>
> >> I assume this patch is a replacement for Marek's [v2 08/10].
> >> @Marek, does this scenario match with what you witnessed?
> > It is not strictly a replacement for it.  The Marek's patch was the
> > reason to post it, but I started to think about this earlier.
> >
> > Some people have complained to me about having to deal with error codes
> > returned by the runtime PM framework during system suspend, so I thought
> > it might be useful to deal with that too.
> >
> > That said it probably is not necessary right now.
> 
> I've tested this patchset without this patch and system sleep with 
> device link
> enabled worked fine. However this might be also a consequence of 
> enabling runtime
> pm during system sleep since v4.8-rc1.
> 
> It looks that for now this patch can be skipped until a real use case for it
> appears.

OK, thanks!
