From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL] libata fixes for v3.13-rc5
Date: Wed, 25 Dec 2013 09:57:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1312250955470.9215-100000@netrider.rowland.org>
References: <38559427.MeFx9E3dcV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:55941 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752087Ab3LYO5K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Dec 2013 09:57:10 -0500
In-Reply-To: <38559427.MeFx9E3dcV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 25 Dec 2013, Rafael J. Wysocki wrote:

> On Tuesday, December 24, 2013 04:55:46 PM Alan Stern wrote:
> > On Tue, 24 Dec 2013, Tejun Heo wrote:
> > 
> > > Hello, Linus.
> > > 
> > > libata fixes for v3.13-rc5.  There's one interseting commit - "libata,
> > > freezer: avoid block device removal while system is frozen".  It's an
> > > ugly hack working around a deadlock condition between driver core
> > > resume and block layer device removal paths through freezer which was
> > > made more reproducible by writeback being converted to workqueue some
> > > releases ago.  The bug has nothing to do with libata but it's just an
> > > workaround which is easy to backport.  After discussion, Rafael and I
> > > seem to agree that we don't really need kernel freezables - both
> > > kthread and workqueue.  There are few specific workqueues which
> > > constitute PM operations and require freezing, which will be converted
> > > to use workqueue_set_max_active() instead.  All other kernel freezer
> > > uses are planned to be removed, followed by the removal of kthread and
> > > workqueue freezer support, hopefully.
> > 
> > Wait a minute.  I don't recall anybody mentioning this earlier.  What 
> > about khubd?  There isn't any plan to remove _it_.
> 
> No, but we are going to replace the freezing of kernel stuff with something
> more direct, like "suspend" routines called from the system suspend code path
> and causing things to stop (and corresponding "resume" starting them again).

Is this discussed in more detail somewhere (an email thread, for
example)?

Alan Stern

