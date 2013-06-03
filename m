From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / Hibernate: print physical addresses consistently with other parts of kernel
Date: Mon, 03 Jun 2013 22:00 +0200
Message-ID: <8848877.ak8bloLJeS@vostro.rjw.lan>
References: <20130603182029.16063.60343.stgit@bhelgaas-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:57518 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab3FCTu6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Jun 2013 15:50:58 -0400
In-Reply-To: <20130603182029.16063.60343.stgit@bhelgaas-glaptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

On Monday, June 03, 2013 12:20:29 PM Bjorn Helgaas wrote:
> Print physical address info in a style consistent with the %pR style used
> elsewhere in the kernel.
> 
> 69f1d475cc did this for a similar printk in this file, but I must have
> missed this one.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Queued up for 3.11, thanks Bjorn!

Rafael


> ---
>  kernel/power/snapshot.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 0de2857..7872a35 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -642,8 +642,9 @@ __register_nosave_region(unsigned long start_pfn, unsigned long end_pfn,
>  	region->end_pfn = end_pfn;
>  	list_add_tail(&region->list, &nosave_regions);
>   Report:
> -	printk(KERN_INFO "PM: Registered nosave memory: %016lx - %016lx\n",
> -		start_pfn << PAGE_SHIFT, end_pfn << PAGE_SHIFT);
> +	printk(KERN_INFO "PM: Registered nosave memory: [mem %#010llx-%#010llx]\n",
> +		(unsigned long long) start_pfn << PAGE_SHIFT,
> +		((unsigned long long) end_pfn << PAGE_SHIFT) - 1);
>  }
>  
>  /*
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
