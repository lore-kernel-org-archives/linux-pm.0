From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH RESEND 2/4] thermal: remove unnecessary include
Date: Wed, 2 Jan 2013 15:48:54 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59252E2B@BGSMSX101.gar.corp.intel.com>
References: <1357140582-8151-1-git-send-email-eduardo.valentin@ti.com>
 <1357140582-8151-3-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65196 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919Ab3ABPt2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jan 2013 10:49:28 -0500
In-Reply-To: <1357140582-8151-3-git-send-email-eduardo.valentin@ti.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> -----Original Message-----
> From: Eduardo Valentin [mailto:eduardo.valentin@ti.com]
> Sent: Wednesday, January 02, 2013 9:00 PM
> To: Zhang, Rui
> Cc: R, Durgadoss; linux-pm@lists.linux-foundation.org; linux-
> pm@vger.kernel.org; Eduardo Valentin
> Subject: [PATCH RESEND 2/4] thermal: remove unnecessary include
> 
> No need for spinlocks in this file, then removing its header.

Good Catch !!

> 

Reviewed-by: Durgadoss R <durgadoss.r@intel.com>

Thanks,
Durga

> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
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
> --
> 1.7.7.1.488.ge8e1c

