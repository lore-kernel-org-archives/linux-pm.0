From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: Fix cdev registration with THERMAL_NO_LIMIT on
 64bit
Date: Wed, 10 Dec 2014 09:57:37 +0800
Message-ID: <1418176657.12435.40.camel@rzhang1-toshiba>
References: <1418127721-1182-1-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39999 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213AbaLJB5l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Dec 2014 20:57:41 -0500
In-Reply-To: <1418127721-1182-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Tue, 2014-12-09 at 12:22 +0000, Punit Agrawal wrote:
> The size of unsigned long varies between 32 and 64 bit systems while
> the size of phandle arguments is always 32 bits per parameter.
> 
> On 64-bit systems, cooling devices registered via of-thermal apis fail
> to bind when the min/max cooling state is specified as
> THERMAL_NO_LIMIT (-1UL) as there is a mis-match between the value read
> from the device tree (32bit) and the pre-processor define (64bit).
> 
> As we're unlikely to need cooling states larger than 32 bits, and for
> consistency with the size of phandle arguments, explicitly limit
> THERMAL_NO_LIMIT to 32 bits.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
>  include/dt-bindings/thermal/thermal.h | 2 +-
>  include/linux/thermal.h               | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/dt-bindings/thermal/thermal.h b/include/dt-bindings/thermal/thermal.h
> index 59822a9..b5e6b00 100644
> --- a/include/dt-bindings/thermal/thermal.h
> +++ b/include/dt-bindings/thermal/thermal.h
> @@ -11,7 +11,7 @@
>  #define _DT_BINDINGS_THERMAL_THERMAL_H
>  
>  /* On cooling devices upper and lower limits */
> -#define THERMAL_NO_LIMIT		(-1UL)
> +#define THERMAL_NO_LIMIT		(~0)
>  
I'm okay with the other change, so Eduardo, what do you think of this?

thanks,
rui
>  #endif
>  
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index ef90838..005586f 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -38,7 +38,7 @@
>  #define THERMAL_CSTATE_INVALID -1UL
>  
>  /* No upper/lower limit requirement */
> -#define THERMAL_NO_LIMIT	THERMAL_CSTATE_INVALID
> +#define THERMAL_NO_LIMIT	((u32)~0)
>  
>  /* Unit conversion macros */
>  #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\


