From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Freezer: Don't count threads waiting for frozen
 filesystems.
Date: Wed, 29 Oct 2008 09:51:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0810290944240.2515-100000__15507.7517651536$1225288705$gmane$org@iolanthe.rowland.org>
References: <E1Kv688-0007Kp-SN@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1Kv688-0007Kp-SN@pomaz-ex.szeredi.hu>
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

> Not all callbacks.  I don't know what the current model is but AFAIR
> it should be something like this:
> 
>   1) call drivers to prepare for suspend (allocate space, etc)
>   2) stop all driver activity (plug queues, disable interrupts, etc)
>   3) call drivers to actually save state and power down
>   4) suspend
> 
> The part we are concerned is stopping driver activity.  It could be
> done with a mutex, or it could be done by freezing tasks.  Adding a
> mutex or other mechanism is the one I most like, but it's probably the
> biggest work, so lets look at how to fix the freezing:

Not only is adding a mutex the biggest amount of work, it has has the 
largest impact.  Every I/O pathway would have to acquire the 
appropriate mutex.  That's a significant additional load on the system.

> Currently the criteria for freezing is that userspace task has to exit
> kernelspace, and kernel task has to hit a specific "freeze point".
> This causes problems where we want to freeze tasks which are "stuck"
> inside filesystems or other non-driver parts of the kernel.  We can
> fix this two ways:
> 
>   a) mark additional places to freeze for userspace tasks as
>   well. This is the direction Nigel seems to be taking.
> 
>   b) or instead we could allow freezing anywhere in uninterruptible
>   sleep, _except_ where explicity marked.
> 
> Which is easier?  I don't know.  But I very storgly feel that marking
> un-freezable places instead of marking freezable places is a much
> cleaner solution.  It only affects parts of the kernel which have
> something to do with suspend, instead of affecting parts of the kernel
> which have absolutely nothing to do with suspend.

The problem with unrestricted freezing shows up when you freeze tasks
that hold a mutex or other sort of lock.  If this mutex is needed later
on for suspending a device then the suspend will hang, because a frozen
task can't release any mutexes.

I suppose you could try to categorize mutexes as "freezable" and 
"non-freezable".  Ones used by device drives would generally be 
non-freezable, whereas others (such as those used by VFS) would be 
freezable.  Still, it would be pretty difficult.  Among other things, 
it would be necessary to verify that a task holding a non-freezable 
mutex never tries to acquire a freezable mutex.

Alan Stern
