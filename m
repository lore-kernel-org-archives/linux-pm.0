From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Wed, 8 Jul 2015 13:20:41 +0200
Message-ID: <20150708112041.GB29356@amd>
References: <Pine.LNX.4.44L0.1507071058000.1692-100000@iolanthe.rowland.org>
 <8185914.90oAZWnb5N@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8185914.90oAZWnb5N@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.de>, Dave Chinner <david@fromorbit.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2015-07-08 00:20:05, Rafael J. Wysocki wrote:
> On Tuesday, July 07, 2015 11:03:20 AM Alan Stern wrote:
> > On Tue, 7 Jul 2015, Oliver Neukum wrote:
> > 
> > > > he (or she) pulls the storage device out of the system, moves it to another
> > > > system, makes changes (say removes the file written to by the process above,
> > > > so the blocks previously occupied by that file are now used for some metadata)
> > > > and moves the storage back to the suspended system.  The system is resumed
> > > > and the writing process continues writing possibly to the wrong blocks and
> > > > corrupts the filesystem.
> > > 
> > > That is a tough nut. But that's not a reason to make it worse.
> > > I'd say there's no reason not to use a secondary interface to
> > > suspend without syncing or to extend or introduce such an interface
> > > if the API is deficient.
> > 
> > Indeed, the problem Rafael outlined always exists whether or not the
> > kernel does a sync.  Even if no I/O is in progress when the system goes
> > to sleep, if the user moves a portable storage device with a mounted
> > filesystem to another computer and updates it before waking the system
> > up, corruption is highly likely.
> > 
> > In principle this could be solved by adding suspend/resume callbacks to
> > filesystems.  For example, the resume callback could verify that the
> > superblock had not been changed since the suspend occurred.  Or there 
> > could be some other simple way of determining that the filesystem had 
> > not been remounted and changed.
> > 
> > Either way, this is irrelevant to the question of whether the kernel 
> > should issue a sync when suspending.
> 
> well, that depends on what the purpose of the sync is supposed to be.
> 
> If it is there to prevent users from corrupting their filesystems as a result
> of a mistake, it is insufficient.  If it's there for other reasons, I'm wondering
> what those reasons are (on systems that suspend and resume reliably, because the
> original reason to put it in there was to reduce the damage from suspend/resume
> crashes).

I put it there, and there were more reasons than "crashes" to put it
there.

1) crashes.

2) battery is quite likely to run out in suspended machine.

3) if someone pulls the stick and puts it in other machine, I wanted
consistent filesystem at least after journal replay.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
