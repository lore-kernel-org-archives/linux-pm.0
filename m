From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V9] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Sat, 4 Feb 2017 10:36:23 +0100 (CET)
Message-ID: <48317588.166823.1486200983836@email.1und1.de>
References: <1483808145-6206-1-git-send-email-kernel@martin.sperl.org>
 <20170120041400.GA24617@localhost.localdomain>
 <060918B6-A773-46A5-8D10-C9F6BBA6D3F1@martin.sperl.org>
 <20170124093127.GB3651@localhost.localdomain>
 <0452720A-5914-469B-9EF7-0581CF1B5478@martin.sperl.org>
 <20170202042930.GA6377@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:49384 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753811AbdBDJhG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Feb 2017 04:37:06 -0500
In-Reply-To: <20170202042930.GA6377@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-arm-kernel@lists.infradead.org, kernel@martin.sperl.org

Hi Eduardo,

> Eduardo Valentin <edubezval@gmail.com> hat am 2. Februar 2017 um 05:29 geschrieben:
> 
> 
> Hello Martin,
> 
> ...
> 
> 
> #include <dt-bindings/thermal/thermal.h>
> 
> ocp {
> 	...
> 	/*
> 	 * A simple IC with several bandgap temperature sensors.
> 	 */
> 	bandgap0: bandgap@0x0000ED00 {
> 		...
> 		#thermal-sensor-cells = <1>;
> 	};
> };
> 
> thermal-zones {
> 	cpu_thermal: cpu-thermal {
> 		polling-delay-passive = <250>; /* milliseconds */
> 		polling-delay = <1000>; /* milliseconds */
> 
> 				/* sensor       ID */
> 		thermal-sensors = <&bandgap0     0>;
> 
> 		trips {
> 			/* each zone within the SoC may have its own trips */
> 			cpu_alert: cpu-alert {
> 				temperature = <100000>; /* millicelsius */
> 				hysteresis = <2000>; /* millicelsius */
> 				type = "passive";
> 			};
> 			cpu_crit: cpu-crit {
> 				temperature = <125000>; /* millicelsius */
> 				hysteresis = <2000>; /* millicelsius */
> 				type = "critical";
> 			};
> 		};
> 
> 		cooling-maps {
> 			/* each zone within the SoC may have its own cooling */
> 			...
> 		};
> 	};
> 

if i get it right the device tree binding requires also a cooling map. But how should we model this without a fan or a DVFS driver? Is there something like a placeholder? Do you have an example?

Regards
Stefan
