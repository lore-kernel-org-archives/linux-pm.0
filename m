From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Allow runtime suspend during system resume
Date: Thu, 9 Jan 2014 12:04:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1401091201390.1493-100000@iolanthe.rowland.org>
References: <52CECEBA.5090908@ubuntu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49246 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752399AbaAIREb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 12:04:31 -0500
In-Reply-To: <52CECEBA.5090908@ubuntu.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thu, 9 Jan 2014, Phillip Susi wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 1/9/2014 11:08 AM, Alan Stern wrote:
> > The code will be restructured as part of the asynchronous spin-up 
> > change.  The resume routine would then look more like this:
> > 
> > bool test_spinning = !pm_runtime_in_use(dev);
> > 
> > pm_runtime_disable(dev); if (test_spinning) 
> > pm_runtime_set_suspended(dev); else pm_runtime_set_active(dev); 
> > pm_runtime_enable(dev);
> > 
> > start_async_spin_up(dev, test_spinning); return 0;
> > 
> > The asynchronous routine would skip the initial test if its second
> >  argument is nonzero, and proceed directly to spin-up the disk.
> 
> It isn't enough to background the spin up; the TEST will block, so it
> needs to be async as well.

That's what I meant.  If the second argument is zero, the asynchronous 
routine will first test whether the disk is spinning.  If it is, the 
status will be set to RPM_ACTIVE.  (The routine may also send a START 
command -- for some disks this may be necessary.)

Alan Stern

