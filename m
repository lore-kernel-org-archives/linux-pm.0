From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH pm-freezer 1/4] cgroup_freezer: fix
 freezer->state setting bug in freezer_change_state()
Date: Sat, 3 Sep 2011 02:08:44 +0900
Message-ID: <20110902170844.GJ2752__19083.0160551288$1314983388$gmane$org@htj.dyndns.org>
References: <20110831102100.GA2828@mtj.dyndns.org>
	<20110902004231.GF1919@count0.beaverton.ibm.com>
	<20110902165839.GA7478@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110902165839.GA7478@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Paul Menage <paul@paulmenage.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On Fri, Sep 02, 2011 at 06:58:39PM +0200, Oleg Nesterov wrote:
> > This still doesn't look quite right. If the cgroup is FREEZING it should
> > also call try_to_freeze_cgroup(). I think this is what's needed:
> >
> > 		if (freezer->state == CGROUP_THAWED)
> > 			atomic_inc(&system_freezing_cnt);
> > 		freezer->state = CGROUP_FREEZING;
> > 		retval = try_to_freeze_cgroup(cgroup, freezer);
> 
> This is what I mentioned before, to me this looks like a win.
> 
> Why do we need try_to_freeze_cgroup() in this case? "for safety"
> could actually mean "hide the bug" ;)

I guess it depends on the viewpoint.  A simple analogy would be using
WARN_ON_ONCE() instead of BUG_ON() so that the mode of failure is
softer.  This change isn't likely to make bugs significantly more
difficult to discover so why not?

> But I agree either way. Rafael, I think 1-4 are fine, but I think
> we need the simple 5/4, will send in a minute...

Can you please wait a bit?  The second one was broken (missing unlock)
and I made some small adjustments.  Will repost soon.

Thanks.

-- 
tejun
