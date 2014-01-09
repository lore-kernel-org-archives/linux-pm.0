From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Allow runtime suspend during system resume
Date: Thu, 9 Jan 2014 11:08:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1401091057550.1493-100000@iolanthe.rowland.org>
References: <52CEC556.7030405@ubuntu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49178 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751497AbaAIQIb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 11:08:31 -0500
In-Reply-To: <52CEC556.7030405@ubuntu.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thu, 9 Jan 2014, Phillip Susi wrote:

> On 1/9/2014 10:32 AM, Alan Stern wrote:
> > I had in mind something more like this for the driver's .resume
> > (or .resume_early) routine:
> > 
> > bool leave_suspended = false; int rc = 0;
> > 
> > if (!pm_runtime_in_use(dev) && !disk_is_spinning(dev)) 
> > leave_suspended = true; else rc = spin_up_the_disk(dev);
> > 
> > if (rc == 0) { pm_runtime_disable(dev); if (leave_suspended) 
> > pm_runtime_set_suspended(dev); else pm_runtime_set_active(dev); 
> > pm_runtime_enable(dev); } return rc;
> 
> We also don't want to block the resume path while the REQUEST SENSE
> runs, since it typically takes 10 seconds or so on normal ATA disks.
> Thus, the resume or resume early needs to be able to return with the
> device left in the transitioning state and complete or abort the
> transition later.

The code will be restructured as part of the asynchronous spin-up 
change.  The resume routine would then look more like this:

	bool test_spinning = !pm_runtime_in_use(dev);

	pm_runtime_disable(dev);
	if (test_spinning)
		pm_runtime_set_suspended(dev);
	else
		pm_runtime_set_active(dev);
	pm_runtime_enable(dev);

	start_async_spin_up(dev, test_spinning);
	return 0;

The asynchronous routine would skip the initial test if its second 
argument is nonzero, and proceed directly to spin-up the disk.

Alan Stern

