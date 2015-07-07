From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Wed, 08 Jul 2015 00:20:05 +0200
Message-ID: <8185914.90oAZWnb5N@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1507071058000.1692-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51204 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758068AbbGGVxi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 17:53:38 -0400
In-Reply-To: <Pine.LNX.4.44L0.1507071058000.1692-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>, Dave Chinner <david@fromorbit.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Tuesday, July 07, 2015 11:03:20 AM Alan Stern wrote:
> On Tue, 7 Jul 2015, Oliver Neukum wrote:
> 
> > > he (or she) pulls the storage device out of the system, moves it to another
> > > system, makes changes (say removes the file written to by the process above,
> > > so the blocks previously occupied by that file are now used for some metadata)
> > > and moves the storage back to the suspended system.  The system is resumed
> > > and the writing process continues writing possibly to the wrong blocks and
> > > corrupts the filesystem.
> > 
> > That is a tough nut. But that's not a reason to make it worse.
> > I'd say there's no reason not to use a secondary interface to
> > suspend without syncing or to extend or introduce such an interface
> > if the API is deficient.
> 
> Indeed, the problem Rafael outlined always exists whether or not the
> kernel does a sync.  Even if no I/O is in progress when the system goes
> to sleep, if the user moves a portable storage device with a mounted
> filesystem to another computer and updates it before waking the system
> up, corruption is highly likely.
> 
> In principle this could be solved by adding suspend/resume callbacks to
> filesystems.  For example, the resume callback could verify that the
> superblock had not been changed since the suspend occurred.  Or there 
> could be some other simple way of determining that the filesystem had 
> not been remounted and changed.
> 
> Either way, this is irrelevant to the question of whether the kernel 
> should issue a sync when suspending.

well, that depends on what the purpose of the sync is supposed to be.

If it is there to prevent users from corrupting their filesystems as a result
of a mistake, it is insufficient.  If it's there for other reasons, I'm wondering
what those reasons are (on systems that suspend and resume reliably, because the
original reason to put it in there was to reduce the damage from suspend/resume
crashes).

Thanks,
Rafael

