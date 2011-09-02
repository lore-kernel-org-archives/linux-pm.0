From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH pm-freezer 1/4] cgroup_freezer: fix
	freezer->state	setting bug in freezer_change_state()
Date: Fri, 2 Sep 2011 18:58:39 +0200
Message-ID: <20110902165839.GA7478__26587.7185775482$1314983025$gmane$org@redhat.com>
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
Cc: Paul Menage <paul@paulmenage.org>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, containers@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 09/01, Matt Helsley wrote:
>
> On Wed, Aug 31, 2011 at 12:21:07PM +0200, Tejun Heo wrote:
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

This is what I mentioned before, to me this looks like a win.

Why do we need try_to_freeze_cgroup() in this case? "for safety"
could actually mean "hide the bug" ;)


But I agree either way. Rafael, I think 1-4 are fine, but I think
we need the simple 5/4, will send in a minute...

Oleg.
