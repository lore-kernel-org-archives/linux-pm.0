From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Freezer: Don't count threads waiting for frozen
 filesystems.
Date: Thu, 30 Oct 2008 13:07:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0810301301540.2513-100000__37185.0742064$1225386748$gmane$org@iolanthe.rowland.org>
References: <E1KvYgR-0002Cx-AZ@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1KvYgR-0002Cx-AZ@pomaz-ex.szeredi.hu>
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

On Thu, 30 Oct 2008, Miklos Szeredi wrote:

> On Thu, 30 Oct 2008, Alan Stern wrote:
> > On Thu, 30 Oct 2008, Miklos Szeredi wrote:
> > 
> > > On Wed, 29 Oct 2008, Alan Stern wrote:
> > > > I discussed this last summer with Rafael.  It's a lot harder than it 
> > > > looks, for all sorts of reasons.  For example, what about user tasks 
> > > > that have access to memory-mapped I/O regions?
> > > 
> > > What about them?  Freezing doesn't seem to help with that.
> > 
> > Sure it does.  A frozen process can't touch a memory-mapped I/O region, 
> > whereas a non-frozen process can.
> 
> But it can be in the middle of I/O by your definition.

True.  Yet another problem...

> > Would you like to write a first-pass patch?  I don't think it will 
> > work.
> 
> If somebody doesn't beat me to it, I'll do that (first implemented
> with a global rw-sem).

Converting it to per-CPU counters later on should be fairly easy.

> > Doing that seems like a lot of work, just as modifying every driver 
> > does.  Changing a few kernel entry points is simpler, but I'm pretty
> > sure it won't work.  For instance, tasks can block arbitrarily long on 
> > read calls (waiting for data to arrive); you can't allow such things to 
> > prevent the system from suspending.
> 
> But we already do: either
> 
>  a) it's in interruptible sleep (I/O on sockets, pipes, etc), and
>     freezing simply interrupts it, or
> 
>  b) it's in uninterruptible sleep and suspend will wait it out (or
>     time out).
> 
> In the new scheme we could retain that part of the freezer: interrupt
> all tasks which are inside the critical region and wait for them to
> exit the critical region.
> 
> To put it in another way: it's still the freezer, it does all the same
> things as the old freezer, except that the condition for freezing is
> not that the task is out of the kernel, rather that it's out of the
> disable_supend - enable_suspend region.  As such it's not a big change
> to the whole suspend system, and so there shouldn't be anything big
> going wrong there.

Okay.  Don't forget things like ioctl for sockets -- they often involve 
doing I/O directly to the network interface device.

What happens to a task accessing a non-regular file on a fuse 
filesystem?  :-)

Alan Stern
