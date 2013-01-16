From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [Update] [PATCH v6 3/3] PM: Introduce Intel PowerClamp Driver
Date: Wed, 16 Jan 2013 21:59:43 +0100
Message-ID: <50F714BF.4080102@intel.com>
References: <1358329528-1286-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28753 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557Ab3APU7q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jan 2013 15:59:46 -0500
In-Reply-To: <1358329528-1286-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

Hi,

Please send a new version of the original patch [3/3] including this fix.

There's no need to resend patches [1-2/3], though.

Thanks,
Rafael


On 1/16/2013 10:45 AM, Jacob Pan wrote:
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>
> ---
> Need to include the proper nmi.h file such that
> local_touch_nmi is always declared.
>
>
>   drivers/thermal/intel_powerclamp.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
> index 314b6fc..81ebf87 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -50,8 +50,8 @@
>   #include <linux/tick.h>
>   #include <linux/debugfs.h>
>   #include <linux/seq_file.h>
> -#include <linux/nmi.h>
>   
> +#include <asm/nmi.h>
>   #include <asm/msr.h>
>   #include <asm/mwait.h>
>   #include <asm/cpu_device_id.h>

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
z siedziba w Gdansku
ul. Slowackiego 173
80-298 Gdansk

Sad Rejonowy Gdansk Polnoc w Gdansku, 
VII Wydzial Gospodarczy Krajowego Rejestru Sadowego, 
numer KRS 101882

NIP 957-07-52-316
Kapital zakladowy 200.000 zl

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

