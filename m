From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: fix __percpu declaration of
 worker_data
Date: Wed, 30 Jan 2019 10:59:17 +0100
Message-ID: <20190130095917.7uxdxrjvtaeydcol@pathway.suse.cz>
References: <20190119161523.87999-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190119161523.87999-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat 2019-01-19 17:15:23, Luc Van Oostenryck wrote:
> This variable is declared as:
> 	static struct powerclamp_worker_data * __percpu worker_data;
> In other words, a percpu pointer to struct ...
> 
> But this variable not used like so but as a pointer to a percpu
> struct powerclamp_worker_data.
> 
> So fix the declaration as:
> 	static struct powerclamp_worker_data __percpu *worker_data;
> 
> This also quiets Sparse's warnings from __verify_pcpu_ptr(), like:
>   494:49: warning: incorrect type in initializer (different address spaces)
>   494:49:    expected void const [noderef] <asn:3> *__vpp_verify
>   494:49:    got struct powerclamp_worker_data *
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index 7571f7c2e..c7cba20bd 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -101,7 +101,7 @@ struct powerclamp_worker_data {
>  	bool clamping;
>  };
>  
> -static struct powerclamp_worker_data * __percpu worker_data;
> +static struct powerclamp_worker_data __percpu * worker_data;

Makes perfect sense. I wonder why I wrote it in the wrong order.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
