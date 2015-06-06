From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/6] power: user: Standardize "Syncing filesystems ..."
 message
Date: Sat, 6 Jun 2015 15:36:46 +0200
Message-ID: <20150606133646.GB29050@amd>
References: <cover.1433442778.git.joe@perches.com>
 <06fdc51c7d2ab639729107a137b947704fd7d161.1433442778.git.joe@perches.com>
 <20150605103727.GA6054@amd>
 <1433516858.2658.44.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51425 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbbFFNgt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 6 Jun 2015 09:36:49 -0400
Content-Disposition: inline
In-Reply-To: <1433516858.2658.44.camel@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org

On Fri 2015-06-05 08:07:38, Joe Perches wrote:
> On Fri, 2015-06-05 at 12:37 +0200, Pavel Machek wrote:
> > On Thu 2015-06-04 11:36:48, Joe Perches wrote:
> > > Instead of a two individual printks that would generally be
> > > emitted on a single line, emit 2 lines to make the start
> > > and end of the synchronization more easily timeable.
> []
> > > diff --git a/kernel/power/user.c b/kernel/power/user.c
> []
> > > @@ -221,9 +221,9 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
> > >  		if (data->frozen)
> > >  			break;
> > >  
> > > -		printk("Syncing filesystems ... ");
> > > +		printk("Syncing filesystems ...\n");
> > >  		sys_sync();
> > > -		printk("done.\n");
> > > +		printk("Syncing filesystems: done\n");
> > 
> > You converted " ..." -> "..." elsewhere, so why not here?
> 
> Missed that one. 
> 
> > Is splitting message to two lines a good idea?
> 
> I think the "done" is unnecessary actually.

Well... if it is not neccessary for timing, this change can be safely
dropped, as timing will be provided for existing code, too.

> As there's no newline on the first, printk is
> async and can be interleaved by other threads.

...which will probably never happen here, due to feezer.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
