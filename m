From: Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 0/4] thermal: hisilicon: enable power allocator for Hi6220
Date: Tue, 29 Mar 2016 19:27:11 +0800
Message-ID: <1459250835-25561-1-git-send-email-leo.yan@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi6220 has octa-core so it has quite high power consumption when run
benchmark and introduces high temperature for SoC. So need enable
thermal governor to control temperature and also cannot hurt much for
performance after impose cooling operations on CPU.

This patch series is to enable power allocator for Hi6220. Patch 1 is to
change "hysteresis" as optional property for trip points, so when enable
power allocator governor we can ignore this property.

During profiling also found two issues for thermal sensor's driver. The
power allocator just uses only one sensor, so patch 2 is to fix sensor
driver to let it can initialize driver successfully with only enabling
one sensor; patch 3 is to dismiss warning of IRQ imbalance enabling.

After profiling on Hikey, the power model has been simplized with only
dynamic coefficient, and now it's convienence to pass it from CPU node.
So patch 4 and 5 bind sensor and pass power model parameters.

This patch series have been tested on 96boards Hikey.

Changes from v2:
* Discarded patch for changing "hysteresis" as optional property
* Added back "hysteresis" property

Changes from v1:
* According to Javi's review, removed unecessary properties for DT
* Added patch 1 for change "hysteresis" as optional property
* Added patch 3 to fix IRQ imbalance enabling issue


Leo Yan (4):
  thermal: hisilicon: support to use any sensor
  thermal: hisilicon: fix IRQ imbalance enabling
  arm64: dts: register Hi6220's thermal sensor
  arm64: dts: register Hi6220's thermal zone for power allocator

 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 44 +++++++++++++++++++++++++++++++
 drivers/thermal/hisi_thermal.c            | 40 +++++++++++++++++-----------
 2 files changed, 68 insertions(+), 16 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
