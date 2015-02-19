From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH v3 2/5] thermal: fair_share: use the weight from the
 thermal instance
Date: Thu, 19 Feb 2015 05:40:12 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59090DD597@BGSMSX101.gar.corp.intel.com>
References: <1424275465-16144-1-git-send-email-javi.merino@arm.com>
 <1424275465-16144-3-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43998 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbbBSFkT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 00:40:19 -0500
In-Reply-To: <1424275465-16144-3-git-send-email-javi.merino@arm.com>
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
>Subject: [PATCH v3 2/5] thermal: fair_share: use the weight from the thermal instance
>
>The fair share governor is not usable with thermal zones that use the
>bind op and don't populate thermal_zone_parameters, the majority of
>them.  Now that the weight is in the thermal instance, we can use that
>in the fair share governor to allow every thermal zone to trivially use
>this governor.  Furthermore, this simplifies the code.

Reviewed-by: Durgadoss R <durgadoss.r@intel.com>

>
>Cc: Zhang Rui <rui.zhang@intel.com>
>Cc: Eduardo Valentin <edubezval@gmail.com>
>Cc: Durgadoss R <durgadoss.r@intel.com>
>Signed-off-by: Javi Merino <javi.merino@arm.com>
>---
> drivers/thermal/fair_share.c | 17 +++--------------
> 1 file changed, 3 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
>index c3b25187b467..9e392d34ac9f 100644
>--- a/drivers/thermal/fair_share.c
>+++ b/drivers/thermal/fair_share.c
>@@ -88,24 +88,13 @@ static long get_target_state(struct thermal_zone_device *tz,
>  */
> static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
> {
>-	const struct thermal_zone_params *tzp;
>-	struct thermal_cooling_device *cdev;
> 	struct thermal_instance *instance;
>-	int i;
> 	int cur_trip_level = get_trip_level(tz);
>
>-	if (!tz->tzp || !tz->tzp->tbp)
>-		return -EINVAL;
>+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>+		struct thermal_cooling_device *cdev = instance->cdev;
>
>-	tzp = tz->tzp;
>-
>-	for (i = 0; i < tzp->num_tbps; i++) {
>-		if (!tzp->tbp[i].cdev)
>-			continue;
>-
>-		cdev = tzp->tbp[i].cdev;
>-		instance = get_thermal_instance(tz, cdev, trip);
>-		if (!instance)
>+		if (instance->trip != trip)
> 			continue;
>
> 		instance->target = get_target_state(tz, cdev,
>--
>1.9.1

