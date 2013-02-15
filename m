From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH] pm: provide stubs for PM VT console switch
 routines
Date: Fri, 15 Feb 2013 18:00:31 +0100
Message-ID: <20130215170030.GE5813@phenom.ffwll.local>
References: <1360945078-27865-1-git-send-email-jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:58325 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978Ab3BOQ6P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Feb 2013 11:58:15 -0500
Received: by mail-ee0-f49.google.com with SMTP id d4so1824085eek.8
        for <linux-pm@vger.kernel.org>; Fri, 15 Feb 2013 08:58:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1360945078-27865-1-git-send-email-jbarnes@virtuousgeek.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org

On Fri, Feb 15, 2013 at 08:17:58AM -0800, Jesse Barnes wrote:
> If PM_SLEEP is disabled, we need stub versions of these functions.
> 
> v2: fix up struct device forward decl.
> 
> Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

Ok, squashed into the old commit and tested. The trick is to disable
HIBERNATE and XEN support (since disabling VT_CONSOLE will also kill fbdev
support and so drm).
-Daniel

> ---
>  include/linux/pm.h |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 98310eb..e5da2f3 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -36,8 +36,17 @@ extern void (*pm_power_off)(void);
>  extern void (*pm_power_off_prepare)(void);
>  
>  struct device; /* we have a circular dep with device.h */
> +#ifdef CONFIG_VT_CONSOLE_SLEEP
>  extern void pm_vt_switch_required(struct device *dev, bool required);
>  extern void pm_vt_switch_unregister(struct device *dev);
> +#else
> +static inline void pm_vt_switch_required(struct device *dev, bool required)
> +{
> +}
> +static inline void pm_vt_switch_unregister(struct device *dev)
> +{
> +}
> +#endif /* CONFIG_VT_CONSOLE_SLEEP */
>  
>  /*
>   * Device power management
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
