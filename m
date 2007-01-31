From: Oliver Neukum <oliver@neukum.org>
Subject: Re: question on resume()
Date: Wed, 31 Jan 2007 17:12:51 +0100 (MET)
Message-ID: <200701311713.04104.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0701311048560.3803-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0701311048560.3803-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 31. Januar 2007 16:54 schrieb Alan Stern:
> On Wed, 31 Jan 2007, Pavel Machek wrote:

> > "cease IO"? No, I believe it is enough not to start new I/O. Userspace
> > is frozen at that point, it can't ask you to do I/O.
> =

> There may be I/O requests sitting in a queue, already submitted by
> userspace.  The suspend method should wait for existing I/O to complete
> and stop processing new entries from the queue.

As far as I understand it now, a frozen process will be in the refrigerator.
Thus it cannot be blocking somewhere else in kernel space. Yet we cannot
be sure there's no queued IO, as theres aio.


> > > On resume():
> > > =

> > > 1. Don't worry about TASK_UNINTERRUPTIBLE
> > > 2. Do not restart IO that may call wake_up_interruptible()
> > > =

> > > When do we restart such IO?
> > =

> > We reuse signal handling code to do that for us. It is same situation
> > as when someone signals task doing I/O.
> =

> Again you misunderstood the question.  The driver must start queued I/O
> when its resume() method is called.  It should then be okay for the driver
> to call wake_up_interruptible(), even before tasks are unfrozen.

Isn't there some code in usbfs that'll do homegrown aio and deliver a
signal to a process if io is completed?

	Regards
		Oliver
