From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Tue, 22 Sep 2015 02:39:16 +0200
Message-ID: <CAJZ5v0iNt+DYQb8h9CwG5YxgP11pCd2bSsj--JbdGcaanMd40A@mail.gmail.com>
References: <CAJZ5v0hYUfO87hGAjKRAZMt_G4NnkEOXuVybSsVmKzAm6vznDA@mail.gmail.com>
	<Pine.LNX.4.44L0.1509171253520.1270-100000@iolanthe.rowland.org>
	<CAJZ5v0gAsgsA+P_oL=KnAwBpkdJY_P733jBnXnGPdFOs5yiUfw@mail.gmail.com>
	<20150918155547.GB6692@ulmo.nvidia.com>
	<CAJZ5v0iFvnYxEfSN9VAdsBhhk9QgSJ+JS-4qsZPBGfatAY7j3A@mail.gmail.com>
	<20150921085100.GF19865@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33069 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbbIVAjS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 20:39:18 -0400
In-Reply-To: <20150921085100.GF19865@ulmo.nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi,

On Mon, Sep 21, 2015 at 10:51 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Sat, Sep 19, 2015 at 01:07:56AM +0200, Rafael J. Wysocki wrote:
>> On Fri, Sep 18, 2015 at 5:55 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
> [...]
>> > Of course there's still the matter of some types of devices physically
>> > disappearing (USB, PCI, ...).
>>
>> Right.  In some cases removal is simply necessary as part of the
>> cleanup, like after a surprise hot-unplug of a device, for example.
>> In those cases everything that depended on the device that went away
>> should be unbound from drivers at least IMO.
>
> Agreed.
>
>> > Force-removing drivers that depend on a device that's being unbound
>> > would be a possibility to solve the problem where consumers depend on a
>> > device that could physically go away. It might also be the right thing
>> > to do in any case. Presumably somebody unloading a module want to do
>> > just that, and refusing to do so isn't playing very nice. Of course
>> > allowing random modules to be removed even if a lot of consumers might
>> > depend on it may not be friendly either. Consider if you unload a GPIO
>> > driver that provides a pin that's used to enable power to an eMMC that
>> > might have the root filesystem.
>> >
>> > Then again, if you unload a module you better know what you're doing
>> > anyway, so maybe that's not something we need to be concerned about.
>>
>> I think that it's better to fail module unloads in such cases by
>> default (to prevent simple silly mistakes from having possibly severe
>> consequences), but if a "force" option is used, we should regard that
>> as "the user really means it" and do as requested.  That would be very
>> much analogous to the hot-unplug situation from the software
>> perspective.
>
> Sounds very reasonable to me.
>
>> > I think this would also tie in nicely with Tomeu's patch set to do
>> > on-demand probing. Essentially a [dev_]*_get() call could in turn call
>> > this new "declare dependency" API, and the new API could underneath do
>> > on-demand probing.
>> >
>> > Given that this isn't a strictly PM mechanism anymore, perhaps something
>> > like:
>> >
>> >         int device_depend(struct device *dev, struct device *target);
>> >
>> > would be a more generic option.
>>
>> I thought about something like link_device(dev, target, flags), where
>> the last argument would indicate what the core is supposed to use the
>> link for (removal handling, system suspend/resume, runtime PM etc).
>
> Sounds good to me. I think the core isn't quite consistent on the naming
> of functions, so we have things like device_register/unregister() versus
> get/put_device(). I'd lean towards device_link(dev, target, flags), but
> I'll go with any color you'd like the shed to have.

Well, whatever.

n any case it would be good to have "link" and "device" in the name,
regardless of the ordering. :-)

>> And I agree that this isn't really PM-specific.
>>
>> OK, thanks a lot for the feedback!
>>
>> Let me think about that a bit more and I'll try to come up with a more
>> detailed design description.
>
> This sounds like it's not going to make it into v4.3 anymore, so I'll
> need to think about the easiest way to (temporarily) fix up the current
> regression.
>
> Is this something that you will have time to implement yourself? If so,
> please keep me in the loop and Cc me on any patches that you need
> tested. If you're short on time, let me know as well and I'll see if I
> can take a stab at it myself, though I'm pretty sure I'll need further
> guidance along the way.

I'd like to try to do that myself, but that'll take some time.  I hope
this isn't a problem.

Given the time frame it should be doable for v4.4 in theory.

Thanks,
Rafael
