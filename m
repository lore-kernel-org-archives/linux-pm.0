From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: question on resume()
Date: Wed, 31 Jan 2007 09:49:03 +0100
Message-ID: <200701310949.04110.rjw@sisk.pl>
References: <200701291206.39637.oneukum@suse.de> <200701310933.29443.rjw@sisk.pl> <200701310940.26040.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932299AbXAaIsT@vger.kernel.org>
In-Reply-To: <200701310940.26040.oliver@neukum.name>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.name>
Cc: linux-kernel@vger.kernel.org, nigel@nigel.suspend2.net, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 31 January 2007 09:40, Oliver Neukum wrote:
> Am Mittwoch, 31. Januar 2007 09:33 schrieb Rafael J. Wysocki:
> > On Tuesday, 30 January 2007 23:32, Rafael J. Wysocki wrote:
> 
> > > Generally, you are safe if your driver only calls wake_up() from a process
> > > context, but not from .resume() or .suspend() routines (or from an
> > > unfreezeable kernel thread).
> > 
> > Ah, sorry, I've just realized I was wrong.  Processes in TASK_UNINTERRUPTIBLE
> > cannot be frozen!  So, the above only applies to wake_up_interruptible().
> 
> So the kernel will wait for tasks in TASK_UNINTERRUPTIBLE to finish IO
> before it calls suspend()? I am confused.

Yes, it will.  The process freezer can only return success if there are no more
TASK_UNINTERRUPTIBLE tasks.  Otherwise it fails (after a timeout).

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
