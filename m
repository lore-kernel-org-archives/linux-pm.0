From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Thu, 17 Sep 2015 20:43:54 +0200
Message-ID: <CAJZ5v0gAsgsA+P_oL=KnAwBpkdJY_P733jBnXnGPdFOs5yiUfw@mail.gmail.com>
References: <CAJZ5v0hYUfO87hGAjKRAZMt_G4NnkEOXuVybSsVmKzAm6vznDA@mail.gmail.com>
	<Pine.LNX.4.44L0.1509171253520.1270-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35864 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbbIQSnz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 14:43:55 -0400
In-Reply-To: <Pine.LNX.4.44L0.1509171253520.1270-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Alan,

On Thu, Sep 17, 2015 at 7:02 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 17 Sep 2015, Rafael J. Wysocki wrote:
>
>> On Thu, Sep 17, 2015 at 2:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Wednesday, September 16, 2015 03:22:37 PM Alan Stern wrote:
>> >> On Wed, 16 Sep 2015, Thierry Reding wrote:
>>
>> [cut]
>>
>> >
>> > And I'm wondering if and how that is related to runtime PM?  It only
>> > covers the system sleep transitions case, but who's responsible for the
>> > runtime PM part?  Device drivers?
>
> In theory the drivers are responsible.  In practice, I don't know how
> this is handled.

Same here, unfortunately.

>> Which reminds me of something we all seem to be forgetting about:
>> there is asynchronous suspend and resume which may cause suspend and
>> resume callbacks of devices to be executed in an order that is
>> different from the dpm_list order.  In those cases the device that
>> depends on another one has to explicitly wait for the other one to
>> complete its callback in the current phase of the transition.
>>
>> While correct ordering of dpm_list is essential for this to work too,
>> it by no means is sufficient, so in the end the driver having a
>> dependency needs to know about it and act on it as needed (or we need
>> an alternative mechanism that will do that automatically, but I'm not
>> sure what that may be).

Note: Problems also may happen if device A depends on device B and its
driver to be present and functional and then the B's driver module is
unloaded.  The core doesn't prevent that from happening AFAICS.

>> Actually, I was thinking about adding something like pm_get() for this
>> purpose that will do pm_runtime_get_sync() on the target and will
>> ensure that the right things will happen during system suspend/resume
>> in addition to that, including reordering dpm_list if necessary.
>> Plus, of course, the complementary pm_put().
>>
>> With something like that available, there should be no need to reorder
>> dpm_list anywhere else.  The problem with this approach is that the
>> reordering becomes quite complicated then, as it would need to move
>> the device itself after the target and anything that depends on it
>> along with it and tracking those dependencies becomes quite
>> problematic.
>
> Keeping explicit track of these non-child-parent dependencies seems
> reasonable.  But I don't know how you could combine it with reordering
> dpm_list.
>
> One possibility might be to do a topological sort of all devices, with
> the initial set of constraints given by the explicit dependencies and
> the parent-child relations.  So basically this would mean ignoring the
> actual dpm_list and making up a new list of your own whenever a sleep
> transition starts.  It might work, but I'm not sure how reliable it
> would be.

I'd like to go back to my initial hunch that the driver knowing about
a dependency on another one should tell the core about that, so the
core can make the right things happen at various times (like system
suspend/resume etc).

What if we introduce a mechanism allowing drivers to say "I depend on
device X and its driver to be present and functional from now on" and
store that information somewhere for the core to use?

Some time ago (a few years ago actually IIRC) I proposed something
called "PM links".  The idea was to have objects representing such
dependencies, although I was not taking the "the driver of the device
I depend on should be present and functional going forward" condition.

Say, if a driver wants to check the presence of the device+driver it
needs to be functional, it will do something like

ret = create_pm_link(dev, producer);

and that will return -EPROBE_DEFER if the producer device is not
functional.  If success is returned, the link has been created and now
the core will take it into account.

On driver removal the core may just delete the links where the device
is the "consumer".  Also there may be a delete_pm_link(dev, producer)
operation if needed.

The creation of a link may then include the reordering of dpm_list as
appropriate so all "producers" are now followed by all of their
"consumers".  Going forward, though, the core may use the links to
make all "producers" wait for the PM callbacks of their "consumers" to
complete during system suspend etc.  It also may use them to prevent
drivers being depended on from being unloaded and/or to force the
removal of drivers that depend on something being removed.  In
principle it may also use those links to coordinate runtime PM
transitions, but I guess that's not going to be useful in all cases,
so there needs to be an opt-in mechanism for that.

Please tell me what you think.

Thanks,
Rafael
