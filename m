From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: cpufreq: Unable to set cpufreq to maximum
Date: Thu, 02 Oct 2014 15:59:12 +0200
Message-ID: <1412258352.4875.5.camel@pengutronix.de>
References: <936524880.154802.1412255867221.JavaMail.open-xchange@oxbaltgw07.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49979 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbaJBN7R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 09:59:17 -0400
In-Reply-To: <936524880.154802.1412255867221.JavaMail.open-xchange@oxbaltgw07.schlund.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, festevam@gmail.com, gregkh@linuxfoundation.org

Am Donnerstag, den 02.10.2014, 15:17 +0200 schrieb Stefan Wahren:
> Hi,
> 
> i currently try to get cpufreq-cpu0 aka cpufreq-dt running on Freescale i.MX28
> (ARM). First i ported the regulator driver and now i want to test it with
> cpufreq-cpu0. Everything works fine except changing back to maximum frequency
> 454736 kHz. I get the following error:
> 
> root@duckbill:/sys/devices/system/cpu/cpu0/cpufreq# echo "454736" >
> scaling_setspeed
> [ 1111.226006] cpu cpu0: failed to find OPP for 454736842
> [ 1111.231399] cpufreq: __target_index: Failed to change cpu frequency: -34
> 
> I'm using 3.17.0-rc7-00466-g6f28c5c-dirty #1 Thu Oct 2 12:07:49 UTC 2014
> armv5tejl GNU/Linux and here is the relevant part of the dts file:
> 
> cpus {
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 
> 	cpu@0 {
> 		compatible = "arm,arm926ej-s";
> 		device_type = "cpu";
> 		reg = <0x0>;
> 		operating-points = <
> 			/* kHz	uV */
> 			454736  1550000
> 			392727  1475000
> 			360000  1375000
> 			261818  1275000
> 			64000   1050000
> 		>;
> 		clocks = <&clks 4>;
> 		clock-latency = <61036>; /* two CLK32 periods */
> 		cpu0-supply = <&reg_vddd>;
> 	};
> };
> 
> It looks to me like a rounding problem.
> 
> For the complete history look at:
> http://www.spinics.net/lists/arm-kernel/msg365504.html
> 
> Any ideas?

Isn't your highest OPP just wrong? Apparently the CPU clock (which is a
fixed PLL plus a divider on MX28 if I'm not mistaken) is only able to
provide a slightly higher frequency than your OPP. cpufreq handles that
as an error, which is valid behavior as going higher than the defined
OPP may not be qualified by the vendor.

Does it work if you just change this OPP to 454737 kHz?

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

