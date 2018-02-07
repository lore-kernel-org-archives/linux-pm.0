From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 1/4] cpu_pm: add syscore_suspend error handling
Date: Wed, 7 Feb 2018 08:57:27 +0000
Message-ID: <04ebd1d9-b45b-df87-d59e-1a3df97f3371@arm.com>
References: <20180207014117.62611-1-dbasehore@chromium.org>
 <20180207014117.62611-2-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180207014117.62611-2-dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Content-Language: en-GB
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Soby.Mathew-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 07/02/18 01:41, Derek Basehore wrote:
> If cpu_cluster_pm_enter() fails, cpu_pm_exit() should be called. This
> will put the CPU in the correct state to resume from the failure.
> 
> Signed-off-by: Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  kernel/cpu_pm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index 67b02e138a47..03bcc0751a51 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -186,6 +186,9 @@ static int cpu_pm_suspend(void)
>  		return ret;
>  
>  	ret = cpu_cluster_pm_enter();
> +	if (ret)
> +		cpu_pm_exit();
> +
>  	return ret;
>  }
>  
> 

It is unclear to me why we need this patch as part of the ITS series. I
probably fixes something for you, but I don't see the connection with
the other patches.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
