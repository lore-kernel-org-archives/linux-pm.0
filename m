From: Luca <kronos.it@gmail.com>
Subject: Re: [RFC][PATCH -mm 1/5] PM: Make freeze_processes
	SMP-safe
Date: Mon, 27 Nov 2006 00:37:10 +0100
Message-ID: <68676e00611261537m5dce45det4c3eddfc7101e111@mail.gmail.com>
References: <200611252210.58203.rjw@sisk.pl> <200611252229.52189.rjw@sisk.pl>
	<20061126074740.GB12479@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061126074740.GB12479@elf.ucw.cz>
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
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On 11/26/06, Pavel Machek <pavel@ucw.cz> wrote:
===================================================================
> > --- linux-2.6.19-rc6-mm1.orig/include/linux/sched.h
> > +++ linux-2.6.19-rc6-mm1/include/linux/sched.h
> > @@ -1065,6 +1065,9 @@ struct task_struct {
> >  #ifdef       CONFIG_TASK_DELAY_ACCT
> >       struct task_delay_info *delays;
> >  #endif
> > +#ifdef CONFIG_PM
> > +     int freezing;           /* if set, we should be freezing for suspend */
> > +#endif
> >  #ifdef CONFIG_FAULT_INJECTION
> >       int make_it_fail;
> >  #endif
>
> It is int, imagine machine that can't do 32-bit atomic access (only
> does 64 bits). On such beast (alpha? something stranger?) this will
> clobber make_it_fail field, sometimes.
>
> OTOH on i386 normal instructions can be used. But that's okay, we
> should just use atomic_t here. Should be as fast on i386/x86-64, and
> still safe.

What about using lock_task_sighand()? This should protect us against
->flags manipulation due to signals without the need of an extra
field.

Luca

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
