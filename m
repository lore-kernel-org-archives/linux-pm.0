From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 2/2] iommu/exynos: Add proper runtime pm support
Date: Thu, 10 Nov 2016 01:36:29 +0100
Message-ID: <CAJZ5v0iEZNsjzb4sxzG39UzNYuiqQErD5diE7WmdBKqQM9_S1g@mail.gmail.com>
References: <1475136751-31340-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20160929081240eucas1p231c1ab5c5936886cbec6bc3f5267c940@eucas1p2.samsung.com>
 <1475136751-31340-3-git-send-email-m.szyprowski@samsung.com>
 <20161006173756.GK3296@wotan.suse.de> <87aeb58b-bda0-93c5-e51d-ab9be0b9d518@samsung.com>
 <20161108221437.GC13978@wotan.suse.de> <9cf5829a-baac-9297-b231-17212d0195b1@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9cf5829a-baac-9297-b231-17212d0195b1@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lar
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 9, 2016 at 4:07 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi Luis,
>
>
> On 2016-11-08 23:14, Luis R. Rodriguez wrote:
>>
>> On Mon, Oct 10, 2016 at 03:32:06PM +0200, Marek Szyprowski wrote:
>>>
>>> Hi Luis
>>>
>>>
>>> On 2016-10-06 19:37, Luis R. Rodriguez wrote:
>>>>
>>>> On Thu, Sep 29, 2016 at 10:12:31AM +0200, Marek Szyprowski wrote:
>>>>>
>>>>> This patch uses recently introduced device links to track the runtime
>>>>> pm
>>>>> state of the master's device. This way each SYSMMU controller is
>>>>> runtime
>>>>> activated when its master's device is active
>>>>
>>>> instead of?
>>>
>>> instead of keeping SYSMMU controller runtime active all the time.
>>
>> I thought Rafael's work was for suspend/resume, not for runtime suspend.
>> Is it for both ?
>
>
> Yes, it solves both problems, although the suspend/resume was easy to
> workaround just by using LATE_SLEEP_OPS.

Right, but that's just in this particular case, because the dependency
chain is of length 2. :-)

If you had a longer chain, you might in theory use  the _noirq() stage
somehow, but that has limitations.

>> Because as far as I can tell this was painted to help
>> with suspend/resume ?

It helps with three things, (async) suspend/resume, runtime PM and
shutdown (that last part is the hardest to figure out).  The ordering
in which all of these are carried out is analogous and cannot be
determined correctly by the device registration ordering itself in
general (which has been a known fact for years, but some localized
workarounds were put in some places to work around that).

Moreover, even if the list ordering (of dpm_list, for instance) is
correct, it still doesn't guarantee the right ordering of actions that
are carried out asynchronously.  They are all started in the list
order, but they may be running in parallel with each other and
complete at different times.  For this reason, there needs to be a way
to ensure that, say, the suspend operations for consumer devices
complete before their suppliers will become unavailable and so on.

Both runtime PM and system suspend/resume have this problem.  It is
not present in the system shutdown case, but it still helps to get a
correct list ordering (ie. such that won't cause supplier devices to
be shut down before their consumers) in this case too.

Thanks,
Rafael
