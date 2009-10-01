From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/19] freezer: don't get over-anxious while
	waiting
Date: Thu, 1 Oct 2009 23:04:00 +0200
Message-ID: <200910012304.00720.rjw__36485.8210822151$1254431023$gmane$org@sisk.pl>
References: <1254384558-1018-1-git-send-email-tj@kernel.org>
	<1254384558-1018-2-git-send-email-tj@kernel.org>
	<20091001183655.GA9995@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091001183655.GA9995@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>, Tejun Heo <tj@kernel.org>
Cc: cl@linux-foundation.org, jeff@garzik.org, pm list <linux-pm@lists.linux-foundation.org>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, Oren Laadan <orenl@librato.com>, dhowells@redhat.com, jens.axboe@oracle.com, akpm@linux-foundation.org, arjan@linux.intel.com, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Thursday 01 October 2009, Pavel Machek wrote:
> 
> > Freezing isn't exactly the most latency sensitive operation and
> > there's no reason to burn cpu cycles and power waiting for it to
> > complete.  msleep(10) instead of yield().  This should improve
> > reliability of emergency hibernation.
> 
> i don't see how it improves reliability, but its probably ok.
> 
> Well... for hibernation anyway. I can imagine cgroup users where
> freeze is so fast that this matters. rjw cc-ed.		pavel

Thanks.  I'd like to hear from the cgroup freezer people about that.

> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> >  kernel/power/process.c |   13 +++++++++----
> >  1 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > index cc2e553..9d26a0a 100644
> > --- a/kernel/power/process.c
> > +++ b/kernel/power/process.c
> > @@ -41,7 +41,7 @@ static int try_to_freeze_tasks(bool sig_only)
> >  	do_gettimeofday(&start);
> >  
> >  	end_time = jiffies + TIMEOUT;
> > -	do {
> > +	while (true) {
> >  		todo = 0;
> >  		read_lock(&tasklist_lock);
> >  		do_each_thread(g, p) {
> > @@ -62,10 +62,15 @@ static int try_to_freeze_tasks(bool sig_only)
> >  				todo++;
> >  		} while_each_thread(g, p);
> >  		read_unlock(&tasklist_lock);
> > -		yield();			/* Yield is okay here */
> > -		if (time_after(jiffies, end_time))
> > +		if (!todo || time_after(jiffies, end_time))
> >  			break;
> > -	} while (todo);
> > +
> > +		/*
> > +		 * We need to retry.  There's no reason to be
> > +		 * over-anxious about it and waste power.
> > +		 */

The comment above looks like it's only meaningful in the context of the patch.
After it's been applied the meaning of the comment won't be so obvious, I'm
afraid.

> > +		msleep(10);
> > +	}
> >  
> >  	do_gettimeofday(&end);
> >  	elapsed_csecs64 = timeval_to_ns(&end) - timeval_to_ns(&start);

Thanks,
Rafael
