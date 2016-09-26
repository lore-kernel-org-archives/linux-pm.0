From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 0/2] Exynos IOMMU: proper runtime PM support (use device
 dependencies)
Date: Mon, 26 Sep 2016 10:15:24 +0200
Message-ID: <3c1016f0-fa8d-0874-adfc-4cb9cfad3f02@samsung.com>
References: <CGME20160913124917eucas1p23425d2cb1c24e73ae3c2927ec141fd30@eucas1p2.samsung.com>
 <6114649.EDczdxzVVo@vostro.rjw.lan> <20160923135002.GB4077@wunner.de>
 <1514800.L7P1tHiLfo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:61803 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757713AbcIZIPb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2016 04:15:31 -0400
In-reply-to: <1514800.L7P1tHiLfo@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mark Brown <broonie@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Kevin Hilman <khilman@kernel.org>

Hi Rafael,


On 2016-09-24 03:25, Rafael J. Wysocki wrote:
> On Friday, September 23, 2016 03:50:02 PM Lukas Wunner wrote:
>> On Fri, Sep 23, 2016 at 02:49:20PM +0200, Rafael J. Wysocki wrote:
>>> On Tuesday, September 20, 2016 10:51:13 AM Marek Szyprowski wrote:
>>>> On 2016-09-19 23:45, Tobias Jakobi wrote:
>>>>> I did some tests with the new version today. Sadly the reboot/shutdown
>>>>> issues are still present.
>>>> Thanks for the report. I've managed to reproduce this issue and it is again
>>>> caused by modifying device on devices_kset list before it will be finally
>>>> added by device_add(). I thought that the new patchset allows creating
>>>> links to a device, which has not been yet added to system device list.
>> Hm, Marek, why isn't it possible to set up the links from the consumer's
>> ->probe hook in this case?

Because consumers are unaware of the IOMMU presence, so they are also 
unaware
of the links that have to be created.

>>>> Should it be allowed to create a link to device, which
>>>> has not yet been added to system device list by device_add()?
>>> While it would be easy to require both the consumer and producer devices to
>>> be registered for creating a link between them, that would just make it
>>> harder to use links in the first place.
>>>
>>> So ideally, it should be possible to create links between devices before
>>> registering them, but since I didn't take that into account in the current
>>> patch series, some quite substantial changes are needed to cover that.
>>>
>>> Additional link states come to mind, but then the "stateless" links are
>>> affected by this problem too.
>> device_link_add() could be changed to call device_reorder_to_tail()
>> only if device_is_registered(consumer) returns true.
>>
>> That's an inline function defined in <linux/device.h> which returns
>> dev->kobj.state_in_sysfs, a flag which is set in kobject_add().
> I know what that function is, but using it alone is not sufficient,
> because dev->kobj.state_in_sysfs is set before the device is added to
> dpm_list.

I found that checking for dev->p was enough to check if device has been
added to system or not, but this seems to be some kind of ugly workaround:

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4542ba9f60d4..780495918b53 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -180,9 +180,11 @@ struct device_link *device_link_add(struct device 
*consumer,
          * It is necessary to hold dpm_list locked throughout all that 
or else
          * we may end up suspending with a wrong ordering of it.
          */
-       device_pm_lock();
-       device_reorder_to_tail(consumer, NULL);
-       device_pm_unlock();
+       if (consumer->p) {
+               device_pm_lock();
+               device_reorder_to_tail(consumer, NULL);
+               device_pm_unlock();
+       }

         list_add_tail_rcu(&link->s_node, &supplier->links_to_consumers);
         list_add_tail_rcu(&link->c_node, &consumer->links_to_suppliers);


>
>> Then device_add() would have to check if any links are already
>> set up and reorder the consumer behind the suppliers.
>>
>> Doesn't seem to be *that* complex, but probably I'm missing something,
>> this is just off the cuff...
> There are some cases to consider and some races to avoid AFAICS.
>
> It all gets a lot simpler if device_link_add() is allowed to return NULL when
> the supplier device passed to it has not been registered yet.  That looks like
> a reasonable thing to do to me, but I wonder if someone has a use case in which
> it would be a substantial limitation.

Hmmm, you are talking here about the supplier, but my case is that 
supplier is
already registered and probed, but the consumer is about to be created. 
If you
think that supporting such case makes no sense, then I will use the 
workaround
with bus notifier I mentioned earlier.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

