From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH 1/4] cgroup freezer: Fix buggy resume test
	for tasks	frozen with cgroup freezer
Date: Wed, 3 Jun 2009 11:05:51 -0500
Message-ID: <20090603160551.GB7848__21009.5411203385$1244049799$gmane$org@us.ibm.com>
References: <cover.1244019829.git.matthltc@us.ibm.com>
	<91260d5797bcf233ca54c7b41da8278e99b4ca66.1244019829.git.matthltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <91260d5797bcf233ca54c7b41da8278e99b4ca66.1244019829.git.matthltc@us.ibm.com>
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
Cc: Paul Menage <menage@google.com>, Containers <containers@lists.linux-foundation.org>, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Quoting Matt Helsley (matthltc@us.ibm.com):
> -int cgroup_frozen(struct task_struct *task)
> +int cgroup_freezing_or_frozen(struct task_struct *task)
>  {
>  	struct freezer *freezer;
>  	enum freezer_state state;
> 
>  	task_lock(task);
>  	freezer = task_freezer(task);
> -	state = freezer->state;
> +	if (!freezer->css.cgroup->parent)
> +		state = CGROUP_THAWED; /* root cgroup can't be frozen */
> +	else
> +		state = freezer->state;

Why do you have to add this special-casing now?  I thought
we were already preventing freezing the root cgroup, so
freezer->state should be sane in that case anyway?

>  	task_unlock(task);
> 
> -	return state == CGROUP_FROZEN;
> +	return (state == CGROUP_FREEZING) || (state == CGROUP_FROZEN);
>  }

-serge
