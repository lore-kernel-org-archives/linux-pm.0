From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread
 freezer
Date: Tue, 3 Nov 2015 10:31:33 +0100
Message-ID: <20151103093133.GB4063@quack.suse.cz>
References: <Pine.LNX.4.44L0.1510301637310.1659-100000@iolanthe.rowland.org>
 <6015070.Gclh0s3EvS@vostro.rjw.lan>
 <alpine.LNX.2.00.1510310844360.17538@pobox.suse.cz>
 <2258525.D9qdTJBeTN@vostro.rjw.lan>
 <20151103001053.GL10656@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41546 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbbKCJbi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 3 Nov 2015 04:31:38 -0500
Content-Disposition: inline
In-Reply-To: <20151103001053.GL10656@dastard>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue 03-11-15 11:10:53, Dave Chinner wrote:
> On Mon, Nov 02, 2015 at 03:43:07AM +0100, Rafael J. Wysocki wrote:
> > I guess it may also helps to address the case when a device is removed from a
> > suspended system, written to on another system in the meantime and inserted
> > back into the (still suspended) original system which then is resumed.  Today
> > this is an almost guaranteed data corruption scenario, but if the filesystem in
> > question is properly frozen during suspend, the driver should be able to detect
> > superblock changes during unfreeze.
> 
> Never going to work. There is no guarantee that a write to a
> filesystem by a third party device is going to change the superblock
> (or any metadata in the rest of the filesystem) in any detectable
> way.  Hence freezing filesystems will not prevent Bad Things
> Happening if you do this while your system is suspended.

Agreed, we should never advertise something like this works. OTOH the truth
is that e.g. in ext4 case a simple check in ext4_unfreeze() could catch 90%
of cases where user shot himself in the foot like this (i.e., ext4 driver
will update write time in superblock if it gets mounted somewhere else and
we can check whether that didn't change in ext4_unfreeze()) and refuse to
touch the filesystem... It is not 100% reliable since user could have used
e.g. debuge2fs to arbitrarily modify the filesystem but in such cases they
have to know what they are doing anyway.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
