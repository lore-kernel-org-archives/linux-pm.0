From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] PM / sleep: Let devices force direct_complete
Date: Wed, 6 May 2015 18:05:37 +0200
Message-ID: <CAPDyKFp5MNKoER5W4+QXDR3BUckdT8KUPCL_g=QOVhvscor=Bw@mail.gmail.com>
References: <CAPDyKFpeP8iTw1qat5sd5gtrzk0d+a2hg_EF-2u14HRPcMbE3Q@mail.gmail.com>
	<Pine.LNX.4.44L0.1505061035300.1094-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1505061035300.1094-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 6 May 2015 at 16:43, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Wed, 6 May 2015, Ulf Hansson wrote:
>
>> On 30 April 2015 at 16:53, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Thu, 30 Apr 2015, Ulf Hansson wrote:
>> >
>> >> I hesitated to send this reply, since it might add confusion. If
>> >> that's the case, please ignore it.
>> >>
>> >> I have a long term vision to fully enable support for a runtime PM
>> >> centric configuration for drivers/subsystems. The idea is, that such
>> >> driver/subsystem should get system PM for "free".
>> >>
>> >> The main goal is to simplify PM implementation for these drivers/subsystems.
>> >>
>> >> They should need to implement the runtime PM callbacks only and not
>> >> the system PM ones. During system PM suspend, the requirement is that
>> >> the corresponding devices should be guaranteed to be "runtime PM
>> >> suspended". Somehow that then needs to be managed by the PM core.
>> >>
>> >> I am not sure it's doable, but I wanted to bring it up within the
>> >> context of $subject patch, since it proposes yet another optimization
>> >> path for runtime PM during system PM.
>> >
>> > I suspect it is _not_ doable.  Consider a reasonable scenario: a driver
>> > that does pm_runtime_get_sync() in its open routine and
>> > pm_runtime_put() in its release routine.  If a user process holds the
>> > device file open during a system suspend, it will be impossible for the
>> > PM core to do a runtime suspend.
>>
>> Alan, thanks for your reply.
>>
>> There are certainly drivers/subsystems that can't full-fill the
>> requirements to have the PM core to deal with what I propose. Somehow
>> drivers/subsystems would have to announce its capability for this.
>>
>> Those drivers/subsystems I have been looking at, is dealing with I/O.
>> Typically platform/amba devices, which drivers has registered
>> subsystem specific callbacks at ->probe(). One of these callbacks are
>> invoked when there is an I/O request to serve from the subsystem's
>> core layer.
>>
>> In the beginning of that callback, pm_runtime_get_sync() is invoked.
>> When the request has been served and the controller can be runtime PM
>> suspended, the driver call pm_runtime_put() or possibly
>> pm_runtime_put_autosuspend().
>>
>> These drivers/subsystem may be considered as being "runtime PM
>> centric", since during system PM suspend they don't have any system PM
>> specific things to deal with. They only want to make sure their
>> devices becomes "runtime PM suspended".
>>
>> There's no doubt that they can do that by implementing the system PM
>> ->suspend() callbacks, in one way or the other.
>>
>> To simplify PM implementation for these drivers/subsystems, it would
>> have been nice if the PM core could handle this "automagically", thus
>> drivers/subsystems wouldn't have to implement the system PM callbacks
>> at all. Reaching that point, would likely make it easier to understand
>> how to implement a "runtime PM centric" driver/subsystem.
>
> The drivers/subsystems don't have to implement these things, because
> you have _already_ implemented them: pm_runtime_force_suspend() and
> pm_runtime_force_resume().  A driver/subsystem merely has to store
> pointers to these routines in its dev_pm_ops structure.

Yes, apparently I have touched this topic earlier. :-)

As we are moving towards removing the Kconfig option CONFIG_PM_SLEEP
(CONFIG_PM_RUNTIME is already removed) and only have the CONFIG_PM,
parts of what the above helper functions addresses becomes redundant.

>
>> > On the other hand, there's nothing to prevent drivers from setting
>> > their ->suspend and ->runtime_suspend structure members to point at the
>> > same routine.  The routine would need to handle the case where it was
>> > called for a system suspend while the device was already runtime
>> > suspended, but that doesn't seem too hard.  With the "direct-suspend"
>> > option, even this wouldn't be necessary.
>>
>> That would likely work, but again it would require drivers/subsystems
>> to assign system PM callbacks.
>
> You said just above that the driver/subsystem would have to announce
> its capability for this somehow.  Using suitable callback pointers
> would be a good way to make that announcement.

I was thinking, for simplicity purpose, that we could try to move this
a step forward.

Having a API like pm_runtime_centric() (or whatever name we can come
up with) to announce the capability, could be easier to understand and
use. Of course that's my opinion.

Kind regards
Uffe
