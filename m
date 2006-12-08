From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Fri, 8 Dec 2006 11:21:23 +0000
Message-ID: <20061208112123.GA4957@ucw.cz>
References: <200612032318.29030.rjw@sisk.pl> <200612060008.51373.rjw@sisk.pl>
	<20061205234550.GA10914@elf.ucw.cz>
	<200612070013.23230.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200612070013.23230.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>, Nigel Cunningham <ncunningham@linuxmail.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > > ...after resume.
> > > > 
> > > > This is because of how signal_wake_up() works, I think..
> > > > 
> > > > > But I think it is right approach.
> > > 
> > > Okay, with the appended patch applied everything seems to work and I don't
> > > see any undesirable side-effects.
> > 
> > I promise to try it... tommorow. Looks very good to me.
> 
> Unfortunately there's one problem with it.

Well, IIRC it still had the 'bash reports vi stopped twice' problem.

> To reproduce it I run "gdb /bin/cat", execute "run" in gdb and press ^Z twice
> to stop both processes.  Next I suspend and resume and run "fg" to get the gdb
> back.and press "Enter" to get the prompt.  Then, it turns out that the
> terminal echo doesn't work and "Enter" doesn't make it go to the next line.
> I can recover from this state by typing "fg+Enter" (with no echo) so that
> /bin/cat gets the continuation signal and it restores the terminal settings,
> apparently.

I wonder if we should start a test suite ;-).

> This means, however, that with this patch the behavior of a process (gdb)
> after the resume may be different to its normal behavior, which is wrong.

Yep.

> With my original [1/2] this problem doesn't appear (ie. after the resume gdb
> behaves normally).  Thus I think that, although this patch is much more
> elegant, my original [1/2] is a safer solution, because we can say exactly
> what it does.

Original 1/2 indeed is 'safer'... but it is also too ugly to live.
Getting this to work should not be that hard, and I'd prefer not to
add more tricky code to already-tricky process.c.

In the meantime, perhaps we want 2/2 merged? That one was
safe&obvious.
							Pavel
-- 
Thanks for all the (sleeping) penguins.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
