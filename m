From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] [443/2many] MAINTAINERS - HIBERNATION (aka
 Software Suspend, aka swsusp):
Date: Tue, 14 Aug 2007 11:15:41 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708141112110.30176__24240.6025565744$1187115455$gmane$org@woody.linux-foundation.org>
References: <46bffbd3.IqsNHrHU1Y9BF7Dd%joe@perches.com>
	<200708132338.25925.rjw@sisk.pl>
	<20070814070528.GA2903@elf.ucw.cz>  <200708141937.06676.rjw@sisk.pl>
	<1187114231.32555.105.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1187114231.32555.105.camel@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Tue, 14 Aug 2007, Joe Perches wrote:
>
> SUSPEND TO RAM:
> P:	Pavel Machek
> M:	pavel@suse.cz
> P:	Rafael J. Wysocki
> M:	rjw@sisk.pl
> L:	linux-pm@lists.linux-foundation.org
> S:	Maintained
> F:	Documentation/power/
> F:	arch/i386/kernel/acpi/
> F:	arch/x86_64/kernel/acpi/
> F:	arch/x86_64/kernel/suspend.c
> F:	drivers/base/power/
> F:	kernel/power/
> F:	include/linux/suspend.h
> F:	include/linux/freezer.h
> F:	include/linux/pm.h
> F:	include/asm-*/suspend.h

Quite frankly, I think the MAINTAINERS file gets a whole lot uglier this 
way.

There's also a rather fundamental issue: this will likely make people 
touch the MAINTAINERS file *more*, and from a maintenance standpoint, that 
is exactly the wrong thing to have (one central file that everybody 
touches). It just tends to generate unnecessary merge conflicts etc. 

(We used to have that issue with the central configuration file, for 
example).

So the more I look at these things, the more convinced I am that this is 
not the right thing to do. These things should *not* be in one huge file, 
and I'd much much rather have the maintainership information be carried 
along with the subsystem itself, or the files it contains.

In other words, it would be much better to just have per-file markers, 
along with some per-subdirectory stuff or similar.

			Linus
