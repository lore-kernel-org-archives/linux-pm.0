From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread
 freezer
Date: Sat, 31 Oct 2015 12:01:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1510311157420.9118-100000@netrider.rowland.org>
References: <6015070.Gclh0s3EvS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6015070.Gclh0s3EvS@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiri Kosina <jikos@kernel.org>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 31 Oct 2015, Rafael J. Wysocki wrote:

> Runtime PM uses a freezable workqueue, allocated in pm_start_workqueue().
> 
> That's because we don't want async runtime PM to happen during system
> suspend/resume and for good reasons, so if you want to remove the freezing
> mechanism, you need to stop that workqueue at the beginning of dpm_prepare
> and start it again at the end of dpm_complete().

The same sort of thing is true for the USB hub driver's workqueue.  
Since it registers new devices (as a result of hotplugs), it must stop
running at the beginning of the dpm_prepare stage.  Of course, that's
also a workqueue and not a kthread.

Alan Stern
