From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: cpufreq: Unable to set cpufreq to maximum
Date: Thu, 2 Oct 2014 15:17:47 +0200 (CEST)
Message-ID: <936524880.154802.1412255867221.JavaMail.open-xchange@oxbaltgw07.schlund.de>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:56247 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbaJBNRv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 09:17:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, festevam@gmail.com, gregkh@linuxfoundation.org

Hi,

i currently try to get cpufreq-cpu0 aka cpufreq-dt running on Freescale i.MX28
(ARM). First i ported the regulator driver and now i want to test it with
cpufreq-cpu0. Everything works fine except changing back to maximum frequency
454736 kHz. I get the following error:

root@duckbill:/sys/devices/system/cpu/cpu0/cpufreq# echo "454736" >
scaling_setspeed
[ 1111.226006] cpu cpu0: failed to find OPP for 454736842
[ 1111.231399] cpufreq: __target_index: Failed to change cpu frequency: -34

I'm using 3.17.0-rc7-00466-g6f28c5c-dirty #1 Thu Oct 2 12:07:49 UTC 2014
armv5tejl GNU/Linux and here is the relevant part of the dts file:

cpus {
	#address-cells = <1>;
	#size-cells = <0>;

	cpu@0 {
		compatible = "arm,arm926ej-s";
		device_type = "cpu";
		reg = <0x0>;
		operating-points = <
			/* kHz	uV */
			454736  1550000
			392727  1475000
			360000  1375000
			261818  1275000
			64000   1050000
		>;
		clocks = <&clks 4>;
		clock-latency = <61036>; /* two CLK32 periods */
		cpu0-supply = <&reg_vddd>;
	};
};

It looks to me like a rounding problem.

For the complete history look at:
http://www.spinics.net/lists/arm-kernel/msg365504.html

Any ideas?

Best regards

Stefan
