From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Freezer: Don't count threads waiting for frozen
 filesystems.
Date: Wed, 29 Oct 2008 11:28:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0810291122220.2189-100000__2625.50493139333$1225294452$gmane$org@iolanthe.rowland.org>
References: <E1KvCN9-00081i-KF@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1KvCN9-00081i-KF@pomaz-ex.szeredi.hu>
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

> Actually I was thinking of an rw-semaphore, not a mutex.  But yeah
> that still has scalability problems.  But it could be done with custom
> locking primitives, optimized for this case:
> 
>    suspend_disable();
>    /* driver stuff */
>    suspend_enable();

Yes, it could be done.  And the overhead could be minimized by using
per-CPU variables.  It would still be an awful lot of work, and easy to
get wrong.

> > The problem with unrestricted freezing shows up when you freeze tasks
> > that hold a mutex or other sort of lock.  If this mutex is needed later
> > on for suspending a device then the suspend will hang, because a frozen
> > task can't release any mutexes.
> 
> I did a random sampling of ->suspend() callbacks, and they don't seem
> to be taking mutexes.  Does that happen at all?

It does, particularly among drivers that do runtime PM, which is 
becoming more and more important.

Besides, suspend has to synchronize with I/O somehow.  Right now that 
is handled by making suspend wait until no tasks are doing I/O (because 
they are all frozen).  If you allow tasks to be frozen at more or less 
arbitrary times, while holding arbitrary locks, then you may end up 
freezing a task that's in the middle of I/O.  That should certainly 
block the suspend (not to mention messing up the I/O operation).

> Did anybody ever try modifying the freezer for suspend (not
> hibernate), so that it allows tasks not in running state to freeze?
> If not, I think that's an experiment worth doing.

What happens if the reason the task isn't running is because it's 
waiting for I/O to complete?  I just don't think this can be made to 
work.

Alan Stern
