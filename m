From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/8] cpu_pm: add syscore_suspend error handling
Date: Fri, 12 Jan 2018 14:07:32 -0800
Message-ID: <20180112220731.GA185474@google.com>
References: <20180112212422.148625-1-dbasehore@chromium.org>
 <20180112212422.148625-2-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112212422.148625-2-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, marc.zyngier@arm.com
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 12, 2018 at 01:24:15PM -0800, Derek Basehore wrote:
> If cpu_cluster_pm_enter() fails, cpu_pm_exit() should be called. This
> will put the CPU in the correct state to resume from the failure.
> 
> Change-Id: I4e499d686ea6046103be355d3a92bb0d51525f53

If you ran checkpatch.pl, it would warn you not to include Gerrit IDs
here :)

Brian

> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
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
> -- 
> 2.16.0.rc1.238.g530d649a79-goog
> 
