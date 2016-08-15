From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/power/64: Use __pa() for physical address computation
Date: Mon, 15 Aug 2016 07:10:42 +0200
Message-ID: <20160815051042.GC16267@gmail.com>
References: <5387760.qC5CG883jv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33456 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbcHOFKr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Aug 2016 01:10:47 -0400
Content-Disposition: inline
In-Reply-To: <5387760.qC5CG883jv@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


* Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The value of temp_level4_pgt is the physical address of the
> top-level page directory, so use __pa() to compute it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/x86/power/hibernate_64.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/arch/x86/power/hibernate_64.c
> ===================================================================
> --- linux-pm.orig/arch/x86/power/hibernate_64.c
> +++ linux-pm/arch/x86/power/hibernate_64.c
> @@ -113,7 +113,7 @@ static int set_up_temporary_mappings(voi
>  			return result;
>  	}
>  
> -	temp_level4_pgt = (unsigned long)pgd - __PAGE_OFFSET;
> +	temp_level4_pgt = __pa(pgd);
>  	return 0;
>  }

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
