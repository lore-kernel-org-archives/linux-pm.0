From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/6] cgroup_freezer: fix freezer->state
	setting bug in	freezer_change_state()
Date: Sun, 4 Sep 2011 20:02:06 +0200
Message-ID: <20110904180206.GA28520__28025.6732403815$1315159613$gmane$org@redhat.com>
References: <1314988070-12244-1-git-send-email-tj@kernel.org>
	<1314988070-12244-2-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1314988070-12244-2-git-send-email-tj@kernel.org>
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
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

On 09/03, Tejun Heo wrote:
>
> @@ -308,24 +308,24 @@ static int freezer_change_state(struct cgroup *cgroup,
>  	spin_lock_irq(&freezer->lock);
>  
>  	update_if_frozen(cgroup, freezer);
> -	if (goal_state == freezer->state)
> -		goto out;
> -
> -	freezer->state = goal_state;
>  
>  	switch (goal_state) {
>  	case CGROUP_THAWED:
> -		atomic_dec(&system_freezing_cnt);
> +		if (freezer->state != CGROUP_THAWED)
> +			atomic_dec(&system_freezing_cnt);
> +		freezer->state = CGROUP_THAWED;
>  		unfreeze_cgroup(cgroup, freezer);
>  		break;
>  	case CGROUP_FROZEN:
> -		atomic_inc(&system_freezing_cnt);
> +		if (freezer->state == CGROUP_THAWED)
> +			atomic_inc(&system_freezing_cnt);
> +		freezer->state = CGROUP_FREEZING;
>  		retval = try_to_freeze_cgroup(cgroup, freezer);

Cough. Now it doesn't look right to me ;)

If the user write "FROZEN" into the control file, we should not
turn the CGROUP_FROZEN state into CGROUP_FREEZING. Probably this
is harmless, but this looks wrong and this doesn't match the
current behaviour, user-visible change.

Oleg.
