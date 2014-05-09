From: Jonghwan Choi <jhbird.choi@samsung.com>
Subject: RE: [PATCH 1/3] PM / OPP: Add support for descending order for cpufreq
 table
Date: Fri, 09 May 2014 10:09:37 +0900
Message-ID: <000e01cf6b23$58fda900$0af8fb00$@samsung.com>
References: <000001cf643d$69e5e350$3db1a9f0$@samsung.com>
 <CAOh2x=m8DzmLOGqL0E_seOZMuzU=O9vQuu-JEp+E5454RmfEXw@mail.gmail.com>
 <003901cf6664$e4e8d2a0$aeba77e0$@samsung.com>
 <CAKohpon7W726Hxj5OJ6SnmPz3gYhAeBRr1wS3SCa3F2hSLriLQ@mail.gmail.com>
 <5367946F.1030407@ti.com>
 <CAKohpon-KZpSJK7PxpLjZS7sVPcYraDxb4oJHN6dxSagD+F--Q@mail.gmail.com>
 <CAGo_u6pUVeMM9mqe5htvM1X_4pkRGEUVOA2ty4ZPfUyLcLZkrw@mail.gmail.com>
 <CAKohpokfcptseU6ST+e_GfU6poVJxXCXMeoYCvT65060v5GJYQ@mail.gmail.com>
 <003e01cf6984$fb950280$f2bf0780$@samsung.com>
 <CAGo_u6o0J_T_hnmDAiYpsDxe77iKPCjuWisZJfTjYYOVGJF96A@mail.gmail.com>
 <CAKohpo=qbj9w5=wWHEG=9c2spjbbhaDaXG+F-Lhe9QffV9sDbw@mail.gmail.com>
 <001501cf6a5c$07bc2520$17346f60$@samsung.com>
 <CAGo_u6rAY1Cqh6_1RPsjGMwqNSVr=yW+VgyXfEjA6V+LT-SMcQ@mail.gmail.com>
 <000301cf6a62$413c16b0$c3b44410$@samsung.com>
 <CAKohponiuHYjLve5ywLSGtDPPFN9a54gzZUicn1m702B2Ct3Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53876 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbaEIBJj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 May 2014 21:09:39 -0400
In-reply-to: <CAKohponiuHYjLve5ywLSGtDPPFN9a54gzZUicn1m702B2Ct3Pw@mail.gmail.com>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: 'Nishanth Menon' <nm@ti.com>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'open list' <linux-kernel@vger.kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Len Brown' <len.brown@intel.com>, 'Amit Daniel Kachhap' <amit.daniel@samsung.com>

On 8 May 2014 2:56 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> 
> Not necessarily. People may need a multiplier as well or some other
> configuration and so this stuff was left for drivers to implement.

-> In exynos cpufreq driver, if we want to support more frequency, then 
we have to describe frequency information in dts file and have to change exynos cpufreq
 driver file also(For adding divider value). 
But if dev_pm_opp has a divider value for DVFS,when we want to support more frequency 
we have only to change the dts file.

I think that it is easy to maintain cpufreq driver and very convenient.
(Can be applied to devfreq)

This is a example (exynos4210 doesn't support DT.)

--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -64,6 +64,7 @@ struct dev_pm_opp {
        bool available;
        unsigned long rate;
        unsigned long u_volt;
+       unsigned int ctl[2];

        struct device_opp *dev_opp;
        struct rcu_head head;
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index cacf614..007a411 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -81,6 +81,24 @@
                interrupts = <2 2>, <3 2>;
        };

+       cpufreq@160000 {
+               compatible = "samsung,exynos7842-cpufreq";
+               reg = <0x160000 0x1000>;
+               interrupts = <0 57 0>;
+               operating-points = <
+                               /* KHz    uV    clkdiv0 clkdiv1 */
+                               1500000 1100000 0x11111 0x11111
+                               1400000 1075000 0x22223 0x22222
+                               1300000 1050000 0x33333 0x33333
+                               1200000 1025000 0x44444 0x44444
+                               1100000 1000000 0x55555 0x55555
+                               1000000 975000  0x66666 0x66666
+                               900000  950000  0x77777 0x77777
+                               800000  925000  0x88888 0x88888
+               >;
+       };
+
+
        pinctrl_0: pinctrl@11400000 {
                compatible = "samsung,exynos4210-pinctrl";
                reg = <0x11400000 0x1000>;


Thanks

Best Regards.

