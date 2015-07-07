From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Tue, 7 Jul 2015 11:03:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1507071058000.1692-100000@iolanthe.rowland.org>
References: <1436279906.2658.4.camel@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33405 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932360AbbGGPDV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 11:03:21 -0400
In-Reply-To: <1436279906.2658.4.camel@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Chinner <david@fromorbit.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Tue, 7 Jul 2015, Oliver Neukum wrote:

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

Indeed, the problem Rafael outlined always exists whether or not the
kernel does a sync.  Even if no I/O is in progress when the system goes
to sleep, if the user moves a portable storage device with a mounted
filesystem to another computer and updates it before waking the system
up, corruption is highly likely.

In principle this could be solved by adding suspend/resume callbacks to
filesystems.  For example, the resume callback could verify that the
superblock had not been changed since the suspend occurred.  Or there 
could be some other simple way of determining that the filesystem had 
not been remounted and changed.

Either way, this is irrelevant to the question of whether the kernel 
should issue a sync when suspending.

Alan Stern

