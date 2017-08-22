From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] thermal/drivers/hisi: Remove confusing error message
Date: Tue, 22 Aug 2017 16:04:27 +0800
Message-ID: <20170822080427.GB13910@leoy-ThinkPad-T440>
References: <1499439833-32531-1-git-send-email-daniel.lezcano@linaro.org>
 <1502178956.4296.7.camel@intel.com>
 <46604862-fbb8-8ed1-8b0d-7a51543b3398@linaro.org>
 <1502196531.4296.41.camel@intel.com>
 <20170808132955.GB32732@leoy-ThinkPad-T440>
 <8f58bd6d-0561-7383-6be4-04ee3704099a@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35719 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932165AbdHVIEg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2017 04:04:36 -0400
Received: by mail-wr0-f178.google.com with SMTP id k46so43330555wre.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2017 01:04:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8f58bd6d-0561-7383-6be4-04ee3704099a@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, edubezval@gmail.com, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, kong.kongxinwei@hisilicon.com

Hi Daniel,

On Mon, Aug 21, 2017 at 12:06:17PM +0200, Daniel Lezcano wrote:

[...]

> Hi Leo,
> 
> a cleanest solution would be either:
> 
>  - add the 3 missing thermal sensors in the DT and default to the id 2

Yeah, so do you think below change works for you?

---8<---

    ARM64: dts: hisilicon: add missed thermal sensors for Hi6220

    The thermal driver tries to register four sensors but the DT only binds
    one sensor (sensor ID 2) with thermal zone, as result the thermal driver
    reports failure for missed thermal sensor binding.

    This patch adds missed thermal sensor for Hi6220, so can dismiss the
    booting failure log.

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index eacbe0d..44c2bc7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -833,6 +833,18 @@
 
                thermal-zones {
 
+                       local: local {
+                               polling-delay = <0>;
+                               polling-delay-passive = <0>;
+                               thermal-sensors = <&tsensor 0>;
+                       };
+
+                       cls1: cls1 {
+                               polling-delay = <0>;
+                               polling-delay-passive = <0>;
+                               thermal-sensors = <&tsensor 1>;
+                       };
+
                        cls0: cls0 {
                                polling-delay = <1000>;
                                polling-delay-passive = <100>;
@@ -862,6 +874,12 @@
                                        };
                                };
                        };
+
+                       gpu: gpu {
+                               polling-delay = <0>;
+                               polling-delay-passive = <0>;
+                               thermal-sensors = <&tsensor 3>;
+                       };
                };
 

> or
> 
>  - remove all the code assuming 4 sensors and deal with the one unique
> sensor

I personally prefer to avoid doing this, if only register one unique
sensor this will let us have no flexiblity for trying multiple sensors
on this platform.

[...]

Thanks,
Leo Yan
