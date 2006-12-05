From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Tue, 5 Dec 2006 15:26:56 +0100
Message-ID: <200612051526.56899.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <200612051238.23727.rjw@sisk.pl>
	<20061205141205.GA4637@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061205141205.GA4637@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, 5 December 2006 15:12, Pavel Machek wrote:
> Hi!
> 
> > > > Actually, what do you think about this patch? It removes special
> > > > handling of TASK_TRACED, and should do the trick, too...
> > > 
> > > I was surprised, but the patch seems to work okay. Can you replace
> > > your 1/2 with this one, and see what breaks?
> > 
> > I don't think anything will _visibly_ break, because (1) even if the traced
> > task has TIF_SIGPENDING set unnecessarily, it will just notice there is no
> > real signal to handle and continue and 
> 
> We are generating spurious wakeups, but as you noticed, that should be
> okay.

So we can move the check to freezeable().  Fine.

> >(2) the race between the delivery of
> > the continuation signal and the freezer is damn hard to trigger (still I think
> > I can wirte some artificial code that would trigger this, although it would
> > involve a kernel thread sending SIGCONT to a user space process - provided
> > it's permissible ;-)).
> 
> It is not really permissible, but I do not see how it would hurt...
> 
> With that patch, we put TASK_STOPPED tasks into refrigerator, along
> with everyone else. SIGCONT is *not* going to help them out of
> refrigerator.
> 
> We also ignore TASK_STOPPED now, so we'll not proceed until all
> stopped tasks are in refrigerator.
> 
> Now... I'm not 100% sure I got the ptrace() cases right (and did not
> test that)... but TASK_STOPPED cases look pretty trivial to me now.

Please note that currently (and with your patch) freezeable() returns 0 for
TASK_STOPPED, so we don't set PF_FREEZE for them and my patch changes
_exactly_ that and adds some minor (optional) modifications to the error
paths.

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
