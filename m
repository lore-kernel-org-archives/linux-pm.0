From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] question on resume()
Date: Wed, 31 Jan 2007 19:52:36 +0100
Message-ID: <200701311952.36736.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0701311042340.3803-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932969AbXAaSwA@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0701311042340.3803-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.name>, pm list <linux-pm@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 31 January 2007 16:48, Alan Stern wrote:
> On Wed, 31 Jan 2007, Rafael J. Wysocki wrote:
> 
> > On Tuesday, 30 January 2007 23:32, Rafael J. Wysocki wrote:
> > > [Added linux-pm to the Cc list, because I'm going to talk about things that
> > > I know only from reading the code.]
> > > 
> > > On Tuesday, 30 January 2007 17:50, Oliver Neukum wrote:
> > > > Am Dienstag, 30. Januar 2007 17:32 schrieb Rafael J. Wysocki:
> > > > > However, you can always inspect the PF_FROZEN flag of the tasks in question
> > > > > if that's practicable.
> > > > 
> > > > What would I do with that information? Ignore completion of IO?
> > > 
> > > I probably should say "that depends", but that wouldn't be very helpful.
> > > 
> > > Getting back to your initial question, which is if wake_up() may be called
> > > from a driver's .resume() routine, I think the answer is no, it may not,
> > > because in that case the "notified" tasks would be removed from the wait
> > > queue, but the refrigerator() would (wrongly) restore their states as
> > > TASK_UNINTERRUPTIBLE (or TASK_INTERRUPTIBLE for wake_up_interruptible()).
> 
> Even though I'm late to this thread, here are some additional thoughts...
> 
> Rafael is wrong; wake_up() doesn't remove a task from a wait queue.  It 
> makes the task runnable, and then the task removes itself from the wait 
> queue after verifying that the necessary condition has been satisfied.
> 
> Thus calling wake_up() on a task in the refrigerator will accomplish 
> nothing -- no good and no harm.  The task will remain frozen, and when it 
> is unfrozen it will realize that the condition has been satisfied and will 
> remove itself from the wait queue.

That's the point I wasn't quite sure of.

> > > Generally, you are safe if your driver only calls wake_up() from a process
> > > context, but not from .resume() or .suspend() routines (or from an
> > > unfreezeable kernel thread).
> > 
> > Ah, sorry, I've just realized I was wrong.  Processes in TASK_UNINTERRUPTIBLE
> > cannot be frozen!  So, the above only applies to wake_up_interruptible().
> > 
> > You don't need to call wake_up() from .resume(), because there are no tasks
> > to be notified this way and you shouldn't call wake_up_interruptible() from
> > there.
> 
> While it's true that one doesn't need to call wake_up() from .resume(),
> you are overlooking the point of Oliver's question.  .resume() can start
> up an I/O operation which can then complete before the tasks are
> defrosted.  The I/O's completion routine generally _will_ end up calling
> wake_up() on some still-frozen task.  That's just as bad as calling it 
> yourself from within the resume routine.

Okay, but since the tasks remove themselves from wait queues, there's no
problem here. :-)

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
