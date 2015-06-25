From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Thu, 25 Jun 2015 14:11:58 -0300
Message-ID: <20150625171158.GB27230@khazad-dum.debian.net>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
 <Pine.LNX.4.44L0.1505091556001.5397-100000@netrider.rowland.org>
 <20150509202518.GB20282@khazad-dum.debian.net>
 <CAJvTdKmGFPHtO-rOwXWJr6bPDS4PuEo+g7H-uQhuMc_+kh4CuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJvTdKmGFPHtO-rOwXWJr6bPDS4PuEo+g7H-uQhuMc_+kh4CuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 11 May 2015, Len Brown wrote:
> On Sat, May 9, 2015 at 4:25 PM, Henrique de Moraes Holschuh
> <hmh@hmh.eng.br> wrote:
> > On Sat, 09 May 2015, Alan Stern wrote:
> >> On Fri, 8 May 2015, Rafael J. Wysocki wrote:
> >> > My current view on that is that whether or not to do a sync() before suspending
> >> > ultimately is a policy decision and should belong to user space as such (modulo
> >> > the autosleep situation when user space may not know when the suspend is going
> >> > to happen).
> >> >
> >> > Moreover, user space is free to do as many sync()s before suspending as it
> >> > wants to and the question here is whether or not the *kernel* should sync()
> >> > in the suspend code path.
> >> >
> >> > Since we pretty much can demonstrate that having just one sync() in there is
> >> > not sufficient in general, should we put two of them in there?  Or just
> >> > remove the existing one and leave it to user space entirely?
> >>
> >> I don't know about the advantages of one sync over two.  But how about
> >> adding a "syncs_before_suspend" (or just "syncs") sysfs attribute that
> >> takes a small numeric value?  The default can be 0, and the user could
> >> set it to 1 or 2 (or higher).
> >
> > IMO it would be much safer to both have that knob, and to set it to keep the
> > current behavior as the default.  Userspace will adapt and change that knob
> > to whatever is sufficient based on what it does before signaling the kernel
> > to suspend.
> >
> > A regression in sync-before-suspend is sure to cause data loss episodes,
> > after all.  And, as far as bikeshedding goes, IMHO syncs_before_suspend is
> > self-explanatory, which would be a very good reason to use it instead of the
> > shorter requires-you-to-know-what-it-is-about "syncs".
> 
> When I first thought about this, I had a similar view:
> https://lkml.org/lkml/2014/1/23/45
> 
> But upon reflection, I do not believe that the kernel is adding value
> here, instead it is imposing a policy, and that policy decision is
> sometimes prohibitively expensive.  User-space can do this for itself (and
> in the case of desktop distros, already does), and so the kernel should
> butt-out.

There is a lot of added value in my filesystems not being trashed by
sleep/resume issues on laptops, IMHO, and the reason why we need the kernel
itself to take care of syncing and freezing filesystems has been explained
elsewhere in this thread.

I thoght for a while before replying, and I think the real issue behind this
thread is the want of a change of expected-but-implied semanthics and
behavior for the system-wide sleep-to-memory trigger, to adequate it to a
new reality for newer classes of devices.

Entering "mem" suspend mode through sysfs currently has the implied meaning
of "prepare the *entire* system to stay on a powered down state for
pontentially a _long_ time", where long means "certainly more than 10
seconds" ;-) This is unlikely to be written anywhere, of course, that's just
how it was used by the vast majority for years, at least on traditional
server/desktop/laptop platforms such as x86.

On those platforms, we have to assume the user might plug/unplug devices,
that the power supply might shut down while we're sleeping, that the entire
process is not painless and has a reasonable chance of misbehaving (crashes
on sleep/resume are _really_ common), etc.

What is the safe and proper thing to do in that situation is not necessarily
the best way to go about it when you actually want a somewhat different
behavior, i.e. to "prepare the system to stay on a powered down state for a
short while, and be very fast because this could happen at a very high
frequency"...

IMO, we would actually benefit from *adding* new system-wide sleep/suspend
modes that are optimized for oportunistic, short-lived system-wide sleep
cycles (aka "catnap") that is fast to enter and exit from, and which will be
triggered very frequently, instead of trying to change the assumptions and
expected behavior of the current "deep-sleep" mode...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
