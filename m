From: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] cpuidle: coupled: abort idle if pokes are pending
Date: Mon, 26 Aug 2013 17:10:21 +0800
Message-ID: <1377508221.16229.34.camel@jlo-ubuntu-64.nvidia.com>
References: <1377287112-12018-1-git-send-email-ccross@android.com>
	 <1377287112-12018-2-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377287112-12018-2-git-send-email-ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Neil Zhang <zhangwm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2013-08-24 at 03:45 +0800, Colin Cross wrote:
> Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> reported a lockup on Tegra3 caused
> by a race condition in coupled cpuidle.  When two or more cpus
Actually this issue can be reproduced on both Tegra20/30 platforms. And
I suggest using Tegra20 to replace Tegra3 here, we only apply coupled
CPU idle function on Tegra20 in the mainline right now.
> enter idle at the same time, the first cpus to arrive may go to the
> ready loop without processing pending pokes from the last cpu to
> arrive.
> 
> This patch adds a check for pending pokes once all cpus have been
> synchronized in the ready loop and resets the coupled state and
> retries if any cpus failed to handle their pending poke.
> 
> Retrying on all cpus may trigger the same issue again, so this patch
> also adds a check to ensure that each cpu has received at least one
> poke between when it enters the waiting loop and when it moves on to
> the ready loop.
> 
> Reported-by: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> CC: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/cpuidle/coupled.c | 107 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 82 insertions(+), 25 deletions(-)
> 
[snip]
> +/*
> + * The cpuidle_coupled_poke_pending mask is used to ensure that each cpu has
s/cpuidle_coupled_poke_pending/cpuidle_coupled_poked/? :)
> + * been poked once to minimize entering the ready loop with a poke pending,
> + * which would require aborting and retrying.
> + */
> +static cpumask_t cpuidle_coupled_poked;
> 
I fixed this issue by checking if there is a pending SGI, then abort the
coupled state on Tegra20. It still can be reproduced easily if I remove
the checking code. So I tested the case with this patch, the result is
good. This patch can fix the issue indeed.

I also tested with the other two patches. It didn't cause any
regression.

So this series:
Tested-by: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
