From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Freezer: Don't count threads waiting for frozen
 filesystems.
Date: Wed, 29 Oct 2008 12:17:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0810291204380.2180-100000__44304.9076748595$1225297298$gmane$org@iolanthe.rowland.org>
References: <E1KvDJp-00088f-2b@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1KvDJp-00088f-2b@pomaz-ex.szeredi.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: ncunningham@crca.org.au, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 29 Oct 2008, Miklos Szeredi wrote:

> On Wed, 29 Oct 2008, Alan Stern wrote:
> > On Wed, 29 Oct 2008, Miklos Szeredi wrote:
> > > I did a random sampling of ->suspend() callbacks, and they don't seem
> > > to be taking mutexes.  Does that happen at all?
> > 
> > It does, particularly among drivers that do runtime PM, which is 
> > becoming more and more important.
> > 
> > Besides, suspend has to synchronize with I/O somehow.  Right now that 
> > is handled by making suspend wait until no tasks are doing I/O (because 
> > they are all frozen).
> 
> What about async I/O?

I don't know.  Maybe it slipped through the cracks.  It wouldn't be 
surprising to find that async I/O can get messed up during a suspend.

> >  If you allow tasks to be frozen at more or less 
> > arbitrary times, while holding arbitrary locks, then you may end up 
> > freezing a task that's in the middle of I/O.  That should certainly 
> > block the suspend (not to mention messing up the I/O operation).
> 
> What is the middle of I/O?  Depending the type of I/O it could be
> messed up regardless of whether tasks happen to be in userspace or not
> (e.g. printing).

I'll wriggle out of this by saying that "in the middle of I/O" means
the task has gotten a device into a state from which it can't
successfully be suspended.  An example would be if the system had sent
the device part of a command.  Even if you did manage to suspend the
device and resume it later, you wouldn't expect it to work right when
it received the second half of the command.

In general, drivers don't leave devices in this kind of intermediate
state for long.  A driver might sleep at such times, but it wouldn't 
return to userspace.

> And some types of I/O are already mostly decoupled from userspace
> (file I/O, networking), so the userspace freezing shoudln't make any
> difference.

True.  We're mostly talking about character device I/O.  There are a 
lot of character device drivers in the kernel.  :-)

> > > Did anybody ever try modifying the freezer for suspend (not
> > > hibernate), so that it allows tasks not in running state to freeze?
> > > If not, I think that's an experiment worth doing.
> > 
> > What happens if the reason the task isn't running is because it's 
> > waiting for I/O to complete?  I just don't think this can be made to 
> > work.
> 
> Don't know.  I've never written a driver, and I'm not familiar with
> runtime PM, etc.  So I can't come up with a detailed design for
> solving the freezer issues there.
> 
> But I do think that the solution does not lie in "fixing" the VFS.

I tend to agree.  The problems posed by fuse are very difficult.  It is 
not at all obvious how to attack them.

Alan Stern
