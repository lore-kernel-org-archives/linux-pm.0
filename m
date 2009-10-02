From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/19] freezer: don't get over-anxious while
	waiting
Date: Fri, 2 Oct 2009 23:21:11 +0200
Message-ID: <200910022321.11796.rjw__35617.5495115623$1254518466$gmane$org@sisk.pl>
References: <1254384558-1018-1-git-send-email-tj@kernel.org>
	<4AC658C2.6070406@librato.com>
	<20091002210445.GE4189@count0.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091002210445.GE4189@count0.beaverton.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Helsley <matthltc@us.ibm.com>, Tejun Heo <tj@kernel.org>
Cc: cl@linux-foundation.org, jeff@garzik.org, pm list <linux-pm@lists.linux-foundation.org>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, Oren Laadan <orenl@librato.com>, dhowells@redhat.com, jens.axboe@oracle.com, akpm@linux-foundation.org, arjan@linux.intel.com, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Friday 02 October 2009, Matt Helsley wrote:
> On Fri, Oct 02, 2009 at 03:47:14PM -0400, Oren Laadan wrote:
> > 
> > 
> > Rafael J. Wysocki wrote:
> > > On Thursday 01 October 2009, Pavel Machek wrote:
> > >>> Freezing isn't exactly the most latency sensitive operation and
> > >>> there's no reason to burn cpu cycles and power waiting for it to
> > >>> complete.  msleep(10) instead of yield().  This should improve
> > >>> reliability of emergency hibernation.
> > >> i don't see how it improves reliability, but its probably ok.
> 
> From what little of the patch I can see at this point I agree. 
> On a single cpu system the yield gives up the cpu so other tasks
> are more likely to make the progress necessary to become freezable.
> 
> > >>
> > >> Well... for hibernation anyway. I can imagine cgroup users where
> > >> freeze is so fast that this matters. rjw cc-ed.		pavel
> 
> It doesn't (more below), though I appreciate your keeping us in mind.
> 
> > > 
> > > Thanks.  I'd like to hear from the cgroup freezer people about that.
> > > 
> > 
> > [Adding Matt Helsley to the CC list]
> > 
> > To checkpoint or migrate an application, the cgroup to which it belongs
> > must be frozen first.
> > 
> > It's a bit down the road, but if one seeks minimum application downtime
> > during application checkpoint and/or migration, then a (minimum of)
> > 10ms - or multiples of it - may result in a visible/undesired hick-up.
> > 
> > Perhaps avoid it when freezing a cgroup ?  or maybe a way for the user
> > to control this behavior per cgroup ?
> 
> This is already the case.
> 
> The cgroup freezer does not use this yield-loop to iterate over all the tasks.
> Instead of yield() the cgroup freezer has its own "loop". It changes its
> own state to FREEZING and returns to userspace so that userspace can decide
> what to do -- sleep? keep trying to freeze? go back to THAWED? etc. 
> 
> [ In the future this may change depending on the blocking/non-blocking
> flag of the open freezer.state cgroup file handle. ]

OK, thanks for the info.

Tejun, do you want me to take the patch or is it more convenient to you to
push it yourself?

Also, care to respond to my previous comment?

Rafael
