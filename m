From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/5] PM: Make freeze_processes
	SMP-safe
Date: Thu, 30 Nov 2006 01:21:53 +0100
Message-ID: <200611300121.53975.rjw@sisk.pl>
References: <200611252210.58203.rjw@sisk.pl> <200611290040.37965.rjw@sisk.pl>
	<20061129235523.GA1952@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061129235523.GA1952@elf.ucw.cz>
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
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 30 November 2006 00:55, Pavel Machek wrote:
> Hi!
> 
> > > > I do not like the counting idea; it should be simpler to just check if
> > > > all the processes are still stopped.
> > > 
> > > I thought about that but didn't invent anything reasonable enough.
> > > 
> > > > But I'm not sure if this is enough. What if signal is being delivered
> > > > on another CPU while freezing, still being delivered while this second
> > > > check runs, and then SIGCONT is delivered? 
> > > 
> > > Hm, is this possible in practice?  I mean, if todo is 0 and nr_stopped doesn't
> > > change, then there are no processes that can send the SIGCONT (unless someone
> > > creates a kernel thread with PF_NOFREEZE that will do just that).
> > > 
> > > Anyway, for now I've no idea how to fix this properly.  Will think about it
> > > tomorrow.
> > 
> > As far as this particular problem is concerned, I think there are two possible
> > solutions.
> > 
> > One of them would be do disable the delivery of continuation signals before
> > we start freezing processes, but I don't know how to do this exactly so that
> > it's not racy.  Also it would be quite intrusive.
> > 
> > The other one may be something along with the lines of the appended patch.
> 
> There has to be a better solution. Stopped tasks are suspended
> somewhere in kernel, right? One try_to_freeze() and problem should be
> solved, in regular way, and without tricks...?

Why?  _This_ is a regular way, IMHO.

The problem is that stopped tasks aren't actually running (obviously) so they
_can't_ execute try_to_freeze() until someone sends them a signal.  However,
once they actually have received the signal, we want them to freeze, so we
must tell them to do so.  Still, if they don't receive the signal, we want them
to stay stopped (IOW, the freezer by itself should not wake them up).

Therefore, we need to call freeze_process() for the stopped tasks too, but
this alone won't wake them up (which is good).  Now if someone wakes them
up in the meantime, they will go to the refrigerator thanks to the
try_to_freeze() in get_signal_to_deliver() (they will think they have a signal
to handle, because we have called freeze_process() for them).  _But_ if
anyone doesn't wake them up, we must cancel the freezing of them so they
don't go freezing when they receive the continuation signal at some point
in the future.

Of course after we have called freeze_process() for a stopped tasks, we
shouldn't count that task as freezeable, because it may not be woken up by
anyone (which is _very_likely BTW).

IMO there's no simpler way of doing this and anything else would be racy.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
