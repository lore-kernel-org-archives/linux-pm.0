From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: question on resume()
Date: Wed, 31 Jan 2007 11:27:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0701311124200.3803-100000@iolanthe.rowland.org>
References: <200701311713.04104.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200701311713.04104.oliver@neukum.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Oliver Neukum <oliver@neukum.org>
Cc: pm list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, 31 Jan 2007, Oliver Neukum wrote:

> Am Mittwoch, 31. Januar 2007 16:54 schrieb Alan Stern:
> > On Wed, 31 Jan 2007, Pavel Machek wrote:
> =

> > > "cease IO"? No, I believe it is enough not to start new I/O. Userspace
> > > is frozen at that point, it can't ask you to do I/O.
> > =

> > There may be I/O requests sitting in a queue, already submitted by
> > userspace.  The suspend method should wait for existing I/O to complete
> > and stop processing new entries from the queue.
> =

> As far as I understand it now, a frozen process will be in the refrigerat=
or.
> Thus it cannot be blocking somewhere else in kernel space. Yet we cannot
> be sure there's no queued IO, as theres aio.

Or the driver may maintain its own I/O queue, like the HID driver does.

> > > > On resume():
> > > > =

> > > > 1. Don't worry about TASK_UNINTERRUPTIBLE
> > > > 2. Do not restart IO that may call wake_up_interruptible()
> > > > =

> > > > When do we restart such IO?
> > > =

> > > We reuse signal handling code to do that for us. It is same situation
> > > as when someone signals task doing I/O.
> > =

> > Again you misunderstood the question.  The driver must start queued I/O
> > when its resume() method is called.  It should then be okay for the dri=
ver
> > to call wake_up_interruptible(), even before tasks are unfrozen.
> =

> Isn't there some code in usbfs that'll do homegrown aio and deliver a
> signal to a process if io is completed?

That's right.  There's also code in the hub driver to call wake_up() on =

the khubd thread when certain I/O operations complete; nevertheless khubd =

_should_ remain frozen along with all the other tasks.

Alan Stern
