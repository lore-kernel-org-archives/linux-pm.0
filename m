From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...)
Date: Mon, 7 May 2007 17:38:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705071725400.4301-100000@iolanthe.rowland.org>
References: <20070507204912.GC18400@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070507204912.GC18400@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Mon, 7 May 2007, Pavel Machek wrote:

> > 	(A) Remote wakeup may be enabled on some devices, there can be
> > 	    a certain power drain on the batteries or power line, it may 
> > 	    not be safe to disassemble the machine, etc.
> > 
> > 	(B) Remote wakeup is completely disabled, there is no power
> > 	    drain at all, it is safe to disassemble the machine provided
> > 	    you don't switch components like disks, etc.
> > 
> ...
> > 
> > I don't see any reason why (A) and (B) shouldn't both be allowed for 
> > hibernate, as in fact they are now by way of /sys/power/disk.  And I don't 
> > see any reason why they shouldn't both be allowed for normal non-hibernate 
> > shutdowns as well.
> 
> No, sorry, that does not work. Software can't select (A) vs. (B). Only
> user can, by physically switching real power switch, or by unplugging
> the machine.

Okay.  Then what exactly is the difference between the kind of poweroff we 
do during hibernate (say with "platform" in /sys/power/disk) and the kind 
of poweroff we do during a normal system shutdown?

> And yes, there's documentation about expectations of swsusp, in
> Doc*/power/swsusp.txt.

It says this near the start:

 * 		If you change
 * your hardware while system is suspended... well, it was not good idea;
 * but it will probably only crash.

with similar warnings elsewhere.

This appears to refer to confusion in the kernel after the image is 
restored; it doesn't seem to mean that you could damage equipment or 
electrocute yourself.

Alan Stern
