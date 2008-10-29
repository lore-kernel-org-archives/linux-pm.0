From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Freezer: Don't count threads waiting for frozen
 filesystems.
Date: Wed, 29 Oct 2008 16:37:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0810291627040.3986-100000__4826.92564041844$1225312916$gmane$org@iolanthe.rowland.org>
References: <E1KvDcp-0008B7-SR@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1KvDcp-0008B7-SR@pomaz-ex.szeredi.hu>
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
> > 
> > > Actually I was thinking of an rw-semaphore, not a mutex.  But yeah
> > > that still has scalability problems.  But it could be done with custom
> > > locking primitives, optimized for this case:
> > > 
> > >    suspend_disable();
> > >    /* driver stuff */
> > >    suspend_enable();
> > 
> > Yes, it could be done.  And the overhead could be minimized by using
> > per-CPU variables.  It would still be an awful lot of work, and easy to
> > get wrong.
> 
> OK, getting back to this, as it seems to be the only way that we agree
> is doable.
> 
> How about this,
> 
>  a) identify syscalls that may make drivers do I/O:
> 
>  - read
>  - write
>  - ioctl
>  ???
> 
>  b) add the suspend_disable/enable() primitives to these syscalls
> 
>  c) push primitives inside the implementation

I discussed this last summer with Rafael.  It's a lot harder than it 
looks, for all sorts of reasons.  For example, what about user tasks 
that have access to memory-mapped I/O regions?

> c) is slightly tricky, but could be done for example by setting a flag
> on open: FMODE_NO_SUSPEND_DISABLE (better name required), saying that
> implementation is responsible for getting the suspend disable magic
> right.
> 
> For starters this flag could be set for all non-device opens (maybe all
> non-char-dev opens?), solving the fuse vs. freezer issues without any
> complicated trickery.

I don't know.  There are other interfaces too, like sysfs attributes, 
that would have to be handled specially.  On the whole, the freezer 
seems much, much simpler.

Regarding fuse, something like Nigel's scheme for preventing new 
requests and then waiting for old requests to complete might work out.  
Especially if you combine it with a strategy for making the freezer 
back and retry after a delay when something goes wrong.

Alan Stern
