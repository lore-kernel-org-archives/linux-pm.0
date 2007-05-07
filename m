From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...)
Date: Mon, 7 May 2007 22:49:12 +0200
Message-ID: <20070507204912.GC18400@elf.ucw.cz>
References: <200705061831.08805.david-b@pacbell.net>
	<Pine.LNX.4.44L0.0705071207100.3429-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0705071207100.3429-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> It is true that for G3 type shutdown, step 6 can be empty.  We don't need 
> to do anything to the devices or drivers, we just turn off all the power.  
> Still, the empty set _is_ a set.  :-)
> 
> Here's another way to express my ideas: We want to support at least two 
> different kinds of powered-down states:
> 
> 	(A) Remote wakeup may be enabled on some devices, there can be
> 	    a certain power drain on the batteries or power line, it may 
> 	    not be safe to disassemble the machine, etc.
> 
> 	(B) Remote wakeup is completely disabled, there is no power
> 	    drain at all, it is safe to disassemble the machine provided
> 	    you don't switch components like disks, etc.
> 
...
> 
> I don't see any reason why (A) and (B) shouldn't both be allowed for 
> hibernate, as in fact they are now by way of /sys/power/disk.  And I don't 
> see any reason why they shouldn't both be allowed for normal non-hibernate 
> shutdowns as well.

No, sorry, that does not work. Software can't select (A) vs. (B). Only
user can, by physically switching real power switch, or by unplugging
the machine.

And yes, there's documentation about expectations of swsusp, in
Doc*/power/swsusp.txt.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
