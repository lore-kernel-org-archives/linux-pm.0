From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Mon, 06 Jul 2015 15:52:25 +0200
Message-ID: <1595559.BsCkcDEfNB@vostro.rjw.lan>
References: <4290667.ZqInAykFGS@vostro.rjw.lan> <1496051.AgsebokWnB@vostro.rjw.lan> <20150706000614.GB3902@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150706000614.GB3902@dastard>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alan Stern <stern@rowland.harvard.edu>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Monday, July 06, 2015 10:06:14 AM Dave Chinner wrote:
> On Sat, Jul 04, 2015 at 03:03:46AM +0200, Rafael J. Wysocki wrote:
> > On Friday, July 03, 2015 11:42:50 AM Dave Chinner wrote:
> > > On Wed, Jul 01, 2015 at 11:07:29PM -0400, Len Brown wrote:
> > > > >> The _vast_ majority of systems using Linux suspend today are under
> > > > >> an Android user-space.  Android has no assumption that that suspend to
> > > > >> mem will necessarily stay suspended for a long time.
> > > > >
> > > > > Indeed, however your change was not android-specific, and it is not
> > > > > "comfortable" on x86-style hardware and usage patterns.
> > > > 
> > > > "comfortable on x86-style and usage patterns"?
> > > > If you mean "traditional" instead of "comfortable",
> > > > where "tradition" is based on 10-year old systems, then sure.
> > > 
> > > Even if this were true(*) we don't break things that currently work
> > > just because something different is "just around the corner". e.g.
> > > if you shut the lid on your laptop and it suspends to RAM, you can
> > > pull the USB drive out that you just copied stuff to and plug it
> > > into another machine and find all the data you copied there is
> > > present.
> > > 
> > > Remove the sync() from the freeze code, and this isn't guaranteed to
> > > work anymore. It is now dependent on userspace implementations for
> > > this to work, and we know what userspace developers will choose in
> > > this situation. i.e. fast and "works for me", not "safe for
> > > everyone".
> > > 
> > > (*) Which it clearly isn't true because, as this example shows, my
> > > shiny new laptop still has exactly the same data integrity
> > > requirements as the laptop I was using 10 years ago.
> > > 
> > > Just because there are lots of Android or Chrome out there it
> > > doesn't mean we can just ignore the requirements of everything
> > > else...
> > > 
> > > > > That said, as long as x86 will still try to safeguard my data during mem
> > > > > sleep/resume as it does today, I have no strong feelings about
> > > > > light/heavy-weight "mem" sleep being strictly a compile-time selectable
> > > > > thing, or a more flexible runtime-selectable behavior.
> > > > 
> > > > The observation here is that the kernel should not force every system
> > > > to sys_sync() on every suspend.  The only question is how to best
> > > > implement that.
> > > 
> > > No, your observation was that "sync is slow". Your *solution* is "we
> > > need to remove sync".
> > 
> > Not only slow, but pointless too.  The argument goes: "It is slow and
> > pointless and so it may be dropped."
> > 
> > Now, I can agree that it wasn't clearly demonstrated that the unconditional
> > sys_sync() in the suspend code path was pointless, but it also has never
> > been clearly shown why it is not pointless on systems that suspend and resume
> > reliably.
> 
> I just gave you an example of why sync is needed: Suspend, pull out
> USB drive when putting laptop in bag.

Exactly the same thing can happen while not suspended.  What does make suspend
special with respect to that?

> > [The argument that the user can pull removable storage devices out of the
> > system while suspended doesn't hold any water to me, because the user can
> > pull them out of the system when not suspended just as well and cause the
> > same kind of damage to happen.]
> 
> How many times have you forgotten to pull a usb stick out of a
> laptop before putting it away? I've done that several times in the
> past few months, and so I've *personally* pulled the USB sticks out
> of suspended machines. This is a *common occurrence* and it
> currently works just fine, so changing sync behaviour is something
> that will directly impact me *as a user*.
> 
> Not to mention hybrid suspend (i.e write suspend image to disk, then
> suspend to RAM for fast resume, but if power is lost resume from
> disk image) both images have exactly the same filesystem state in
> them and that is an absolute requirement for a hybrid suspend...

For that you need to sync.  Let's not confuse what we're talking about.

The code path in question is suspend-only, no hibernation involved in any form.

> > Moreover, question is if we really need to carry out the sync on *every*
> > suspend even if it is not pointless overall.  That shouldn't really be
> > necessary if we suspend and resume often enough or if we resume only for
> > a while and then suspend again.  Maybe it should be rate limited somehow
> > at least?
> 
> If you suspend and resume frequently, then the cost of the sync
> shoul dbe negliable because the amount of data dirtied between
> resume/suspend shoul dbe negliable. hence my questions about where
> sync is spending too much time, and whether we've actually fixed
> those problems or not. If sync speed on clean filesystems is a
> problem then we need to fix sync, not work around it.

Well, say you never suspend, but you also only shut down the system when you
need to replace the kernel on it.  How often would you invoke global sync on
that system?

Thanks,
Rafael
