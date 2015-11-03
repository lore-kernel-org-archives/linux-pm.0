From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread
 freezer
Date: Tue, 3 Nov 2015 11:10:53 +1100
Message-ID: <20151103001053.GL10656@dastard>
References: <Pine.LNX.4.44L0.1510301637310.1659-100000@iolanthe.rowland.org>
 <6015070.Gclh0s3EvS@vostro.rjw.lan>
 <alpine.LNX.2.00.1510310844360.17538@pobox.suse.cz>
 <2258525.D9qdTJBeTN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2258525.D9qdTJBeTN@vostro.rjw.lan>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 02, 2015 at 03:43:07AM +0100, Rafael J. Wysocki wrote:
> I guess it may also helps to address the case when a device is removed from a
> suspended system, written to on another system in the meantime and inserted
> back into the (still suspended) original system which then is resumed.  Today
> this is an almost guaranteed data corruption scenario, but if the filesystem in
> question is properly frozen during suspend, the driver should be able to detect
> superblock changes during unfreeze.

Never going to work. There is no guarantee that a write to a
filesystem by a third party device is going to change the superblock
(or any metadata in the rest of the filesystem) in any detectable
way.  Hence freezing filesystems will not prevent Bad Things
Happening if you do this while your system is suspended.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
