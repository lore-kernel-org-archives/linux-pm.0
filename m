From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Wed, 31 Jul 2013 14:55:50 -0500
Message-ID: <51F96BC6.2020807@ti.com>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <51F80750.8030701@wwwdotorg.org> <51F826A0.2000109@ti.com> <51F8F17B.1020304@arm.com> <51F9234A.6010501@ti.com> <51F92D3B.3070103@arm.com> <51F93303.7010609@ti.com> <51F93DFC.7070904@arm.com> <20130731191353.GA6123@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37022 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760746Ab3GaTz6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 31 Jul 2013 15:55:58 -0400
In-Reply-To: <20130731191353.GA6123@kahuna>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 07/31/2013 02:13 PM, Nishanth Menon wrote:
[...]

> Unless we have two "phandles", we wont be able to do the same. Then
> you'd want to standardize how we do that which is why I made the
> proposal.
>

Let me try a slightly detailed proposal of what I am trying to suggest:

Usage option #1:
Legacy support.

	cpu@0 {
		compatible = "arm,cortex-a9";
		reg = <0>;
		next-level-cache = <&L2>;
		operating-points = <
			/* kHz    uV */
			792000  1100000
			396000  950000
			198000  850000
		>;
	};

Usage option #2:
Maintain only deltas in options from a base.

	cpu@0 {
		compatible = "arm,cortex-a9";
		reg = <0>;
		next-level-cache = <&L2>;
		operating-points-names = "base", "high-performance";
		operating-points-0 = <
			/* kHz    uV */
			792000  1100000
			396000  950000
			198000  850000
		>;
		operating-points-1 = <
			/* kHz    uV */
			1000000 1200000
		>;

	};

Usage option #3: (not compatible definition to #2)
	cpu@0 {
		compatible = "arm,cortex-a9";
		reg = <0>;
		next-level-cache = <&L2>;
		operating-points-names = "default", "high-performance";
		operating-points-0 = <
			/* kHz    uV */
			792000  1100000
			396000  950000
			198000  850000
		>;
		operating-points-1 = <
			/* kHz    uV */
			1000000 1200000
			792000  1100000
			396000  950000
			198000  850000
		>;

	};

Usage option #4 (along with option 3 or 2):
	cpu@1 {
		compatible = "arm,cortex-a9";
		reg = <0>;
		next-level-cache = <&L2>;
		operating-points-device = <&cpu0 high-performance>;
	};

Usage option #5 (along with option 1):
This is the step we are attempting to do in this patch as far as I 
understand.

	cpu@1 {
		compatible = "arm,cortex-a9";
		reg = <0>;
		next-level-cache = <&L2>;
		operating-points-device = <&cpu0>;
	};


board file override option:

&cpu0 {
	operating-points-select = "default";
}

This will prevent selection of high-performance even if efuse is set 
etc.. or force selection of high-performance independent of what efuse says.

This allows us:
a) To maintain dts in a separate repository without being dependent on 
frequencies in kernel code for opp_enable/disable.
b) reasonably proceed towards complete SoC entitlement
c) not have to deal with multiple OPP definitions per board file.


Does that make sense? or do we see concerns?
-- 
Regards,
Nishanth Menon
