From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Sat, 19 Sep 2015 01:07:56 +0200
Message-ID: <CAJZ5v0iFvnYxEfSN9VAdsBhhk9QgSJ+JS-4qsZPBGfatAY7j3A@mail.gmail.com>
References: <CAJZ5v0hYUfO87hGAjKRAZMt_G4NnkEOXuVybSsVmKzAm6vznDA@mail.gmail.com>
	<Pine.LNX.4.44L0.1509171253520.1270-100000@iolanthe.rowland.org>
	<CAJZ5v0gAsgsA+P_oL=KnAwBpkdJY_P733jBnXnGPdFOs5yiUfw@mail.gmail.com>
	<20150918155547.GB6692@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150918155547.GB6692@ulmo.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

Hi Thierry,

On Fri, Sep 18, 2015 at 5:55 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Thu, Sep 17, 2015 at 08:43:54PM +0200, Rafael J. Wysocki wrote:
>> Hi Alan,
>>
>> On Thu, Sep 17, 2015 at 7:02 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Thu, 17 Sep 2015, Rafael J. Wysocki wrote:
>> >
>> >> On Thu, Sep 17, 2015 at 2:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >> > On Wednesday, September 16, 2015 03:22:37 PM Alan Stern wrote:
>> >> >> On Wed, 16 Sep 2015, Thierry Reding wrote:
>> >>
>> >> [cut]
>> >>
>> >> >
>> >> > And I'm wondering if and how that is related to runtime PM?  It only
>> >> > covers the system sleep transitions case, but who's responsible for the
>> >> > runtime PM part?  Device drivers?
>> >
>> > In theory the drivers are responsible.  In practice, I don't know how
>> > this is handled.
>>
>> Same here, unfortunately.
>>
>> >> Which reminds me of something we all seem to be forgetting about:
>> >> there is asynchronous suspend and resume which may cause suspend and
>> >> resume callbacks of devices to be executed in an order that is
>> >> different from the dpm_list order.  In those cases the device that
>> >> depends on another one has to explicitly wait for the other one to
>> >> complete its callback in the current phase of the transition.
>> >>
>> >> While correct ordering of dpm_list is essential for this to work too,
>> >> it by no means is sufficient, so in the end the driver having a
>> >> dependency needs to know about it and act on it as needed (or we need
>> >> an alternative mechanism that will do that automatically, but I'm not
>> >> sure what that may be).
>>
>> Note: Problems also may happen if device A depends on device B and its
>> driver to be present and functional and then the B's driver module is
>> unloaded.  The core doesn't prevent that from happening AFAICS.
>
> As Alan already mentioned this is typically solved by consumers taking a
> module reference. However that only makes sure that the module stays
> around, so references to code or global data will remain valid. However
> it does not prevent the device from being unbound and freeing all the
> resources associated with it.
>
> A lot of subsystems are buggy this way. Typically the solution here is
> to properly reference count objects that subsystems hand out. But that
> does not solve the problem entirely. You still need to deal with the
> situation where the device backing an object goes away. Consumers may
> keep a reference to the object, which ensures that the data stays around
> but operations on the objects would still fail (consider cases where the
> operation accesses registers that have been unmapped when the provider
> was unbound).
>
> If the core provided a means to prevent a device from being unbound if
> it still had consumers, that would fix a whole lot of problems at once.

Indeed.

> Of course there's still the matter of some types of devices physically
> disappearing (USB, PCI, ...).

Right.  In some cases removal is simply necessary as part of the
cleanup, like after a surprise hot-unplug of a device, for example.
In those cases everything that depended on the device that went away
should be unbound from drivers at least IMO.

