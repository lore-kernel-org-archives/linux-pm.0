From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Tue, 07 Jul 2015 16:32:08 +0200
Message-ID: <1527037.PaGp0dsCau@vostro.rjw.lan>
References: <4290667.ZqInAykFGS@vostro.rjw.lan> <1652992.e7VOEWpWyZ@vostro.rjw.lan> <1436275008.4460.18.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436275008.4460.18.camel@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alan Stern <stern@rowland.harvard.edu>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 07, 2015 03:16:48 PM Oliver Neukum wrote:
> On Tue, 2015-07-07 at 14:14 +0200, Rafael J. Wysocki wrote:
> > For example, on desktop systems I use user space syncs filesystems
> > before
> > writing to /sys/power/state, so the additional sys_sync() in the
> > kernel doesn't
> > seem to serve any purpose.
> 
> There is a race you cannot close in user space.

Yes, there is, but I'm not sure how much of a help the sync in the kernel
provides here anyway.

Say this happens.  There is a process writing to a file running in parallel
with the suspend process.  Suspend starts and that process is frozen.  The
sync is called and causes all of the outstanding data to be written back.
The user doesn't realize that the write is technically still in progress, so
he (or she) pulls the storage device out of the system, moves it to another
system, makes changes (say removes the file written to by the process above,
so the blocks previously occupied by that file are now used for some metadata)
and moves the storage back to the suspended system.  The system is resumed
and the writing process continues writing possibly to the wrong blocks and
corrupts the filesystem.

Is this possible?  If not, why not?

Rafael
