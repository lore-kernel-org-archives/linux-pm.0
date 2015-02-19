From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH v3 3/5] thermal: fair_share: fix typo
Date: Thu, 19 Feb 2015 05:40:48 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59090DD5A4@BGSMSX101.gar.corp.intel.com>
References: <1424275465-16144-1-git-send-email-javi.merino@arm.com>
 <1424275465-16144-4-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33739 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbbBSFkx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 00:40:53 -0500
In-Reply-To: <1424275465-16144-4-git-send-email-javi.merino@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>, "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

>-----Original Message-----
>From: Javi Merino [mailto:javi.merino@arm.com]
>Sent: Wednesday, February 18, 2015 9:34 PM
>To: Zhang, Rui; edubezval@gmail.com
>Cc: linux-pm@vger.kernel.org; Javi Merino; R, Durgadoss
>Subject: [PATCH v3 3/5] thermal: fair_share: fix typo
>
>s/asscciated/associated/

Good catch,

Reviewed-by: Durgadoss R <durgadoss.r@intel.com>

>
>Cc: Zhang Rui <rui.zhang@intel.com>
>Cc: Eduardo Valentin <edubezval@gmail.com>
>Cc: Durgadoss R <durgadoss.r@intel.com>
>Signed-off-by: Javi Merino <javi.merino@arm.com>
>---
> drivers/thermal/fair_share.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
>index 9e392d34ac9f..692f4053f08b 100644
>--- a/drivers/thermal/fair_share.c
>+++ b/drivers/thermal/fair_share.c
>@@ -69,7 +69,7 @@ static long get_target_state(struct thermal_zone_device *tz,
> }
>
> /**
>- * fair_share_throttle - throttles devices asscciated with the given zone
>+ * fair_share_throttle - throttles devices associated with the given zone
>  * @tz - thermal_zone_device
>  *
>  * Throttling Logic: This uses three parameters to calculate the new
>--
>1.9.1

