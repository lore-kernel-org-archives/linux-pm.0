From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v8 3/3] dmaengine: pl330: Don't require irq-safe runtime PM
Date: Mon, 13 Feb 2017 21:17:27 +0530
Message-ID: <20170213154727.GN2843@localhost>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142309eucas1p2b1277d96139eafc0d1dcc14145600476@eucas1p2.samsung.com>
 <1486650171-20598-4-git-send-email-m.szyprowski@samsung.com>
 <20170210045004.GN19244@localhost>
 <d299ae6c-78dc-9049-6bed-dc84fff17db3@samsung.com>
 <CAPDyKFqW2av1mjDvRP=R1my2kepeX69TS6cchzoHmwaoydT5Sg@mail.gmail.com>
 <20170213020340.GH2843@localhost>
 <CAPDyKFpt9O8GM-7xeNJ8bF0JqUJ7nPaRmmC+aMVsdMH-yWBCNg@mail.gmail.com>
 <20170213122742.GL2843@localhost>
 <CAPDyKFqnmhps5nhj-exZ0rnmkwdeD+iuz3CH7btjvxoJaZtVDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqnmhps5nhj-exZ0rnmkwdeD+iuz3CH7btjvxoJaZtVDg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 13, 2017 at 04:32:32PM +0100, Ulf Hansson wrote:
> [...]
> 
> >> Although, I don't know of other examples, besides the runtime PM use
> >> case, where non-atomic channel prepare/unprepare would make sense. Do
> >> you?
> >
> > The primary ask for that has been to enable runtime_pm for drivers. It's not
> > a new ask, but we somehow haven't gotten around to do it.
> 
> Okay, I see.
> 
> >
> >> > As I said earlier, if we want to solve that problem a better idea is to
> >> > actually split the prepare as we discussed in [1]
> >> >
> >> > This way we can get a non atomic descriptor allocate/prepare and release.
> >> > Yes we need to redesign the APIs to solve this, but if you guys are up for
> >> > it, I think we can do it and avoid any further round abouts :)
> >>
> >> Adding/re-designing dma APIs is a viable option to solve the runtime PM case.
> >>
> >> Changes would be needed for all related dma client drivers as well,
> >> although if that's what we need to do - let's do it.
> >
> > Yes, but do bear in mind that some cases do need atomic prepare. The primary
> > cases for DMA had that in mind and also submitting next transaction from the
> > callback (tasklet) context, so that won't go away.
> >
> > It would help in other cases where clients know that they will not be in
> > atomic context so we provide additional non-atomic "allocation" followed by
> > prepare, so that drivers can split the work among these and people can do
> > runtime_pm and other things..
> 
> That for sharing the details.
> 
> It seems like some dma expert really need to be heavily involved if we
> ever are going to complete this work. :-)

Sure, I will help out :)

If anyone of you are in Portland next week, then we can discuss these f2f. I
will try taking a stab at the new API design next week.

> 
> [...]
> 
> >>
> >> 1) Dependencies between dma drivers and dma client drivers during system
> >> PM. For example, a dma client driver needs the dma controller to be
> >> operational (remain system resumed), until the dma client driver itself
> >> becomes system suspended.
> >>
> >> The *only* currently available solution for this, is to try to system
> >> suspend the dma controller later than the dma client, via using the *late
> >> or the *noirq system PM callbacks. This works for most cases, but it
> >> becomes a problem when the dma client also needs to be system suspended at
> >> the *late or the *noirq phase. Clearly this solution that doesn't scale.
> >>
> >> Using device links explicitly solves this problem as it allows to specify
> >> this dependency between devices.
> >
> > Yes this is an interesting point. Yes till now people have been doing above
> > to workaround this problem, but hey this is not a unique to dmaengine. Any
> > subsystem which provides services to others has this issue, so the solution
> > much be driver or pm framework and not unique to dmaengine.
> 
> I definitely agree, these problems aren't unique to the dmaengine
> subsystem. Exactly how/where to manage them, that I guess, is the key
> question.
> 
> However, I can't resist from finding the device links useful, as those
> really do address and solve our issues from a runtime/system PM point
> of view.
> 
> >
> >> 2) We won't avoid dma clients from getting -EPROBE_DEFER when requesting
> >> their dma channels in their ->probe() routines. This would be possible, if
> >> we can set up the device links at device initialization.
> >
> > Well setting those links is not practical at initialization time. Most
> > modern dma controllers feature a SW mux, with multiple clients connecting
> > and requesting, would we link all of them? Most of times dmaengine driver
> > wont know about those..
> 
> Okay, I see!
> 
> Kind regards
> Uffe

-- 
~Vinod
