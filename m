From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v3 1/2] PM / sleep: Let devices force direct_complete
Date: Mon, 20 Apr 2015 09:10:50 +0200
Message-ID: <CAAObsKA7EFRmWGaGS6nTwMzFyoPcSXjmY5CZqHHVE+ART4EJNg@mail.gmail.com>
References: <1471135.f2mh84nZFq@avalon> <Pine.LNX.4.44L0.1504171325100.1319-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:33720 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbbDTHLM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2015 03:11:12 -0400
In-Reply-To: <Pine.LNX.4.44L0.1504171325100.1319-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 17 April 2015 at 19:30, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Fri, 17 Apr 2015, Laurent Pinchart wrote:
>
>> Hi Tomeu,
>>
>> Thank you for the patch.
>>
>> On Friday 17 April 2015 17:24:49 Tomeu Vizoso wrote:
>> > Introduce a new per-device flag power.force_direct_complete that will
>> > instruct the PM core to ignore the runtime PM status of its descendants
>> > when deciding whether to let this device remain in runtime suspend when
>> > the system goes into a sleep power state.
>> >
>> > This is needed because otherwise it would be needed to get dozens of
>> > drivers to implement the prepare() callback and be runtime PM active
>> > even if they don't have a 1-to-1 relationship with a piece of HW.
>>
>> I'll let PM experts comment on the approach, but I believe the new flag would
>> benefit from being documented (likely in Documentation/power/devices.txt) :-)
>
> Documentation/power/runtime_pm.txt is the right place.
>
> However, I'm not sure that this is the sort of thing Rafael meant when
> he suggested adding a new flag.  I thought he meant the PM core would
> look at the new flag only if there was no ->prepare method at all.
> Then if the new flag was set, the PM core would act as though ->prepare
> had returned 1.  That way there would be no need to add silly little
> one-line *_prepare() routines all over the place.
>
> Maybe he had something else in mind, though...

Yeah, I also interpreted it like that, but when I started looking at
how it would work, I found that it would be awkward if the uvcvideo
driver had to track all the devices that get attached below its
devices in order to set that flag to them.

When thinking about it, it occurred to me that it may make more sense
if we model this as a property of the device bound to the uvcvideo
driver, as what's happening here is that the uvcvideo driver knows
that it's safe to remain in runtime suspend when the system goes to
sleep, and that all its descendant devices can be ignored in that
regard.

Was meaning to explain this in the cover letter, but I forgot to, sorry.

Thanks,

Tomeu

> Alan Stern
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
