From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Tue, 5 Dec 2006 11:25:30 +0100
Message-ID: <20061205102530.GA5306@elf.ucw.cz>
References: <200612032318.29030.rjw@sisk.pl> <200612032350.23067.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200612032350.23067.rjw@sisk.pl>
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

> Currently, if a task is stopped (ie. it's in the TASK_STOPPED state), it is
> considered by the freezer as unfreezeable.  However, there may be a race
> between the freezer and the delivery of the continuation signal to the task
> resulting in the task running after we have finished freezing other tasks.
> This, in turn, may lead to undesirable effects up to and including a
> corruption of data.
> 
> To prevent this from happening we first need to make the freezer consider
> stopped tasks as freezeable.  For this purpose we need to make freezeable()
> stop returning 0 for these tasks.  We must remember, however, that the
> stopped tasks need not receive the continuation signal before thaw_processes()
> is called, so as soon as PF_FREEZE is set for them try_to_freeze_tasks()
> should stop counting them as the ones to wait for.  Additionally, if there's a
> traced task (ie. a task in the TASK_TRACED state) the parent of which has
> PF_FREEZE set and is stopped, try_to_freeze_tasks() should not wait for it.
> Moreover, if there are some stopped tasks that haven't received the continuation
> signal before thaw_processes() is called, we must clear PF_FREEZE for them so
> that they don't go to the refrigerator when it's no longer desirable.
> 
> Still if a stopped tasks receives the continuation signal after the freezer
> has returned, it should immediately go to the refrigerator.  For this reason
> we need to place the call to try_to_freeze() in get_signal_to_deliver() right
> after the relock label.
> 
> It is also reasonable to change the error paths so that the names of stopped
> or traced tasks which have not frozen are not reported to the user, because in
> the majority of cases they would be false positives.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Okay, lets go ahead with this one. (ACK) I still think we should be
able to find some simpler solution, I'll take a look.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
