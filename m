From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Fri, 13 Jul 2007 14:15:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707131402001.2684-100000__37105.4345429458$1184350602$gmane$org@iolanthe.rowland.org>
References: <m1fy3sdz1p.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1fy3sdz1p.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 13 Jul 2007, Eric W. Biederman wrote:

> > I doubt that re-probing devices will work.  The probe routine won't 
> > expect there to be any registered children, so it will try to 
> > re-register them.
> 
> So really unregister the children.  All we really need to do is disassociate
> the drivers from the devices (to reuse the existing code) we don't
> need to rescan for the devices.  The associating the device drivers
> with devices takes human measurable amount of time.  The only thing
> that takes time is waiting on hardware.  Maybe things will suck
> and associating the drivers with the device tree with take a whole
> second on a bad day, I don't think that is enough time to add
> complicated new code paths for the drivers to maintain.

This would be even worse!

Suppose you unbind (or unregister, either way) a disk driver.  It's 
unbind method will unregister the gendisk structure, thereby deleting 
all the partitions and block devices associated with the disk.  This 
will leave any and all memory mappings dangling in the breeze.  When 
the kernel resumes from hibernation, nothing will work.

> > On the other hand, post_restore methods could be written to expect 
> > something like this.
> 
> Please Please Plaese do not start with the existing software suspend
> to disk code and thinking.

Ha!  Gotcha.  You evidently haven't been reading the linux-pm mailing 
list for the last few months.  :-)

     1. post_restore isn't "existing software suspend to disk code"
	(you're supposed to call it "hibernation" now, BTW).

     2. post_restore isn't new.  It has already been proposed and
	generally accepted.  It is part of the movement to untangle
	and separate the suspend and hibernate code paths.

     3. post_restore hasn't been implemented yet.  It's barely past
	the proposal stage.

     4. Maybe _you_ like to discuss complicated issues such as this
	one without thinking, but the rest of us prefer a little 
	cerebration.

>  We are not implementing suspend to ram
> here or anything like it.

One of the topics in this discussion has been "suspend-to-both", which
includes suspend-to-RAM.  

But anyway, so what?  I wasn't talking about suspend-to-RAM; I was
talking about hibernation.

>  We already have proven code paths that
> know how to quiesce hardware.  We already have proven code paths
> that know how to take quite hardware and make it run.  Please let's
> just use them.  At least until we can see that they are insufficient
> to the task.

Was this request directed at me or at Rafael?  It's hard to tell.

Alan Stern
