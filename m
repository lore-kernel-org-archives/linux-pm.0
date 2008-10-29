From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for frozen
 filesystems.
Date: Wed, 29 Oct 2008 17:10:27 +0100
Message-ID: <E1KvDcp-0008B7-SR__20173.6586205245$1225296951$gmane$org@pomaz-ex.szeredi.hu>
References: <Pine.LNX.4.44L0.0810291122220.2189-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <Pine.LNX.4.44L0.0810291122220.2189-100000@iolanthe.rowland.org>
	(message from Alan Stern on Wed, 29 Oct 2008 11:28:34 -0400 (EDT))
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
> > Actually I was thinking of an rw-semaphore, not a mutex.  But yeah
> > that still has scalability problems.  But it could be done with custom
> > locking primitives, optimized for this case:
> > 
> >    suspend_disable();
> >    /* driver stuff */
> >    suspend_enable();
> 
> Yes, it could be done.  And the overhead could be minimized by using
> per-CPU variables.  It would still be an awful lot of work, and easy to
> get wrong.

OK, getting back to this, as it seems to be the only way that we agree
is doable.

How about this,

 a) identify syscalls that may make drivers do I/O:

 - read
 - write
 - ioctl
 ???

 b) add the suspend_disable/enable() primitives to these syscalls

 c) push primitives inside the implementation

c) is slightly tricky, but could be done for example by setting a flag
on open: FMODE_NO_SUSPEND_DISABLE (better name required), saying that
implementation is responsible for getting the suspend disable magic
right.

For starters this flag could be set for all non-device opens (maybe all
non-char-dev opens?), solving the fuse vs. freezer issues without any
complicated trickery.

Miklos
