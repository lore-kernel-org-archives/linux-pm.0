From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Thu, 8 Oct 2015 17:50:06 +0200
Message-ID: <20151008155006.GB11776@xo-6d-61-c0.localdomain>
References: <1436927091-32520-1-git-send-email-lenb@kernel.org>
 <1437555322.5445.2.camel@suse.com>
 <CAJvTdKmAvygm9dt4qJetvRLeh-6pmPKP_rBd-xfFW-30_sQpXg@mail.gmail.com>
 <1708156.vTh2kYamEW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1708156.vTh2kYamEW@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Brown, Len" <len.brown@intel.com>, Austin S Hemmelgarn <ahferroin7@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat 2015-08-01 01:56:19, Rafael J. Wysocki wrote:
> On Friday, July 31, 2015 12:02:36 PM Len Brown wrote:
> > On Wed, Jul 22, 2015 at 4:55 AM, Oliver Neukum <oneukum@suse.com> wrote:
> > > On Wed, 2015-07-22 at 03:25 +0200, Rafael J. Wysocki wrote:
> > >> And it is more pain for me to change the user space on each of them to
> > >> write to the new sysfs file on every boot than to set a kernel Kconfig
> > >> option once.
> > >
> > > So why at all? If you really need this in sysfs, why not write
> > > something like "memfast" into /sys/power/state ?
> > 
> > We fought this battle, and lost.
> > 
> > When we came out with "freeze", which is faster than "mem",
> > no user-space changed to take advantage of it.
> 
> I do think that Chrome is going to use "freeze", so maybe it's not a lost
> battle after all?
> 
> The problem with "memfast" and similar things is we'd also need "freezefast"
> and "standbyfast" then, for consistency if nothing else, which makes a little
> sense to me.
> 
> BTW, it should be noted that the whole "sync in the kernel is better, because
> it doesn't race with user space writing to disks" argument was completely
> bogus and useless, because in fact the sync in the kernel is done before
> freezing user space and which means that it is susceptible to the very same
> race condition as the sync from user space.

That seems like a bug to me... when did that start happening? I'm pretty sure
it was originally done after freeze...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
