From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH pm-freezer 1/4] cgroup_freezer: fix
 freezer->state setting bug in freezer_change_state()
Date: Fri, 2 Sep 2011 11:50:16 +0900
Message-ID: <20110902025016.GI2752__13343.929363373$1314933644$gmane$org@htj.dyndns.org>
References: <20110831102100.GA2828@mtj.dyndns.org>
	<20110902004231.GF1919@count0.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110902004231.GF1919@count0.beaverton.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Helsley <matthltc@us.ibm.com>
Cc: containers@lists.linux-foundation.org, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Paul Menage <paul@paulmenage.org>
List-Id: linux-pm@vger.kernel.org

Hello, Matt.

On Thu, Sep 01, 2011 at 05:42:31PM -0700, Matt Helsley wrote:
> >  	case CGROUP_FROZEN:
> > -		atomic_inc(&system_freezing_cnt);
> > -		retval = try_to_freeze_cgroup(cgroup, freezer);
> > +		if (freezer->state == CGROUP_THAWED) {
> > +			freezer->state = CGROUP_FREEZING;
> > +			atomic_inc(&system_freezing_cnt);
> > +			retval = try_to_freeze_cgroup(cgroup, freezer);
> 
> This still doesn't look quite right. If the cgroup is FREEZING it should
> also call try_to_freeze_cgroup(). I think this is what's needed:
> 
> 		if (freezer->state == CGROUP_THAWED)
> 			atomic_inc(&system_freezing_cnt);
> 		freezer->state = CGROUP_FREEZING;
> 		retval = try_to_freeze_cgroup(cgroup, freezer);

Does this make any difference?  Tasks can't migrate if the cgroups are
freezing and freezing state is inherited through forks.  But yeah
doing that for both THAWED and FROZEN might still be a good idea for
safety.

Thanks.

-- 
tejun
