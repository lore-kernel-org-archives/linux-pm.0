From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
Date: Fri, 15 Nov 2013 10:22:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1311151006280.1527-100000@iolanthe.rowland.org>
References: <CAPDyKFrQfwOQsOCB1QFo4GWeX303AEWnanE61svy9UUJpNBUiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47965 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751335Ab3KOPWb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2013 10:22:31 -0500
In-Reply-To: <CAPDyKFrQfwOQsOCB1QFo4GWeX303AEWnanE61svy9UUJpNBUiw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PCI <linux-pci@vger.kernel.org>, linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>

On Fri, 15 Nov 2013, Ulf Hansson wrote:

> I think it is kind of strange to give provision to userspace to
> control a "request based" power management feature in the kernel. Me
> personally can't think of any good use case, but I comes from the
> embedded/ARM world so I might not have the full picture.

I'm don't know what you mean by "request based" here.

In any case, although Bj=C3=B8rn made a good point about latency, the m=
ain
reason for having the sysfs interface was to cope with buggy devices. =20
Linux started using runtime PM before Windows did.  At that time, many
devices did not support runtime suspend very well -- they didn't have
to since Windows didn't use it.  Plenty of devices simply couldn't
handle it.  Too many for a blacklist.

So we pushed the decision about whether to enable runtime PM out to
userspace.  There was no other choice; too many people were having too
many problems when runtime PM was automatically on.

> What would make sense to me, is to move the runtime PM sysfs to
> debugfs, because it is a good feature to make use of during
> development and debugging.

But since it is primarily needed for device control by the user, it
belongs in sysfs.

> >> Anyway, if userspace decides to prevent runtime_suspend, I guess i=
t
> >> will have take the consequences for it as well. :-)
> >
> > Right now, those consequences don't include also preventing the dev=
ice
> > from going to low power during system system.  What would you do if=
 you
> > had a buggy device, where you knew it couldn't handle runtime suspe=
nd?
> > If you still wanted to put the whole system to sleep, you'd be stuc=
k.
>=20
> Hmm, this seems like a use case for runtime PM sysfs then. :-)
>=20
> It sounds like vague arguments. If the driver has bugs we need to fix
> them, right? Should we really let userspace workaround bugs in the
> kernel?

I am talking about bugs in the _device_, not bugs in the _driver_.

> >> So as a way forward, I am thinking of a similar approach as you
> >> suggested with the "generic" suspend_late. But instead add a new
> >> runtime PM API, which intent is to let drivers to specify for PM c=
ore,
> >> if it should care to prevent the runtime suspend from happen durin=
g
> >> system system - or not. Could that work?
> >
> > I don't see what good it would do.  Instead of adding a new flag, w=
hy
> > not just let drivers point their .suspend_late methods to the new
> > generic function?  That would accomplish almost the same thing with=
out
> > changing the API.
>=20
> Two minor functions will be added to the API, no big deal I think.
> More importantly these will actually make life easier for some driver=
s
> since they don't need to set up any additional PM callbacks.
>=20
> Using the generic suspend_late approach would for sure work, but it
> will spread to buses and power domains as well, which is not the case
> when adding when adding a new API.

I don't understand what you mean by "spread to".  That makes it sound=20
like an infectious disease rather than a subroutine.  :-)

Also, I don't see how adding one line for an extra callback pointer is
any harder than adding one line to call pm_runtime_no_prevent_suspend.

> > (Actually, it would be superior.  The generic suspend_late approach
> > will work even if the user writes "on" to /sys/.../power/control,
> > whereas your approach won't work.)
>=20
> We have different view here. :-)
>=20
> Whether I like it or not, the sysfs interface exist and then I think
> the kernel must act accordingly. We shouldn=92t override it. I mean i=
f
> userspace has decided to keep a device active, there is probably a
> reason.
>=20
>=20
> Thanks a lot Alan for being patient with me and continuing the discus=
sion!

My pleasure.

Alan Stern

