From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Tue, 25 May 2010 17:00:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005251647530.1634-100000__3066.26287424496$1274821453$gmane$org@iolanthe.rowland.org>
References: <201005252221.55888.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005252221.55888.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 25 May 2010, Rafael J. Wysocki wrote:

> So, basically, you'd prefer to move the entire complexity to user space.

No, just the complexity of the userspace suspend blockers.  That was 
one of the parts of the interface that people objected to, after all.

> I'm not sure if that's a big win

It's not a _big_ win, but it is an improvement IMO.

>  and I'm not sure anyone is actually going to
> implement it (and some drivers would still have to be modified to participate
> in this framework).

Of course drivers have to be modified.  The kernel-layer suspend
blockers aren't affected by this proposal, so they still have to be
implemented.

>  So again, we have a hunch that the goal may be achieved
> in a different way, but at this point we'd rather need a _working_ _solution_
> (in the form of code one can build and actually use).

It's not very different from what has been submitted, and I think
there's little doubt that it could be built and used fairly easily.  
All we're talking about is removing the userspace suspend-blocker API
and the opportunistic workqueue, replacing them with an "opportunistic"
entry in /sys/power/state, and setting up a userspace power manager
process.

> I don't think it's realistic to expect the Android people to go and redesign
> their stuff along the lines you've described, because they have a working
> implementation (in the kernel) that they are satisfied with.

The redesign would be pretty small.  The kernel changes relative to
what they have submitted are minimal, mostly just removing a few of
their additions.  Furthermore, we've been told that Android _already_
funnels all its userspace suspend-blocker work through a single
process.  All that would be needed would be to make that process
initiate an opportunistic suspend whenever no userspace suspend
blockers were active.

> Now, we can reject their patches, but that's not going to cause any progress
> to happen, realistically.  Quite on the contrary, Android will continue to use
> wakelocks and Android driver writers will continue to ignore the mainline
> and the gap between the two kernel lines will only get wider and wider over
> time.
> 
> And what really is the drawback if we merge the patches?  Quite frankly,
> I don't see any.

You don't seem to appreciate how small a change Dmitry has proposed.  
Almost all of the suspend-blocker work would remain as in the submitted
patches.  The only difference is that the userspace API and
opportunistic-suspend implementation would be simplified, by moving
some of the work out of the kernel.

Alan Stern
