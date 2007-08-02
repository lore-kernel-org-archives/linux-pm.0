From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm 2/3] Freezer: Use wait queue instead of
	busy looping (updated)
Date: Thu, 2 Aug 2007 23:13:32 +0200
Message-ID: <200708022313.32944.rjw__33635.0837759257$1186088769$gmane$org@sisk.pl>
References: <200708012328.23939.rjw@sisk.pl> <200708021938.37547.rjw@sisk.pl>
	<20070802184002.GA283@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070802184002.GA283@tv-sign.ru>
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
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 2 August 2007 20:40, Oleg Nesterov wrote:
> On 08/02, Rafael J. Wysocki wrote:
> >
> > @@ -171,6 +186,10 @@ static int try_to_freeze_tasks(int freez
> >  
> >  	end_time = jiffies + TIMEOUT;
> >  	do {
> > +		DEFINE_WAIT(wait);
> > +
> > +		add_wait_queue(&refrigerator_waitq, &wait);
> 
> Hmm. In that case I'd sugest to use prepare_to_wait(). This means that
> multiple wakeups from refrigerator() won't do unnecessary work,

I'm not sure what you mean.

Do you mean that if we are TASK_UNINTERRUPTIBLE, then the first wake up
should remove us from the queue?

> and 
> 
> > +
> >  		todo = 0;
> >  		read_lock(&tasklist_lock);
> >  		do_each_thread(g, p) {
> > @@ -189,7 +208,12 @@ static int try_to_freeze_tasks(int freez
> >  				todo++;
> >  		} while_each_thread(g, p);
> >  		read_unlock(&tasklist_lock);
> > -		yield();			/* Yield is okay here */
> > +
> > +		set_current_state(TASK_UNINTERRUPTIBLE);
> > +		if (todo && !list_empty_careful(&wait.task_list))
> > +			schedule_timeout(WAIT_TIME);
> 
> we don't need to check list_empty_careful() before schedule, prepare_to_wait()
> sets TASK_UNINTERRUPTIBLE under wait_queue_head_t->lock.

Yes.

> Still, I personally agree with Pavel. Perhaps it is better to just replace
> yield() with schedule_timeout(a_bit).

Hmm, I think that we shouldn't wait if that's not necessary.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
