From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 4 May 2007 23:15:19 +0200
Message-ID: <20070504211519.GA24246@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0705041020530.3417-100000@iolanthe.rowland.org>
	<200705042220.24518.rjw@sisk.pl>
	<1178310082.7408.33.camel@johannes.berg>
	<20070504205524.GA24123@elf.ucw.cz>
	<1178312930.7408.38.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1178312930.7408.38.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > ACPI BIOS communicates with hw, too. Suppose it generates random
> > number, stores it in memory and tells it to the keyboard conroller
> > during bootup (more specifically during ACPI enable phase).
> > 
> > Now, it periodically checks if number in memory is same as the number
> > known by keyboard controller.
> > 
> > If you suspend/resume without telling acpi, it will find out, because
> > numbers will not match.
> > 
> > (And now, ACPI is probably not crazy enough to store random numbers --
> > but it could -- but for example "I had AC power, now I do not, and I
> > did not see a interrupt telling me it went away" can be counted as
> > confusing for ACPI).
> 
> I don't follow.
> 
>  * you have AC power.
>  * you save system state and shut down (S5)
>  * you boot up again on battery power
>  * you restore system state
>  * ...
> 
> vs.
> 
>  * you have AC power
>  * you shut down
>  * you boot up again on battery power
>  * ...
> 
> where's the difference to the ACPI bios? Oh, I see, it stores it
> somewhere in the memory that you've stored/restored? Well, that's your
> bug then, don't touch it.

Not sure... yes, it stores parts somewhere in memory. Plus, it may
have some parts related to the communications with operating system
(*)... I guess we need to save those, and parts related to hw
state... where your suggestion makes sense.

(*) and yes, there probably are such parts. If we set backlight to
20%, we'll be confused if it is 100% after resume... we probably could
handle those one-by-one...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
