From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH 01/19] freezer: don't get over-anxious while
	waiting
Date: Fri, 2 Oct 2009 14:04:45 -0700
Message-ID: <20091002210445.GE4189__15620.4909821556$1254517744$gmane$org@count0.beaverton.ibm.com>
References: <1254384558-1018-1-git-send-email-tj@kernel.org>
	<1254384558-1018-2-git-send-email-tj@kernel.org>
	<20091001183655.GA9995@atrey.karlin.mff.cuni.cz>
	<200910012304.00720.rjw@sisk.pl> <4AC658C2.6070406@librato.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AC658C2.6070406@librato.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oren Laadan <orenl@librato.com>
Cc: dhowells@redhat.com, cl@linux-foundation.org, jeff@garzik.org, pm list <linux-pm@lists.linux-foundation.org>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, jens.axboe@oracle.com, Tejun Heo <tj@kernel.org>, mingo@elte.hu, arjan@linux.intel.com, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 02, 2009 at 03:47:14PM -0400, Oren Laadan wrote:
> 
> 
> Rafael J. Wysocki wrote:
> > On Thursday 01 October 2009, Pavel Machek wrote:
> >>> Freezing isn't exactly the most latency sensitive operation and
> >>> there's no reason to burn cpu cycles and power waiting for it to
> >>> complete.  msleep(10) instead of yield().  This should improve
> >>> reliability of emergency hibernation.
> >> i don't see how it improves reliability, but its probably ok.

>From what little of the patch I can see at this point I agree. 
On a single cpu system the yield gives up the cpu so other tasks
are more likely to make the progress necessary to become freezable.

> >>
> >> Well... for hibernation anyway. I can imagine cgroup users where
> >> freeze is so fast that this matters. rjw cc-ed.		pavel

It doesn't (more below), though I appreciate your keeping us in mind.

> > 
> > Thanks.  I'd like to hear from the cgroup freezer people about that.
> > 
> 
> [Adding Matt Helsley to the CC list]
> 
> To checkpoint or migrate an application, the cgroup to which it belongs
> must be frozen first.
> 
> It's a bit down the road, but if one seeks minimum application downtime
> during application checkpoint and/or migration, then a (minimum of)
> 10ms - or multiples of it - may result in a visible/undesired hick-up.
> 
> Perhaps avoid it when freezing a cgroup ?  or maybe a way for the user
> to control this behavior per cgroup ?

This is already the case.

The cgroup freezer does not use this yield-loop to iterate over all the tasks.
Instead of yield() the cgroup freezer has its own "loop". It changes its
own state to FREEZING and returns to userspace so that userspace can decide
what to do -- sleep? keep trying to freeze? go back to THAWED? etc. 

[ In the future this may change depending on the blocking/non-blocking
flag of the open freezer.state cgroup file handle. ]

Cheers,
	-Matt Helsley

> 
> Oren.
> 
> >>> Signed-off-by: Tejun Heo <tj@kernel.org>
> >>> ---
> >>>  kernel/power/process.c |   13 +++++++++----
> >>>  1 files changed, 9 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/kernel/power/process.c b/kernel/power/process.c
> >>> index cc2e553..9d26a0a 100644
> >>> --- a/kernel/power/process.c
> >>> +++ b/kernel/power/process.c
> >>> @@ -41,7 +41,7 @@ static int try_to_freeze_tasks(bool sig_only)
> >>>  	do_gettimeofday(&start);
> >>>  
> >>>  	end_time = jiffies + TIMEOUT;
> >>> -	do {
> >>> +	while (true) {
> >>>  		todo = 0;
> >>>  		read_lock(&tasklist_lock);
> >>>  		do_each_thread(g, p) {
> >>> @@ -62,10 +62,15 @@ static int try_to_freeze_tasks(bool sig_only)
> >>>  				todo++;
> >>>  		} while_each_thread(g, p);
> >>>  		read_unlock(&tasklist_lock);
> >>> -		yield();			/* Yield is okay here */
> >>> -		if (time_after(jiffies, end_time))
> >>> +		if (!todo || time_after(jiffies, end_time))
> >>>  			break;
> >>> -	} while (todo);
> >>> +
> >>> +		/*
> >>> +		 * We need to retry.  There's no reason to be
> >>> +		 * over-anxious about it and waste power.
> >>> +		 */
> > 
> > The comment above looks like it's only meaningful in the context of the patch.
> > After it's been applied the meaning of the comment won't be so obvious, I'm
> > afraid.
> > 
> >>> +		msleep(10);
> >>> +	}
> >>>  
> >>>  	do_gettimeofday(&end);
> >>>  	elapsed_csecs64 = timeval_to_ns(&end) - timeval_to_ns(&start);
> > 
> > Thanks,
> > Rafael
