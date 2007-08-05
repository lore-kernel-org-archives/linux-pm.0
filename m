From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 3/3] Freezer: Replace the timeout
Date: Mon, 6 Aug 2007 00:38:01 +0200
Message-ID: <200708060038.01938.rjw@sisk.pl>
References: <200707251401.48340.rjw@sisk.pl> <200708011243.25276.rjw@sisk.pl>
	<20070805213728.GA30770@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070805213728.GA30770@elf.ucw.cz>
Content-Disposition: inline
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

On Sunday, 5 August 2007 23:37, Pavel Machek wrote:
> Hi!
> 
> > > What happens on loaded ext3 filesystem, for example? Bunch of userland tasks
> > > will wait on data to be synced to disk, taking more than second, no?
> > 
> > IMHO this only is a question of what the value of MAX_WAITS should be.
> > [I took 5 because it turned to be enough in my testing, but that could be 10 or
> > more.]
> > 
> > The point is that in 99.(9)% of cases the 20s timeout is unnecessary, because:
> > (1) most often we succeed within 1s
> > (2) if we are going to fail, we can say that we'll fail way before the 20s
> >     expires.
> 
> Well, I've just reproduced 10seconds and 17seconds
> time-to-freeze. Okay, I did 
> 
> make clean; time make -j 350
> 
> on kernel (2GB machine). Can you try with something similary evil?

I tested with 'make -j 100'.  More than that just makes the machine
unresponsive.
 
> > Anyway, eventually, I'd like the freezer to detect failures relatively early,
> > so the user won't have to wait 20s each time it's going to fail.
> 
> It should not fail ;-). And failures are _really_ rare these days. Is
> 20second wait in case of kernel bug that bad? (FUSE case _is_ a kernel
> bug, I'm just not sure how to solve it. It is still rare.)

Well, not very bad, but still.  Perhaps we should use a progress meter of
some kind to let the user know that something's going on. ;-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
