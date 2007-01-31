From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: question on resume()
Date: Wed, 31 Jan 2007 10:54:39 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0701311048560.3803-100000@iolanthe.rowland.org>
References: <20070131093653.GA19643@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070131093653.GA19643@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Oliver Neukum <oneukum@suse.de>, Oliver Neukum <oliver@neukum.name>, pm list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 31 Jan 2007, Pavel Machek wrote:

> Hi!
> =

> > > Yes, it will.  The process freezer can only return success if there a=
re no more
> > > TASK_UNINTERRUPTIBLE tasks.  Otherwise it fails (after a timeout).
> > =

> > So, this means, on suspend():
> > =

> > 1. Don't worry about TASK_UNINTERRUPTIBLE
> > 2. Do worry about TASK_INTERRUPTIBLE
> > We have to cease IO and must not call wake_up_interruptible()
> =

> "cease IO"? No, I believe it is enough not to start new I/O. Userspace
> is frozen at that point, it can't ask you to do I/O.

There may be I/O requests sitting in a queue, already submitted by
userspace.  The suspend method should wait for existing I/O to complete
and stop processing new entries from the queue.

> > Isn't that a race until suspend() is called?
> =

> I do not think so.

The part about not calling wake_up_interruptible() is indeed a race.  We =

have:

	1. Task is frozen.
	2. Driver must not call wake_up_interruptible().
	3. Driver's suspend() method is called.

How is the driver supposed to satisfy (2) before (3) has occurred?

In fact this shouldn't matter.  There shouldn't be anything wrong with =

calling wake_up_interruptible() on a frozen task.

> > On resume():
> > =

> > 1. Don't worry about TASK_UNINTERRUPTIBLE
> > 2. Do not restart IO that may call wake_up_interruptible()
> > =

> > When do we restart such IO?
> =

> We reuse signal handling code to do that for us. It is same situation
> as when someone signals task doing I/O.

Again you misunderstood the question.  The driver must start queued I/O
when its resume() method is called.  It should then be okay for the driver
to call wake_up_interruptible(), even before tasks are unfrozen.

Alan Stern
