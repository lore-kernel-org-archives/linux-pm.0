From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Add pm_ops_ptr() macro
Date: Sat, 27 Apr 2013 16:40:36 +0200
Message-ID: <20119404.Sfu5WntByi@vostro.rjw.lan>
References: <000001ce42f2$96128cc0$c237a640$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:46363 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292Ab3D0Oc1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 27 Apr 2013 10:32:27 -0400
In-Reply-To: <000001ce42f2$96128cc0$c237a640$@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 'Len Brown' <len.brown@intel.com>, 'Pavel Machek' <pavel@ucw.cz>, linux-pm@vger.kernel.org

On Saturday, April 27, 2013 11:54:50 AM Jingoo Han wrote:
> Add pm_ops_ptr() macro that allows the .pm entry in the driver structures
> to be assigned without having an #define xxx NULL for the case that PM is
> not enabled.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

First, I'm not taking any more PM patches for v3.10 (that don't fix recent
regressions).

Second, please add that macro along with a user.

Thanks,
Rafael


> ---
>  include/linux/pm.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index a224c7f..bd50d15 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -55,8 +55,10 @@ struct device;
>  
>  #ifdef CONFIG_PM
>  extern const char power_group_name[];		/* = "power" */
> +#define pm_ops_ptr(_ptr)	(_ptr)
>  #else
>  #define power_group_name	NULL
> +#define pm_ops_ptr(_ptr)	NULL
>  #endif
>  
>  typedef struct pm_message {
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
