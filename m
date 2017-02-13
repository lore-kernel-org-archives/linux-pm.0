From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v8 3/3] dmaengine: pl330: Don't require irq-safe runtime PM
Date: Mon, 13 Feb 2017 16:32:32 +0100
Message-ID: <CAPDyKFqnmhps5nhj-exZ0rnmkwdeD+iuz3CH7btjvxoJaZtVDg@mail.gmail.com>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142309eucas1p2b1277d96139eafc0d1dcc14145600476@eucas1p2.samsung.com>
 <1486650171-20598-4-git-send-email-m.szyprowski@samsung.com>
 <20170210045004.GN19244@localhost> <d299ae6c-78dc-9049-6bed-dc84fff17db3@samsung.com>
 <CAPDyKFqW2av1mjDvRP=R1my2kepeX69TS6cchzoHmwaoydT5Sg@mail.gmail.com>
 <20170213020340.GH2843@localhost> <CAPDyKFpt9O8GM-7xeNJ8bF0JqUJ7nPaRmmC+aMVsdMH-yWBCNg@mail.gmail.com>
 <20170213122742.GL2843@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170213122742.GL2843@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, dmaengine@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

[...]

>> Although, I don't know of other examples, besides the runtime PM use
>> case, where non-atomic channel prepare/unprepare would make sense. Do
>> you?
>
> The primary ask for that has been to enable runtime_pm for drivers. It's not
> a new ask, but we somehow haven't gotten around to do it.

Okay, I see.

>
>> > As I said earlier, if we want to solve that problem a better idea is to
>> > actually split the prepare as we discussed in [1]
>> >
>> > This way we can get a non atomic descriptor allocate/prepare and release.
>> > Yes we need to redesign the APIs to solve this, but if you guys are up for
>> > it, I think we can do it and avoid any further round abouts :)
>>
>> Adding/re-designing dma APIs is a viable option to solve the runtime PM case.
>>
>> Changes would be needed for all related dma client drivers as well,
>> although if that's what we need to do - let's do it.
>
> Yes, but do bear in mind that some cases do need atomic prepare. The primary
> cases for DMA had that in mind and also submitting next transaction from the
> callback (tasklet) context, so that won't go away.
>
> It would help in other cases where clients know that they will not be in
> atomic context so we provide additional non-atomic "allocation" followed by
> prepare, so that drivers can split the work among these and people can do
> runtime_pm and other things..

That for sharing the details.

It seems like some dma expert really need to be heavily involved if we
ever are going to complete this work. :-)

[...]

>>
>> 1) Dependencies between dma drivers and dma client drivers during system
>> PM. For example, a dma client driver needs the dma controller to be
>> operational (remain system resumed), until the dma client driver itself
>> becomes system suspended.
>>
>> The *only* currently available solution for this, is to try to system
>> suspend the dma controller later than the dma client, via using the *late
>> or the *noirq system PM callbacks. This works for most cases, but it
>> becomes a problem when the dma client also needs to be system suspended at
>> the *late or the *noirq phase. Clearly this solution that doesn't scale.
>>
>> Using device links explicitly solves this problem as it allows to specify
>> this dependency between devices.
>
> Yes this is an interesting point. Yes till now people have been doing above
> to workaround this problem, but hey this is not a unique to dmaengine. Any
> subsystem which provides services to others has this issue, so the solution
> much be driver or pm framework and not unique to dmaengine.

I definitely agree, these problems aren't unique to the dmaengine
subsystem. Exactly how/where to manage them, that I guess, is the key
question.

However, I can't resist from finding the device links useful, as those
really do address and solve our issues from a runtime/system PM point
of view.

>
>> 2) We won't avoid dma clients from getting -EPROBE_DEFER when requesting
>> their dma channels in their ->probe() routines. This would be possible, if
>> we can set up the device links at device initialization.
>
> Well setting those links is not practical at initialization time. Most
> modern dma controllers feature a SW mux, with multiple clients connecting
> and requesting, would we link all of them? Most of times dmaengine driver
> wont know about those..

Okay, I see!

Kind regards
Uffe
