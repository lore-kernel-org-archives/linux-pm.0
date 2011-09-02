From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH pm-freezer 1/4] cgroup_freezer: fix
 freezer->state setting bug in freezer_change_state()
Date: Fri, 2 Sep 2011 11:31:38 -0700
Message-ID: <20110902183138.GA27179__25722.5868328989$1314988460$gmane$org@count0.beaverton.ibm.com>
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
Cc: Paul Menage <paul@paulmenage.org>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, containers@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 02, 2011 at 06:58:39PM +0200, Oleg Nesterov wrote:
> On 09/01, Matt Helsley wrote:
> >
> > On Wed, Aug 31, 2011 at 12:21:07PM +0200, Tejun Heo wrote:
> > >  	case CGROUP_FROZEN:
> > > -		atomic_inc(&system_freezing_cnt);
> > > -		retval = try_to_freeze_cgroup(cgroup, freezer);
> > > +		if (freezer->state == CGROUP_THAWED) {
> > > +			freezer->state = CGROUP_FREEZING;
> > > +			atomic_inc(&system_freezing_cnt);
> > > +			retval = try_to_freeze_cgroup(cgroup, freezer);
> >
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

Well, I need to check Tejun's latest freezer bits to see if this is
still the case but it was possible to get to the FREEZING state and
not enter FROZEN before returning to userspace. So you could come back
into the state change function in the FREEZING state with FROZEN as
the goal state. Note that for the cgroup freezer the FREEZING state is
optional -- so skipping it is fine so long was we guarantee that by the
time we exit to userspace with a FROZEN state all the tasks in the cgroup
are actually frozen (in the refrigerator loop) or frozen enough (about to
enter the refrigerator loop without causing more IO -- e.g. stopped).

Cheers,
	-Matt
