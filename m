From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v7 1/6] cpufreq: powernv: Free 'chips' on module exit
Date: Thu, 28 Jan 2016 13:57:00 +0530
Message-ID: <20160128082700.GH3935@vireshk>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453965941-7363-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au
List-Id: linux-pm@vger.kernel.org

On 28-01-16, 12:55, Shilpasri G Bhat wrote:
> This will free the dynamically allocated memory of'chips' on
> module exit.

Though it has a 'space' issues before 'chips', but I don't really care
much about that and so you aren't required to resend, unless you have
to send a v8 for something else.

> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 547890f..53f980b 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -612,6 +612,7 @@ static void __exit powernv_cpufreq_exit(void)
>  	unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
>  	opal_message_notifier_unregister(OPAL_MSG_OCC,
>  					 &powernv_cpufreq_opal_nb);
> +	kfree(chips);
>  	cpufreq_unregister_driver(&powernv_cpufreq_driver);
>  }
>  module_exit(powernv_cpufreq_exit);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
