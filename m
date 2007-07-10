From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC][PATCH -mm 5/6] Freezer: Use freezing timeout
	more efficiently
Date: Tue, 10 Jul 2007 22:30:32 +0200
Message-ID: <200707102230.33407.rjw@sisk.pl>
References: <200707092229.08898.rjw@sisk.pl> <200707101204.42687.rjw@sisk.pl>
	<20070710171704.GA406@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070710171704.GA406@tv-sign.ru>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 10 July 2007 19:17, Oleg Nesterov wrote:
> On 07/10, Rafael J. Wysocki wrote:
> >
> > > Besides, we can add another timeout for breaking the loop from a "locked up"
> > > state.
> > 
> > Actually I like this idea. :-)
> > 
> > I have updated the patch to use the additional timeout, please have a look
> > (below).
> 
> Q: do we really need these complications with UNINTERRUPTIBLE/blocked ?

Yes, I think so.

> Just watch the "todo", it it doesn't decrease during BREAK_TIMEOUT, then retry.
> No?

No, it is computed from the start in every interation and I compare the result
from the previous iteration with the current result.  Still, I don't compare 'todo'
with 'todo from the previous step' directly, because the lock up can only
happen if 'todo' is equal to 'blocking'.  For this reason, it is sufficient to
compare 'blocking' with 'prev_blocking' (ie. 'blocking' from the previous
step) and 'todo' with 'blocking' (the test if 'todo' > 0 is not essential;
well, I should remove it in accordance with my signature ;-)).

> > +	if (todo && freeze_user_space && !time_after(jiffies, end_time)) {
> > +		/*
> > +		 * Some tasks have not been able to freeze.  They might be stuck
> > +		 * in TASK_UNINTERRUPTIBLE waiting for the frozen tasks.  Try to
> > +		 * thaw the tasks that have frozen without clearing the freeze
> > +		 * requests of the remaining tasks and repeat.
> > +		 */
> 
> Another question, why do we check "freeze_user_space" here?

Well, the assumption is that the freezable kernel threads won't lock up the
freezer in such a way (that may be overoptimistic, but I'd like to make it
for now).  IOW, the retry mechanism is only activated during the freezing
of user space (in principle it might be used in the second phase too, but
I'm not sure if that's really necessary).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
