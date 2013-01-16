From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH RESEND 2/4] thermal: remove unnecessary include
Date: Wed, 16 Jan 2013 10:43:50 +0800
Message-ID: <1358304230.2252.24.camel@rzhang1-mobl4>
References: <1357140582-8151-1-git-send-email-eduardo.valentin@ti.com>
	 <1357140582-8151-3-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55733 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756013Ab3APCn5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Jan 2013 21:43:57 -0500
In-Reply-To: <1357140582-8151-3-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: durgadoss.r@intel.com, linux-pm@lists.linux-foundation.org, linux-pm@vger.kernel.org

On Wed, 2013-01-02 at 17:29 +0200, Eduardo Valentin wrote:
> No need for spinlocks in this file, then removing its header.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

applied to thermal -next.

thanks,
rui
> ---
>  drivers/thermal/thermal_sys.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index d85f51f..70ce100 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -32,7 +32,6 @@
>  #include <linux/kdev_t.h>
>  #include <linux/idr.h>
>  #include <linux/thermal.h>
> -#include <linux/spinlock.h>
>  #include <linux/reboot.h>
>  #include <net/netlink.h>
>  #include <net/genetlink.h>