>> >> Actually, I was thinking about adding something like pm_get() for this
>> >> purpose that will do pm_runtime_get_sync() on the target and will
>> >> ensure that the right things will happen during system suspend/resume
>> >> in addition to that, including reordering dpm_list if necessary.
>> >> Plus, of course, the complementary pm_put().
>> >>
>> >> With something like that available, there should be no need to reorder
>> >> dpm_list anywhere else.  The problem with this approach is that the
>> >> reordering becomes quite complicated then, as it would need to move
>> >> the device itself after the target and anything that depends on it
>> >> along with it and tracking those dependencies becomes quite
>> >> problematic.
>> >
>> > Keeping explicit track of these non-child-parent dependencies seems
>> > reasonable.  But I don't know how you could combine it with reordering
>> > dpm_list.
>> >
>> > One possibility might be to do a topological sort of all devices, with
>> > the initial set of constraints given by the explicit dependencies and
>> > the parent-child relations.  So basically this would mean ignoring the
>> > actual dpm_list and making up a new list of your own whenever a sleep
>> > transition starts.  It might work, but I'm not sure how reliable it
>> > would be.
>>
>> I'd like to go back to my initial hunch that the driver knowing about
>> a dependency on another one should tell the core about that, so the
>> core can make the right things happen at various times (like system
>> suspend/resume etc).
>>
>> What if we introduce a mechanism allowing drivers to say "I depend on
>> device X and its driver to be present and functional from now on" and
>> store that information somewhere for the core to use?
>>
>> Some time ago (a few years ago actually IIRC) I proposed something
>> called "PM links".  The idea was to have objects representing such
>> dependencies, although I was not taking the "the driver of the device
>> I depend on should be present and functional going forward" condition.
>>
>> Say, if a driver wants to check the presence of the device+driver it
>> needs to be functional, it will do something like
>>
>> ret = create_pm_link(dev, producer);
>>
>> and that will return -EPROBE_DEFER if the producer device is not
>> functional.  If success is returned, the link has been created and now
>> the core will take it into account.
>>
>> On driver removal the core may just delete the links where the device
>> is the "consumer".  Also there may be a delete_pm_link(dev, producer)
>> operation if needed.
>>
>> The creation of a link may then include the reordering of dpm_list as
>> appropriate so all "producers" are now followed by all of their
>> "consumers".  Going forward, though, the core may use the links to
>> make all "producers" wait for the PM callbacks of their "consumers" to
>> complete during system suspend etc.  It also may use them to prevent
>> drivers being depended on from being unloaded and/or to force the
>> removal of drivers that depend on something being removed.  In
>> principle it may also use those links to coordinate runtime PM
>> transitions, but I guess that's not going to be useful in all cases,
>> so there needs to be an opt-in mechanism for that.
>
> Force-removing drivers that depend on a device that's being unbound
> would be a possibility to solve the problem where consumers depend on a
> device that could physically go away. It might also be the right thing
> to do in any case. Presumably somebody unloading a module want to do
> just that, and refusing to do so isn't playing very nice. Of course
> allowing random modules to be removed even if a lot of consumers might
> depend on it may not be friendly either. Consider if you unload a GPIO
> driver that provides a pin that's used to enable power to an eMMC that
> might have the root filesystem.
>
> Then again, if you unload a module you better know what you're doing
> anyway, so maybe that's not something we need to be concerned about.

I think that it's better to fail module unloads in such cases by
default (to prevent simple silly mistakes from having possibly severe
consequences), but if a "force" option is used, we should regard that
as "the user really means it" and do as requested.  That would be very
much analogous to the hot-unplug situation from the software
perspective.

>> Please tell me what you think.
>
> I think that's a great idea. There's probably some bikeshedding to be
> had, but on the whole I think this would add very useful information to
> the driver model.
>
> Many subsystems nowadays already provide a very similar API, often of
> the form:
>
>         resource = [dev_]*_get(dev, "name");
>
> Subsystems usually use dev and "name" to look up the provider and the
> resource. When they do lookup the provider they will typically be able
> to get at the underlying struct device, so this would provide a very
> nice entrypoint to call the core function. That way we can move this
> into subsystems and individual drivers don't have to be updated.

Right.

> I think this would also tie in nicely with Tomeu's patch set to do
> on-demand probing. Essentially a [dev_]*_get() call could in turn call
> this new "declare dependency" API, and the new API could underneath do
> on-demand probing.
>
> Given that this isn't a strictly PM mechanism anymore, perhaps something
> like:
>
>         int device_depend(struct device *dev, struct device *target);
>
> would be a more generic option.

I thought about something like link_device(dev, target, flags), where
the last argument would indicate what the core is supposed to use the
link for (removal handling, system suspend/resume, runtime PM etc).

And I agree that this isn't really PM-specific.

OK, thanks a lot for the feedback!

Let me think about that a bit more and I'll try to come up with a more
detailed design description.

Thanks,
Rafael
