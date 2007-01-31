From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: question on resume()
Date: Wed, 31 Jan 2007 09:33:28 +0100
Message-ID: <200701310933.29443.rjw@sisk.pl>
References: <200701291206.39637.oneukum@suse.de>
	<200701301750.48196.oliver@neukum.name>
	<200701302332.26063.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200701302332.26063.rjw@sisk.pl>
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
To: Oliver Neukum <oliver@neukum.name>
Cc: pm list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 30 January 2007 23:32, Rafael J. Wysocki wrote:
> [Added linux-pm to the Cc list, because I'm going to talk about things th=
at
> I know only from reading the code.]
> =

> On Tuesday, 30 January 2007 17:50, Oliver Neukum wrote:
> > Am Dienstag, 30. Januar 2007 17:32 schrieb Rafael J. Wysocki:
> > > However, you can always inspect the PF_FROZEN flag of the tasks in qu=
estion
> > > if that's practicable.
> > =

> > What would I do with that information? Ignore completion of IO?
> =

> I probably should say "that depends", but that wouldn't be very helpful.
> =

> Getting back to your initial question, which is if wake_up() may be called
> from a driver's .resume() routine, I think the answer is no, it may not,
> because in that case the "notified" tasks would be removed from the wait
> queue, but the refrigerator() would (wrongly) restore their states as
> TASK_UNINTERRUPTIBLE (or TASK_INTERRUPTIBLE for wake_up_interruptible()).
> =

> Generally, you are safe if your driver only calls wake_up() from a process
> context, but not from .resume() or .suspend() routines (or from an
> unfreezeable kernel thread).

Ah, sorry, I've just realized I was wrong.  Processes in TASK_UNINTERRUPTIB=
LE
cannot be frozen!  So, the above only applies to wake_up_interruptible().

You don't need to call wake_up() from .resume(), because there are no tasks
to be notified this way and you shouldn't call wake_up_interruptible() from
there.

Greetings,
Rafael


-- =

If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
