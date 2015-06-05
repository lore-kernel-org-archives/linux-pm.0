From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 5/6] power: user: Standardize "Syncing filesystems ..."
 message
Date: Fri, 05 Jun 2015 08:07:38 -0700
Message-ID: <1433516858.2658.44.camel@perches.com>
References: <cover.1433442778.git.joe@perches.com>
	 <06fdc51c7d2ab639729107a137b947704fd7d161.1433442778.git.joe@perches.com>
	 <20150605103727.GA6054@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150605103727.GA6054@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2015-06-05 at 12:37 +0200, Pavel Machek wrote:
> On Thu 2015-06-04 11:36:48, Joe Perches wrote:
> > Instead of a two individual printks that would generally be
> > emitted on a single line, emit 2 lines to make the start
> > and end of the synchronization more easily timeable.
[]
> > diff --git a/kernel/power/user.c b/kernel/power/user.c
[]
> > @@ -221,9 +221,9 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
> >  		if (data->frozen)
> >  			break;
> >  
> > -		printk("Syncing filesystems ... ");
> > +		printk("Syncing filesystems ...\n");
> >  		sys_sync();
> > -		printk("done.\n");
> > +		printk("Syncing filesystems: done\n");
> 
> You converted " ..." -> "..." elsewhere, so why not here?

Missed that one. 

> Is splitting message to two lines a good idea?

I think the "done" is unnecessary actually.

As there's no newline on the first, printk is
async and can be interleaved by other threads.
