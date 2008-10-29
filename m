From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for frozen
 filesystems.
Date: Wed, 29 Oct 2008 15:50:11 +0100
Message-ID: <E1KvCN9-00081i-KF__33789.3913653263$1225292436$gmane$org@pomaz-ex.szeredi.hu>
References: <Pine.LNX.4.44L0.0810290944240.2515-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <Pine.LNX.4.44L0.0810290944240.2515-100000@iolanthe.rowland.org>
	(message from Alan Stern on Wed, 29 Oct 2008 09:51:34 -0400 (EDT))
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stern@rowland.harvard.edu
Cc: ncunningham@crca.org.au, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, miklos@szeredi.hu
List-Id: linux-pm@vger.kernel.org

On Wed, 29 Oct 2008, Alan Stern wrote:
> On Wed, 29 Oct 2008, Miklos Szeredi wrote:
> 
> > Not all callbacks.  I don't know what the current model is but AFAIR
> > it should be something like this:
> > 
> >   1) call drivers to prepare for suspend (allocate space, etc)
> >   2) stop all driver activity (plug queues, disable interrupts, etc)
> >   3) call drivers to actually save state and power down
> >   4) suspend
> > 
> > The part we are concerned is stopping driver activity.  It could be
> > done with a mutex, or it could be done by freezing tasks.  Adding a
> > mutex or other mechanism is the one I most like, but it's probably the
> > biggest work, so lets look at how to fix the freezing:
> 
> Not only is adding a mutex the biggest amount of work, it has has the 
> largest impact.  Every I/O pathway would have to acquire the 
> appropriate mutex.  That's a significant additional load on the system.

Actually I was thinking of an rw-semaphore, not a mutex.  But yeah
that still has scalability problems.  But it could be done with custom
locking primitives, optimized for this case:

   suspend_disable();
   /* driver stuff */
   suspend_enable();

> The problem with unrestricted freezing shows up when you freeze tasks
> that hold a mutex or other sort of lock.  If this mutex is needed later
> on for suspending a device then the suspend will hang, because a frozen
> task can't release any mutexes.

I did a random sampling of ->suspend() callbacks, and they don't seem
to be taking mutexes.  Does that happen at all?

Did anybody ever try modifying the freezer for suspend (not
hibernate), so that it allows tasks not in running state to freeze?
If not, I think that's an experiment worth doing.

Miklos
