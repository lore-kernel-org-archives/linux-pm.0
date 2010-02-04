From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH] PM: disable nonboot cpus before
	suspending devices
Date: Wed, 3 Feb 2010 17:21:47 -0800
Message-ID: <20100203172147.2411966d.akpm__44252.5788363584$1265246562$gmane$org@linux-foundation.org>
References: <alpine.LFD.2.00.1001221841490.2266@localhost>
	<201002032334.37198.rjw@sisk.pl>
	<20100203150803.5a4b37fe.akpm@linux-foundation.org>
	<201002040150.26503.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002040150.26503.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Benjamin@smtp1.linux-foundation.org, linux-kernel@vger.kernel.org, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 4 Feb 2010 01:50:26 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> --- linux-2.6.orig/mm/page_alloc.c
> +++ linux-2.6/mm/page_alloc.c
> @@ -76,6 +76,30 @@ unsigned long totalreserve_pages __read_
>  int percpu_pagelist_fraction;
>  gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
>  
> +/*
> + * The following functions are used by the suspend/hibernate code to temporarily
> + * change gfp_allowed_mask in order to avoid using I/O during memory allocations
> + * while devices are suspended.  To avoid races with the suspend/hibernate code,
> + * they should always be called with pm_mutex held (gfp_allowed_mask also should
> + * only be modified with pm_mutex held, unless the suspend/hibernate code is
> + * guaranteed not to run in parallel with that modification).
> + */
> +
> +void set_gfp_allowed_mask(gfp_t mask)
> +{
> +	WARN_ON(!mutex_is_locked(&pm_mutex));
> +	gfp_allowed_mask = mask;
> +}
> +
> +gfp_t clear_gfp_allowed_mask(gfp_t mask)
> +{
> +	gfp_t ret = gfp_allowed_mask;
> +
> +	WARN_ON(!mutex_is_locked(&pm_mutex));
> +	gfp_allowed_mask &= ~mask;
> +	return ret;
> +}

Maybe put an ifdef CONFIG_foo around these so they don't get included
when they're unneeded?
