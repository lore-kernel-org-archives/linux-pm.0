From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH resend] intel_rapl: downgrade message if no RAPL domains
 found in a VM
Date: Tue, 19 Jul 2016 05:27:59 -0700
Message-ID: <20160719052759.3de2d31f@jacob-builder>
References: <1468928997-20431-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468928997-20431-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, jacob.jun.pan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Tue, 19 Jul 2016 13:49:57 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> People complain about the driver saying there's no valid RAPL domains
> in a VM, and doing so at KERN_ERR severity.  Downgrade this to
> KERN_INFO if running on a hypervisor, since it is basically stating
> the obvious.
> 
Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

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
> diff --git a/drivers/powercap/intel_rapl.c
> b/drivers/powercap/intel_rapl.c index b2766b867b0e..0a0b09910116
> 100644 --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -1392,7 +1392,9 @@ static int rapl_detect_domains(struct
> rapl_package *rp, int cpu) }
>  	rp->nr_domains = bitmap_weight(&rp->domain_map,
> RAPL_DOMAIN_MAX); if (!rp->nr_domains) {
> -		pr_err("no valid rapl domains found in package
> %d\n", rp->id);
> +		printk("%sNo valid RAPL domains found in package
> %d\n",
> +		       boot_cpu_has(X86_FEATURE_HYPERVISOR) ?
> KERN_INFO : KERN_ERR,
> +		       rp->id);
>  		ret = -ENODEV;
>  		goto done;
>  	}
