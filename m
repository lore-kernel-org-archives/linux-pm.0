From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/3] Freezer: Replace the timeout
Date: Sun, 5 Aug 2007 23:37:28 +0200
Message-ID: <20070805213728.GA30770@elf.ucw.cz>
References: <200707251401.48340.rjw@sisk.pl> <200708010029.43652.rjw@sisk.pl>
	<20070801083146.GX2087@elf.ucw.cz> <200708011243.25276.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708011243.25276.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi!

> > What happens on loaded ext3 filesystem, for example? Bunch of userland tasks
> > will wait on data to be synced to disk, taking more than second, no?
> 
> IMHO this only is a question of what the value of MAX_WAITS should be.
> [I took 5 because it turned to be enough in my testing, but that could be 10 or
> more.]
> 
> The point is that in 99.(9)% of cases the 20s timeout is unnecessary, because:
> (1) most often we succeed within 1s
> (2) if we are going to fail, we can say that we'll fail way before the 20s
>     expires.

Well, I've just reproduced 10seconds and 17seconds
time-to-freeze. Okay, I did 

make clean; time make -j 350

on kernel (2GB machine). Can you try with something similary evil?

> Anyway, eventually, I'd like the freezer to detect failures relatively early,
> so the user won't have to wait 20s each time it's going to fail.

It should not fail ;-). And failures are _really_ rare these days. Is
20second wait in case of kernel bug that bad? (FUSE case _is_ a kernel
bug, I'm just not sure how to solve it. It is still rare.)

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
