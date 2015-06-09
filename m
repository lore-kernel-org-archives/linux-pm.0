From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/6] power: hibernate: Use separate messages for "Syncing
 filesystems"
Date: Tue, 9 Jun 2015 11:20:09 +0200
Message-ID: <20150609092009.GA5926@amd>
References: <cover.1433442778.git.joe@perches.com>
 <1664a8ea72b34db4bef860004166875ab70898ee.1433442778.git.joe@perches.com>
 <5609150.OAJVFt04xE@vostro.rjw.lan>
 <1433805804.2730.22.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433805804.2730.22.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon 2015-06-08 16:23:24, Joe Perches wrote:
> On Tue, 2015-06-09 at 01:35 +0200, Rafael J. Wysocki wrote:
> > On Thursday, June 04, 2015 11:36:44 AM Joe Perches wrote:
> > > Add the ability to see how long it takes to sync the filesystems
> > > via the printk time mechanism.
> > > 
> > > Start to standardize the printk "PM: doing something...done"
> > > messages on two separate lines.
> > 
> > Well, it would be good to say what problem this is attempting to fix.
> > 
> > And while I understand the underlying concern, there is a merit in keeping
> > each of these messages in one line (if everything goes well), so I'm wondering
> > what about printing each of them in one go after the operation with a tail
> > depending on the result?  Like
> > 
> > printk(KERN_INFO "PM: Syncing filesystems ... done\n");
> > 
> > on success or
> > 
> > printk(KERN_INFO "PM: Syncing filesystems ... failed\n");
> > 
> > on failure?
> 
> Maybe.
> 
> I believe there are multi-second delays possible when
> syncing the filesystems on things like usb memory sticks.
> 
> I think the dmesg line count here isn't particularly important
> and there's some small value in consistently presenting timing
> information via dmesg timestamps when using 2 lines.

Hibernation is little special here, because that's what user actually
sees, and because message interleaving is extremely unlikely there.

Unless you have a real problem with this, just let it be.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
