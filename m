From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH -mm 2/3] Freezer: Use wait queue instead of
	busy looping (updated)
Date: Fri, 3 Aug 2007 02:05:41 +0400
Message-ID: <20070802220541.GA572__47916.9190898121$1186092465$gmane$org@tv-sign.ru>
References: <200708012328.23939.rjw@sisk.pl> <200708022313.32944.rjw@sisk.pl>
	<20070802212307.GA521@tv-sign.ru> <200708022349.44778.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708022349.44778.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 08/02, Rafael J. Wysocki wrote:
>
> On Thursday, 2 August 2007 23:23, Oleg Nesterov wrote:
> > On 08/02, Rafael J. Wysocki wrote:
> > >
> > > On Thursday, 2 August 2007 20:40, Oleg Nesterov wrote:
> > > > On 08/02, Rafael J. Wysocki wrote:
> > > > >
> > > > > @@ -171,6 +186,10 @@ static int try_to_freeze_tasks(int freez
> > > > >  
> > > > >  	end_time = jiffies + TIMEOUT;
> > > > >  	do {
> > > > > +		DEFINE_WAIT(wait);
> > > > > +
> > > > > +		add_wait_queue(&refrigerator_waitq, &wait);
> > > > 
> > > > Hmm. In that case I'd sugest to use prepare_to_wait(). This means that
> > > > multiple wakeups from refrigerator() won't do unnecessary work,
> > > 
> > > I'm not sure what you mean.
> > > 
> > > Do you mean that if we are TASK_UNINTERRUPTIBLE, then the first wake up
> > > should remove us from the queue?
> > 
> > No, not because we are TASK_UNINTERRUPTIBLE, but yes, first wake up will
> > remove us because DEFINE_WAIT() uses autoremove_wake_function().
> 
> Yes, it does, but the prepare_to_wait() version would only cause current to
> become TASK_UNINTERRUPTIBLE before it sends freezing requests, the other
> differences don't seem to matter.  I'm trying to understand why it would change
> the behavior in the way you have described.

Ugh, this is not the first time when I didn't read your patch carefully, sorry!

I missed that your patch already uses DEFINE_WAIT(), and I was confused by the
add_wait_queue() which is usually used along with DECLARE_WAITQUEUE().

Oleg.
