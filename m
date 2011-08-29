From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH pm-freezer 1/4] cgroup_freezer: fix
	freezer->state	setting bug in freezer_change_state()
Date: Mon, 29 Aug 2011 18:00:31 +0200
Message-ID: <20110829160031.GB8392__49321.4559545324$1314634141$gmane$org@redhat.com>
References: <20110829140418.GB18871@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110829140418.GB18871@mtj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Paul Menage <paul@paulmenage.org>, containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 08/29, Tejun Heo wrote:
>
> --- work.orig/kernel/cgroup_freezer.c
> +++ work/kernel/cgroup_freezer.c
> @@ -311,14 +311,14 @@ static int freezer_change_state(struct c
>  	if (goal_state == freezer->state)
>  		goto out;
>  
> -	freezer->state = goal_state;
> -
>  	switch (goal_state) {
>  	case CGROUP_THAWED:
> +		freezer->state = CGROUP_THAWED;
>  		atomic_dec(&system_freezing_cnt);
>  		unfreeze_cgroup(cgroup, freezer);
>  		break;
>  	case CGROUP_FROZEN:
> +		freezer->state = CGROUP_FREEZING;

At first glance, this is correct. I'll try to recheck.

But,

>  		atomic_inc(&system_freezing_cnt);

iiuc this becomes wrong... Suppose a user writes "FROZEN" twice,
before freezer->state becomes CGROUP_FROZEN.

I think we should actually fix the "goal_state == freezer->state"
check above.

Oleg.
