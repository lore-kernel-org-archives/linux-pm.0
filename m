From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: PM/runtime issue: Device cannot runtime resume because power domain is
 off during system resume
Date: Thu, 16 Oct 2014 16:05:02 +0200
Message-ID: <1413468302.5605.9.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:43160 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbaJPOFG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Oct 2014 10:05:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

I encounter issues with DRM/panel driver for Exynos after resuming from
suspend to RAM. This is reproduced on 3.16 but I think it is applicable
also to mainline.

The scenario:
0. DRM DSI is in LCD power domain. Power domain is OFF before
suspending.
1. System suspends.
2. System resumes.
3. DRM driver:resume().
4. pm_runtime_get() for DRM DSI driver.
5. This should enable LCD power domain.
6. but __pm_genpd_poweron() exits early because:
   genpd->prepared_count = 3
   genpd->suspend_power_off = 1
  in domain.c:183

7. The domain is not powered on but it is marked as active.
8. The DRM driver thinks everything is OK and proceeds with resume...
but it fails because whole power domain is OFF.

The question: Shouldn't the power domain be powered up EARLY?

Something like this:

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 40bc2f4072cc..4fdfe404a04c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -179,8 +179,7 @@ static int __pm_genpd_poweron(struct
        }
        finish_wait(&genpd->status_wait_queue, &wait);
 
-       if (genpd->status == GPD_STATE_ACTIVE
-           || (genpd->prepared_count > 0 && genpd->suspend_power_off))
+       if (genpd->status == GPD_STATE_ACTIVE)
                return 0;
 
        if (genpd->status != GPD_STATE_POWER_OFF) {


If not... how to solve the scenario above?

Best regards,
Krzyszto

