From: Oliver Neukum <oliver@neukum.org>
Subject: Re: question on resume()
Date: Wed, 31 Jan 2007 11:14:44 +0100 (MET)
Message-ID: <200701311114.55685.oliver@neukum.org>
References: <200701291206.39637.oneukum@suse.de>
	<200701311004.19477.oneukum@suse.de>
	<20070131093653.GA19643@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070131093653.GA19643@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.osdl.org>, Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 31. Januar 2007 10:36 schrieb Pavel Machek:
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
>
> > Isn't that a race until suspend() is called?
> =

> I do not think so.

What about URBs in flight which are waited for with TASK_INTERRUPTIBLE?

> > On resume():
> > =

> > 1. Don't worry about TASK_UNINTERRUPTIBLE
> > 2. Do not restart IO that may call wake_up_interruptible()
> > =

> > When do we restart such IO?
> =

> We reuse signal handling code to do that for us. It is same situation
> as when someone signals task doing I/O.

What happens to tasks in TASK_INTERRUPTIBLE which are frozen?
Are they interrupted and frozen?

	Regards
		Oliver
