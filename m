From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Is it supposed to be ok to call del_gendisk while
	userspace is frozen?
Date: Mon, 17 May 2010 22:35:37 +0200
Message-ID: <201005172235.37824.rjw__23493.6733766974$1274128609$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005162219330.24400-100000@netrider.rowland.org>
	<4BF0F3FF.2010603@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BF0F3FF.2010603@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matt Reimer <mattjreimer@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Monday 17 May 2010, Nigel Cunningham wrote:
> Hi.
> 
> On 17/05/10 12:22, Alan Stern wrote:
> > On Mon, 17 May 2010, Nigel Cunningham wrote:
> >
> >>>> I object to the patch.
> >>>>
> >>>> Tell the patch it ought to exit once thawed, by all means.
> >>>
> >>> I'm not sure what you mean.  Care to explain?
> >>
> >> I mean "Set up some sort of flag that it can look at once thawed at
> >> resume time, and use that to tell it to exit at that point."
> >
> > Doesn't the patch do exactly that?  The "flag" is set by virtue of the
> > fact that this is part of del_gendisk -- which means the disk is being
> > unregistered and hence the writeback thread will exit shortly.
> >
> >>>> Make the patch unfreezeable to begin with, by all means.
> >>>
> >>> That wouldn't work.
> >>
> >> Why not?
> >
> > It would be nice to know exactly why.  Perhaps the underlying problem
> > can be fixed.
> >
> >>>> If you know a disk is going to be unregistered during resume,
> >>>
> >>> How do we check that, exactly?
> >>
> >> Well, if you can figure out that you need to go down this path at this
> >> point in the process, you must be able to apply the same logic to come
> >> to the same conclusion earlier in the process.
> >
> > That's not true.  You don't know that a device is going to be unplugged
> > until it actually _is_ unplugged.
> 
> Sorry - I got unregistered during suspend (instead of resume) in my 
> head. That said, I'd argue that we should be...
> 
> 1) Syncing all the data at the start of the suspend/hibernate, so 
> there's nothing for the workthread to do if we do del_gendisk.
> 2) Telling things to exit if we do find the device is gone away at 
> resume time, but not relying on the going-away happening until post 
> process thaw, for a couple of reasons:
> - Potential for races/confusion/mess etc in having $random process 
> thawing other processes. Only the thread doing the suspend/hibernate 
> should be freezing/thawing.

I don't see a problem here, as far as kernel threads are concerned.  In this
particular case this is a subsystem thawing a thread that belongs to it.  No
problem.

> - We're dealing with the symptom, not the cause. Almost always a bad idea.

I very much prefer to have a fix for a symptom than no fix at all, which is the
realistic alternative in this case.

So, I think we should merge the patch and if someone finds the root cause
at one point in future, then we can just use the *right* approach instead of
the present one.

The problem is real and people in the field are affected by it, so if you don't
have a working alternative patch, please just let go.

Thanks,
Rafael
