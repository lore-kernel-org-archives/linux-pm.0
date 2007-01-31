From: Oliver Neukum <oliver@neukum.name>
Subject: Re: question on resume()
Date: Wed, 31 Jan 2007 09:40:14 +0100 (MET)
Message-ID: <200701310940.26040.oliver@neukum.name>
References: <200701291206.39637.oneukum@suse.de>
	<200701302332.26063.rjw@sisk.pl> <200701310933.29443.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200701310933.29443.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 31. Januar 2007 09:33 schrieb Rafael J. Wysocki:
> On Tuesday, 30 January 2007 23:32, Rafael J. Wysocki wrote:

> > Generally, you are safe if your driver only calls wake_up() from a proc=
ess
> > context, but not from .resume() or .suspend() routines (or from an
> > unfreezeable kernel thread).
> =

> Ah, sorry, I've just realized I was wrong.  Processes in TASK_UNINTERRUPT=
IBLE
> cannot be frozen!  So, the above only applies to wake_up_interruptible().

So the kernel will wait for tasks in TASK_UNINTERRUPTIBLE to finish IO
before it calls suspend()? I am confused.

	Regards
		Oliver
