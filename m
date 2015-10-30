From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread
 freezer
Date: Fri, 30 Oct 2015 20:40:32 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1510302036140.17538@pobox.suse.cz>
References: <alpine.LNX.2.00.1510301424360.17538@pobox.suse.cz> <Pine.LNX.4.44L0.1510301121340.1659-100000@iolanthe.rowland.org> <20151030174417.GA16781@amd>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151030174417.GA16781@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 30 Oct 2015, Pavel Machek wrote:

> > I would say instead "no I/O is allowed from now on".  Maybe that's an 
> > overstatement, but I think it comes closer to the truth.

But that's what PM callbacks are for.

> Exactly. And I'm pretty sure hardware drivers do use kernel threads,
> and do I/O from them.
> 
> LEDs are just one example

And why is that relevant? First, I don't see any freezable kthread in leds 
class implementation whatsoever. Second, I am pretty sure that it's quite 
unlikely to participate in filesystem I/O.

Sure, you need to suspend and resume the devices when going through 
suspend. That's why led_suspend() exists. How would try_to_freeze() help 
at all? That's basically just a fancy schedule() called at certain points.

-- 
Jiri Kosina
SUSE Labs
