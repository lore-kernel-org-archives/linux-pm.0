From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v8 3/3] dmaengine: pl330: Don't require irq-safe runtime PM
Date: Tue, 14 Feb 2017 08:50:43 +0100
Message-ID: <ea75ca9a-efc0-2d47-d6ef-fd32e675db49@samsung.com>
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
 <20170213154727.GN2843@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20170213154727.GN2843@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, dmaengine@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Vinod,


On 2017-02-13 16:47, Vinod Koul wrote:
> On Mon, Feb 13, 2017 at 04:32:32PM +0100, Ulf Hansson wrote:
>> [...]
>>
>>>> Although, I don't know of other examples, besides the runtime PM use
>>>> case, where non-atomic channel prepare/unprepare would make sense. Do
>>>> you?
>>> The primary ask for that has been to enable runtime_pm for drivers. It's not
>>> a new ask, but we somehow haven't gotten around to do it.
>> Okay, I see.
>>
>>>>> As I said earlier, if we want to solve that problem a better idea is to
>>>>> actually split the prepare as we discussed in [1]
>>>>>
>>>>> This way we can get a non atomic descriptor allocate/prepare and release.
>>>>> Yes we need to redesign the APIs to solve this, but if you guys are up for
>>>>> it, I think we can do it and avoid any further round abouts :)
>>>> Adding/re-designing dma APIs is a viable option to solve the runtime PM case.
>>>>
>>>> Changes would be needed for all related dma client drivers as well,
>>>> although if that's what we need to do - let's do it.
>>> Yes, but do bear in mind that some cases do need atomic prepare. The primary
>>> cases for DMA had that in mind and also submitting next transaction from the
>>> callback (tasklet) context, so that won't go away.
>>>
>>> It would help in other cases where clients know that they will not be in
>>> atomic context so we provide additional non-atomic "allocation" followed by
>>> prepare, so that drivers can split the work among these and people can do
>>> runtime_pm and other things..
>> That for sharing the details.
>>
>> It seems like some dma expert really need to be heavily involved if we
>> ever are going to complete this work. :-)
> Sure, I will help out :)
>
> If anyone of you are in Portland next week, then we can discuss these f2f. I
> will try taking a stab at the new API design next week.

I'm not going to Portland, but I hope that you will have a fruitful 
discussion
there.

[...]

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
