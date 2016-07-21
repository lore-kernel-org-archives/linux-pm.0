From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH resend] intel_rapl: downgrade message if no RAPL domains found in a VM
Date: Thu, 21 Jul 2016 15:19:28 +0200
Message-ID: <1617795.yheICcaOFs@vostro.rjw.lan>
References: <1468928997-20431-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46327 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752478AbcGUNOf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2016 09:14:35 -0400
In-Reply-To: <1468928997-20431-1-git-send-email-pbonzini@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>

On Tuesday, July 19, 2016 01:49:57 PM Paolo Bonzini wrote:
> People complain about the driver saying there's no valid RAPL domains
> in a VM, and doing so at KERN_ERR severity.  Downgrade this to KERN_INFO
> if running on a hypervisor, since it is basically stating the obvious.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 	First sent out about a year ago. :)
> 
>  drivers/powercap/intel_rapl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index b2766b867b0e..0a0b09910116 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -1392,7 +1392,9 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
>  	}
>  	rp->nr_domains = bitmap_weight(&rp->domain_map,	RAPL_DOMAIN_MAX);
>  	if (!rp->nr_domains) {
> -		pr_err("no valid rapl domains found in package %d\n", rp->id);
> +		printk("%sNo valid RAPL domains found in package %d\n",
> +		       boot_cpu_has(X86_FEATURE_HYPERVISOR) ? KERN_INFO : KERN_ERR,
> +		       rp->id);

But we print that message with pr_debug() now (as in linux-next).

Do you still want to do anything about that?

>  		ret = -ENODEV;
>  		goto done;
>  	}
> 

Thanks,
Rafael

