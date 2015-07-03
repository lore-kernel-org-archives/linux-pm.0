From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v3 2/2] PM / Runtime: Add pm_runtime_enable_recursive
Date: Fri, 3 Jul 2015 16:22:02 +0200
Message-ID: <CAAObsKD1AbpkWytnA0=uwzUih-g4p-kXU8zSv-csnihCjvvteg@mail.gmail.com>
References: <CAAObsKADoP4hhjoHD4xM0OZ9io93C9u=roC=d_-_KrGfGqYW7Q@mail.gmail.com>
 <Pine.LNX.4.44L0.1507031007230.19910-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36065 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083AbbGCOWX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 10:22:23 -0400
In-Reply-To: <Pine.LNX.4.44L0.1507031007230.19910-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 3 July 2015 at 16:16, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Fri, 3 Jul 2015, Tomeu Vizoso wrote:
>
>> On 2 July 2015 at 17:21, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Thu, 2 Jul 2015, Tomeu Vizoso wrote:
>> >
>> >> > Just because these sub-devices are virtual, it doesn't mean you can
>> >> > ignore the way they interact with runtime PM.
>> >>
>> >> Fair enough, but then, how are we expected to be able to use the
>> >> direct_complete facility if the core bails out if a descendant doesn't
>> >> have runtime PM enabled?
>> >>
>> >> > In the case of ep_87 this doesn't matter.  Endpoint devices (like all
>> >> > devices) are in the SUSPENDED state by default when they are created,
>> >> > and they never leave that state.
>> >>
>> >> I don't see why it doesn't matter for endpoints or the others. They
>> >> don't have runtime PM enabled, so no ancestor will be able to do
>> >> direct_complete.
>> >
>> > Ah, you're concerned about these lines near the start of
>> > __device_suspend():
>> >
>> >         if (dev->power.direct_complete) {
>> >                 if (pm_runtime_status_suspended(dev)) {
>> >                         pm_runtime_disable(dev);
>> >                         if (pm_runtime_suspended_if_enabled(dev))
>> >                                 goto Complete;
>> >
>> >                         pm_runtime_enable(dev);
>> >                 }
>> >                 dev->power.direct_complete = false;
>> >         }
>> >
>> > Perhaps the pm_runtime_suspended_if_enabled() test should be changed to
>> > pm_runtime_status_suspended().  Then it won't matter whether the
>> > descendant devices are enabled for runtime PM.
>>
>> Yeah, that would remove the need for messing with the runtime PM
>> enable status of descendant devices, but I wonder why Rafael went that
>> way initially.
>
> I forget the details.  Probably it was just to be safe.  We probably
> thought that if a device was disabled for runtime PM then its runtime
> PM status might not be accurate.  But if direct_complete is set then it
> may be reasonable to assume that the runtime PM status _is_ accurate.

Cool.

>> >> > A possible way around the problem is to use pm_suspend_ignore_children
>> >> > on the uvcvideo interface.  But I'm not sure that would be the right
>> >> > thing to do.
>> >>
>> >> Would that mean that if a device has ignore_children then it could
>> >> still do direct_complete even if its descendants weren't able to?
>> >
>> > I think we could justify that.  The ignore_children flag means we can
>> > communicate with the children even when the device is in runtime
>> > suspend, so there's no reason to force the device to leave runtime
>> > suspend during a system sleep.
>>
>> IIUIC, what you are proposing is to use ignore_children in a way
>> similar to how force_direct_complete was used in this patch?
>>
>> http://thread.gmane.org/gmane.linux.power-management.general/60198/focus=60292
>
> That message doesn't contain a patch.

The patch is at the top of the thread:

http://thread.gmane.org/gmane.linux.power-management.general/60198/focus=60292

>> That should work as well, but Rafael raised some objections and thus I
>> went with the present direct_complete_default, which should work if we
>> can relax the check as discussed above.
>
> Rafael and I briefly discussed ignore_children while the original
> direct_complete patch was being designed.  We didn't come to any
> definite conclusion and decided to forget about it for the time being.
> Maybe now would be a good time to reconsider it.

I would prefer to have ignore_children ignore whether the children of
a device were able to do direct_complete, rather than having a
direct_complete_default flag (plus not requiring that all its
descendants have runtime PM enabled).

Thanks,

Tomeu

> Alan Stern
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
