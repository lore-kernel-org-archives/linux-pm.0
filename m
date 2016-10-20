From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 0/5] Functional dependencies between devices
Date: Thu, 20 Oct 2016 14:54:56 +0200
Message-ID: <CAJZ5v0ivT5eAPvg_NWtU+o0GrghwJMEdvPiLxt8m3C6BU5=nrw@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <CGME20161010125153eucas1p2b86325c046d3e0d0b6275abd000ea096@eucas1p2.samsung.com>
 <13957403.ZrB4mMbICz@vostro.rjw.lan> <ef96a88b-240e-17b1-904d-b7a778a999ec@samsung.com>
 <CAJZ5v0iKww_kFSWHoXC30B=f_9s8Cn1t9Y8G23ZPT4F3-ew+xg@mail.gmail.com> <a49cc8aa-84fe-5752-efdc-113a116e588d@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a49cc8aa-84fe-5752-efdc-113a116e588d@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Oct 20, 2016 at 12:21 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi Rafael,
>
>
> On 2016-10-19 13:57, Rafael J. Wysocki wrote:
>>
>> On Tue, Oct 18, 2016 at 12:46 PM, Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>>
>>> On 2016-10-10 14:36, Rafael J. Wysocki wrote:
>>>>
>>>> [...]
>>>>
>>>> One more update after some conversations during LinuxCon Europe.
>>>>
>>>> The main point was to make it possible for device_link_add() to figure
>>>> out
>>>> the
>>>> initial state of the link instead of expecting the caller to provide it
>>>> which
>>>> might not be reliable enough in general.
>>>>
>>>> In this version device_link_add() takes three arguments, the supplier
>>>> and
>>>> consumer pointers and flags and it sets the correct initial state of the
>>>> link
>>>> automatically (unless invoked with the "stateless" flag, of course).
>>>> The
>>>> cost
>>>> is one additional field in struct device (I moved all of the
>>>> links-related
>>>> fields in struct device to a separate sub-structure while at it) to
>>>> track
>>>> the "driver presence status" of the device (to be used by
>>>> device_link_add()).
>>>>
>>>> In addition to that, the links list walks in the core.c and dd.c code
>>>> are
>>>> under the device links mutex now, so the iternal link spinlock is not
>>>> needed
>>>> any more and I have renamed symbols to distinguish between flags, link
>>>> states
>>>> and device "driver presence statuses".
>>>>
>>>> More information is there in the changelogs.
>>>
>>> Thanks for the update. This version is indeed easier to use and still
>>> works
>>> fine
>>> with my Exynos IOMMU runtime pm rework. You can keep my:
>>>
>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>
>>> I will send updated version of my patchset soon.
>>
>> Thanks for the testing, much appreciated!
>>
>> The series is in a new branch called "device-links-test" in my tree now:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>> device-links-test
>
>
> While working on integrating IOMMU deferred probing patches I found a bug,
> which has been introduced in v4 of device dependency patchset (v3 worked
> fine in this area, v5 also contains this bug). The following fixup is
> needed to properly create links with DL_FLAG_PM_RUNTIME flag set during
> consumer device probing:
>
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> Date: Thu, 20 Oct 2016 12:12:14 +0200
> Subject: [PATCH] driver core: fix runtime pm state for
>  DEVICE_LINK_CONSUMER_PROBE links
>
> If link is added during consumer probe with DL_FLAG_PM_RUNTIME flag set,
> the code will do additional pm_runtime_put() on the supplier after
> finishing consumer probing. This will break runtime pm operation for
> the supplier device. To solve this issue, enforce additional call to
> pm_runtime_get_sync() on the supplier device while creating such link.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/base/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 48bc5a362f7d..d4cc285a1df7 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -217,6 +217,9 @@ struct device_link *device_link_add(struct device
> *consumer,
>          }
>      }
>
> +    if (flags & DL_FLAG_PM_RUNTIME && status == DL_STATE_CONSUMER_PROBE)
> +        pm_runtime_get_sync(supplier);
> +

Good catch!

I'd prefer to do this slightly differently, though, so I'll send an
update of the runtime PM patch with this folded in shortly.

Thanks,
Rafael
