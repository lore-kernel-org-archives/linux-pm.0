From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/5] PM: Make freeze_processes
	SMP-safe
Date: Mon, 27 Nov 2006 21:02:38 +0100
Message-ID: <200611272102.39281.rjw@sisk.pl>
References: <200611252210.58203.rjw@sisk.pl> <200611270009.56736.rjw@sisk.pl>
	<20061127105051.GF13648@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061127105051.GF13648@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 27 November 2006 11:50, Pavel Machek wrote:
> Hi!
> 
> > > > @@ -61,10 +60,13 @@ static inline void freeze_process(struct
> > > >  	unsigned long flags;
> > > >  
> > > >  	if (!freezing(p)) {
> > > > -		freeze(p);
> > > > -		spin_lock_irqsave(&p->sighand->siglock, flags);
> > > > -		signal_wake_up(p, 0);
> > > > -		spin_unlock_irqrestore(&p->sighand->siglock, flags);
> > > > +		rmb();
> > > 
> > > If frozen is atomic_t, do we need memory barrier?
> > 
> > I think so.  For example on x86-64 atomic_read() is just a read.
> 
> Sorry for one more change, but
> 
> 
> /* set thread flags in other task's structures
>  * - see asm/thread_info.h for TIF_xxxx flags available
>  */
> static inline void set_tsk_thread_flag(struct task_struct *tsk, int
> flag)
> {
>         set_ti_thread_flag(task_thread_info(tsk), flag);
> }
> 
> ...could we use set_tsk_thread_flag and friends to avoid enlarging
> task struct?

_Of_ _course_.  [Heh, I didn't even know something like this existed. ;-)]

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
