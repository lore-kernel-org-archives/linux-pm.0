From: Tai Nguyen <ttnguyen-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 0/2] power: reset: Add syscon reboot/poweroff device nodes for APM X-Gene platform
Date: Fri,  1 May 2015 13:11:12 -0700
Message-ID: <1430511074-32229-1-git-send-email-ttnguyen@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org
Cc: ttnguyen-qTEPVZfXA3Y@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch set adds syscon reboot/poweroff device nodes to support reboot and
poweroff features on X-Gene platform. 

Tai Nguyen (2):
  power: reset: Add syscon reboot device node for APM X-Gene platform
  power: reset: Add syscon poweroff device node for APM X-Gene Mustang platform

 arch/arm64/boot/dts/apm/apm-mustang.dts |   12 ++++++++++++
 arch/arm64/boot/dts/apm/apm-storm.dtsi  |   12 ++++++++++++
 2 files changed, 24 insertions(+)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
