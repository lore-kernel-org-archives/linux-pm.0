From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 1/5] PM: Make freeze_processes
	SMP-safe
Date: Mon, 27 Nov 2006 00:28:58 +0100
Message-ID: <20061126232858.GD13647@elf.ucw.cz>
References: <200611252210.58203.rjw@sisk.pl> <200611261434.18427.rjw@sisk.pl>
	<20061126194824.GD12535@elf.ucw.cz>
	<200611270009.56736.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200611270009.56736.rjw@sisk.pl>
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
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > If frozen is atomic_t, do we need memory barrier?
> 
> I think so.  For example on x86-64 atomic_read() is just a read.

I'm not sure, but for x86-64 barriers are nops, anyway, IIRC.

> > > @@ -128,6 +135,21 @@ static unsigned int try_to_freeze_tasks(
> > >  		} while_each_thread(g, p);
> > >  		read_unlock(&tasklist_lock);
> > >  		yield();			/* Yield is okay here */
> > > +		if (!todo) {
> > > +			/* Make sure that none of the stopped processes has
> > > +			 * received the continuation signal after we checked
> > > +			 * last time.
> > > +			 */
> > 
> > I do not like the counting idea; it should be simpler to just check if
> > all the processes are still stopped.
> 
> I thought about that but didn't invent anything reasonable enough.
> 
> > But I'm not sure if this is enough. What if signal is being delivered
> > on another CPU while freezing, still being delivered while this second
> > check runs, and then SIGCONT is delivered? 
> 
> Hm, is this possible in practice?  I mean, if todo is 0 and nr_stopped doesn't
> change, then there are no processes that can send the SIGCONT (unless someone
> creates a kernel thread with PF_NOFREEZE that will do just that).

No, SIGCONT was sent before freezing even started, and for some reason
takes long time on other CPU.

[Of course it is going to be quite hard to hit that race _in practice_
and mdelay(1000) before check would solve it for practical
purposes...?]

> Anyway, for now I've no idea how to fix this properly.  Will think about it
> tomorrow.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
