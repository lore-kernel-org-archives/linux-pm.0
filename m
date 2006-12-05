From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Tue, 5 Dec 2006 14:12:05 +0000
Message-ID: <20061205141205.GA4637@ucw.cz>
References: <200612032318.29030.rjw@sisk.pl> <20061205103429.GB5306@elf.ucw.cz>
	<20061205112429.GA7039@elf.ucw.cz> <200612051238.23727.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200612051238.23727.rjw@sisk.pl>
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
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Actually, what do you think about this patch? It removes special
> > > handling of TASK_TRACED, and should do the trick, too...
> > 
> > I was surprised, but the patch seems to work okay. Can you replace
> > your 1/2 with this one, and see what breaks?
> 
> I don't think anything will _visibly_ break, because (1) even if the traced
> task has TIF_SIGPENDING set unnecessarily, it will just notice there is no
> real signal to handle and continue and 

We are generating spurious wakeups, but as you noticed, that should be
okay.

>(2) the race between the delivery of
> the continuation signal and the freezer is damn hard to trigger (still I think
> I can wirte some artificial code that would trigger this, although it would
> involve a kernel thread sending SIGCONT to a user space process - provided
> it's permissible ;-)).

It is not really permissible, but I do not see how it would hurt...

With that patch, we put TASK_STOPPED tasks into refrigerator, along
with everyone else. SIGCONT is *not* going to help them out of
refrigerator.

We also ignore TASK_STOPPED now, so we'll not proceed until all
stopped tasks are in refrigerator.

Now... I'm not 100% sure I got the ptrace() cases right (and did not
test that)... but TASK_STOPPED cases look pretty trivial to me now.

							Pavel
-- 
Thanks for all the (sleeping) penguins.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
