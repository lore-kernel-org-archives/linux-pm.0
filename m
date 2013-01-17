From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v6 2/3] x86/nmi: export local_touch_nmi() symbol for
 modules
Date: Thu, 17 Jan 2013 22:35:07 +0800
Message-ID: <1358433307.20319.8.camel@rzhang1-mobl4>
References: <1357297965-17839-1-git-send-email-jacob.jun.pan@linux.intel.com>
	 <1357297965-17839-3-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357297965-17839-3-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Joe Perches <joe@perches.com>, Rob Landley <rob@landley.net>, Arjan van de Ven <arjan@linux.intel.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2013-01-04 at 03:12 -0800, Jacob Pan wrote:
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

applied to thermal -next.

thanks,
rui
> ---
>  arch/x86/kernel/nmi.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index f84f5c5..6030805 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -509,3 +509,4 @@ void local_touch_nmi(void)
>  {
>  	__this_cpu_write(last_nmi_rip, 0);
>  }
> +EXPORT_SYMBOL_GPL(local_touch_nmi);
