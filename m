From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Tue, 25 May 2010 15:05:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005251501500.1634-100000__11492.561773821$1274814466$gmane$org@iolanthe.rowland.org>
References: <20100525184740.GA4248@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100525184740.GA4248@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 25 May 2010, Dmitry Torokhov wrote:

> > > What you describe can be done in userspace though, via a "suspend manager" 
> > > process. Tasks reading input events will post "busy" events to stop the 
> > > manager process from sending system into suspend. But this can be confined to 
> > > Android userspace, leaving the kernel as is (well, kernel needs to be modified 
> > > to not go into suspend with full queues, but that is using existing kernel 
> > > APIs).
> > 
> > I think that could be made to work.  And it might remove the need for 
> > the userspace suspend-blocker API, which would be an advantage.  It 
> > could even remove the need for the opportunistic-suspend workqueue -- 
> > opportunistic suspends would be initiated by the "suspend manager" 
> > process instead of by the kernel.
> > 
> > However you still have the issue of modifying the kernel drivers to 
> > disallow opportunistic suspend if their queues are non-empty.  Doing 
> > that is more or less equivalent to implementing kernel-level suspend 
> > blockers.  (The suspend blocker approach is slightly more efficient, 
> > because it will prevent a suspend from starting if a queue is 
> > non-empty, instead of allowing the suspend to start and then aborting 
> > it partway through.)
> >
> > Maybe I'm missing something here...  No doubt someone will point it out 
> > if I am.
> > 
> 
> Well, from my perspective that would limit changes to the evdev driver
> (well, limited input core plumbing will be needed) but that is using the
> current PM infrastructure. The HW driver changes will be limited to what
> you described "type 2" in your other e-mail.
> 
> Also, not suspending while events are in progress) is probably
> beneficial for platforms other than Android as well. So unless I am
> missing something this sounds like a win.

I agree that simplifying the user API would be an advantage.  Instead 
of the full-blown suspend-blocker interface, we would need only a way 
to initiate an opportunistic suspend.  For example:

	echo opportunistic >/sys/power/state

Alan Stern
