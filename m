From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] PM / sleep: Let devices force direct_complete
Date: Thu, 30 Apr 2015 09:11:45 +0200
Message-ID: <CAPDyKFpLLJaMFsf5f8A42jjVqu+BkMMAH5ksHt0aA71QMQBH6w@mail.gmail.com>
References: <CAAObsKA7EFRmWGaGS6nTwMzFyoPcSXjmY5CZqHHVE+ART4EJNg@mail.gmail.com>
	<Pine.LNX.4.44L0.1504200957190.1321-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1504200957190.1321-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 20 April 2015 at 16:12, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 20 Apr 2015, Tomeu Vizoso wrote:
>
>> On 17 April 2015 at 19:30, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Fri, 17 Apr 2015, Laurent Pinchart wrote:
>> >
>> >> Hi Tomeu,
>> >>
>> >> Thank you for the patch.
>> >>
>> >> On Friday 17 April 2015 17:24:49 Tomeu Vizoso wrote:
>> >> > Introduce a new per-device flag power.force_direct_complete that will
>> >> > instruct the PM core to ignore the runtime PM status of its descendants
>> >> > when deciding whether to let this device remain in runtime suspend when
>> >> > the system goes into a sleep power state.
>> >> >
>> >> > This is needed because otherwise it would be needed to get dozens of
>> >> > drivers to implement the prepare() callback and be runtime PM active
>> >> > even if they don't have a 1-to-1 relationship with a piece of HW.
>> >>
>> >> I'll let PM experts comment on the approach, but I believe the new flag would
>> >> benefit from being documented (likely in Documentation/power/devices.txt) :-)
>> >
>> > Documentation/power/runtime_pm.txt is the right place.
>> >
>> > However, I'm not sure that this is the sort of thing Rafael meant when
>> > he suggested adding a new flag.  I thought he meant the PM core would
>> > look at the new flag only if there was no ->prepare method at all.
>> > Then if the new flag was set, the PM core would act as though ->prepare
>> > had returned 1.  That way there would be no need to add silly little
>> > one-line *_prepare() routines all over the place.
>> >
>> > Maybe he had something else in mind, though...
>>
>> Yeah, I also interpreted it like that, but when I started looking at
>> how it would work, I found that it would be awkward if the uvcvideo
>> driver had to track all the devices that get attached below its
>> devices in order to set that flag to them.
>>
>> When thinking about it, it occurred to me that it may make more sense
>> if we model this as a property of the device bound to the uvcvideo
>> driver, as what's happening here is that the uvcvideo driver knows
>> that it's safe to remain in runtime suspend when the system goes to
>> sleep, and that all its descendant devices can be ignored in that
>> regard.
>
> What you're proposing makes sense, but it is a significant change to
> the runtime PM core.  It should be submitted separately, not as part of
> an update to the UVC driver, and it should be discussed at length.
>
> Basically, you want to mark certain devices to say that they will
> _always_ use direct-suspend.  This means that all descendant devices
> will be forced to use direct-suspend also, and therefore any driver
> bound to one of these descendant devices will be unable to communicate
> with it during a system sleep transition.  This is a non-trivial
> restriction.
>
> Among other things, it means that wakeup settings can't be altered
> during a sleep transition.  Therefore this should be allowed only for
> devices that are not wakeup-capable.
>

I hesitated to send this reply, since it might add confusion. If
that's the case, please ignore it.

I have a long term vision to fully enable support for a runtime PM
centric configuration for drivers/subsystems. The idea is, that such
driver/subsystem should get system PM for "free".

The main goal is to simplify PM implementation for these drivers/subsystems.

They should need to implement the runtime PM callbacks only and not
the system PM ones. During system PM suspend, the requirement is that
the corresponding devices should be guaranteed to be "runtime PM
suspended". Somehow that then needs to be managed by the PM core.

I am not sure it's doable, but I wanted to bring it up within the
context of $subject patch, since it proposes yet another optimization
path for runtime PM during system PM.

Kind regards
Uffe
