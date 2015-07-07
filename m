From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Wed, 08 Jul 2015 00:11:51 +0200
Message-ID: <1522789.fQO6RUUx40@vostro.rjw.lan>
References: <4290667.ZqInAykFGS@vostro.rjw.lan> <1527037.PaGp0dsCau@vostro.rjw.lan> <1436279906.2658.4.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41378 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932669AbbGGVpY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 17:45:24 -0400
In-Reply-To: <1436279906.2658.4.camel@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Dave Chinner <david@fromorbit.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alan Stern <stern@rowland.harvard.edu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, July 07, 2015 04:38:26 PM Oliver Neukum wrote:
> On Tue, 2015-07-07 at 16:32 +0200, Rafael J. Wysocki wrote:
> > On Tuesday, July 07, 2015 03:16:48 PM Oliver Neukum wrote:
> > > On Tue, 2015-07-07 at 14:14 +0200, Rafael J. Wysocki wrote:
> > > > For example, on desktop systems I use user space syncs filesystems
> > > > before
> > > > writing to /sys/power/state, so the additional sys_sync() in the
> > > > kernel doesn't
> > > > seem to serve any purpose.
> > > 
> > > There is a race you cannot close in user space.
> > 
> > Yes, there is, but I'm not sure how much of a help the sync in the kernel
> > provides here anyway.
> > 
> > Say this happens.  There is a process writing to a file running in parallel
> > with the suspend process.  Suspend starts and that process is frozen.  The
> > sync is called and causes all of the outstanding data to be written back.
> > The user doesn't realize that the write is technically still in progress, so
> 
> Well, in that case the user never got the feedback that the write is
> finished. That is a race that always exists, like sending SIGKILL to a
> running task.
> What you describe is in principle unsolvable every time under
> any circumstances.
> 
> > he (or she) pulls the storage device out of the system, moves it to another
> > system, makes changes (say removes the file written to by the process above,
> > so the blocks previously occupied by that file are now used for some metadata)
> > and moves the storage back to the suspended system.  The system is resumed
> > and the writing process continues writing possibly to the wrong blocks and
> > corrupts the filesystem.
> 
> That is a tough nut. But that's not a reason to make it worse.
> I'd say there's no reason not to use a secondary interface to
> suspend without syncing or to extend or introduce such an interface
> if the API is deficient.

Well, the point here is that the sync we have doesn't prevent all potentially
possible bad things from happening.  It's a partial measure at best in that
respect.

Thanks,
Rafael

