From: Oliver Neukum <oneukum@suse.de>
Subject: Re: question on resume()
Date: Wed, 31 Jan 2007 10:04:08 +0100 (MET)
Message-ID: <200701311004.19477.oneukum@suse.de>
References: <200701291206.39637.oneukum@suse.de>
	<200701310940.26040.oliver@neukum.name>
	<200701310949.04110.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200701310949.04110.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.name>, pm list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 31. Januar 2007 09:49 schrieb Rafael J. Wysocki:
> On Wednesday, 31 January 2007 09:40, Oliver Neukum wrote:
> > Am Mittwoch, 31. Januar 2007 09:33 schrieb Rafael J. Wysocki:
> > > On Tuesday, 30 January 2007 23:32, Rafael J. Wysocki wrote:
> > =

> > > > Generally, you are safe if your driver only calls wake_up() from a =
process
> > > > context, but not from .resume() or .suspend() routines (or from an
> > > > unfreezeable kernel thread).
> > > =

> > > Ah, sorry, I've just realized I was wrong.  Processes in TASK_UNINTER=
RUPTIBLE
> > > cannot be frozen!  So, the above only applies to wake_up_interruptibl=
e().
> > =

> > So the kernel will wait for tasks in TASK_UNINTERRUPTIBLE to finish IO
> > before it calls suspend()? I am confused.
> =

> Yes, it will.  The process freezer can only return success if there are n=
o more
> TASK_UNINTERRUPTIBLE tasks.  Otherwise it fails (after a timeout).

So, this means, on suspend():

1. Don't worry about TASK_UNINTERRUPTIBLE
2. Do worry about TASK_INTERRUPTIBLE
We have to cease IO and must not call wake_up_interruptible()

Isn't that a race until suspend() is called?

On resume():

1. Don't worry about TASK_UNINTERRUPTIBLE
2. Do not restart IO that may call wake_up_interruptible()

When do we restart such IO?

	Regards
		Oliver
