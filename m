From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Tue, 5 Dec 2006 12:38:23 +0100
Message-ID: <200612051238.23727.rjw@sisk.pl>
References: <200612032318.29030.rjw@sisk.pl> <20061205103429.GB5306@elf.ucw.cz>
	<20061205112429.GA7039@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061205112429.GA7039@elf.ucw.cz>
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

On Tuesday, 5 December 2006 12:24, Pavel Machek wrote:
> Hi!
> 
> > > Currently, if a task is stopped (ie. it's in the TASK_STOPPED state), it is
> > > considered by the freezer as unfreezeable.  However, there may be a race
> > > between the freezer and the delivery of the continuation signal to the task
> > > resulting in the task running after we have finished freezing other tasks.
> > > This, in turn, may lead to undesirable effects up to and including a
> > > corruption of data.
> > > 
> > > To prevent this from happening we first need to make the freezer consider
> > > stopped tasks as freezeable.  For this purpose we need to make freezeable()
> > > stop returning 0 for these tasks.  We must remember, however, that the
> > > stopped tasks need not receive the continuation signal before thaw_processes()
> > > is called, so as soon as PF_FREEZE is set for them try_to_freeze_tasks()
> > > should stop counting them as the ones to wait for.  Additionally, if there's a
> > > traced task (ie. a task in the TASK_TRACED state) the parent of which has
> > > PF_FREEZE set and is stopped, try_to_freeze_tasks() should not wait for it.
> > > Moreover, if there are some stopped tasks that haven't received the continuation
> > > signal before thaw_processes() is called, we must clear PF_FREEZE for them so
> > > that they don't go to the refrigerator when it's no longer desirable.
> > 
> > Actually, what do you think about this patch? It removes special
> > handling of TASK_TRACED, and should do the trick, too...
> 
> I was surprised, but the patch seems to work okay. Can you replace
> your 1/2 with this one, and see what breaks?

I don't think anything will _visibly_ break, because (1) even if the traced
task has TIF_SIGPENDING set unnecessarily, it will just notice there is no
real signal to handle and continue and (2) the race between the delivery of
the continuation signal and the freezer is damn hard to trigger (still I think
I can wirte some artificial code that would trigger this, although it would
involve a kernel thread sending SIGCONT to a user space process - provided
it's permissible ;-)).

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
