From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PSCI DISCUSS] How to implement standby and suspend-to-ram by
 PSCI
Date: Tue, 17 May 2016 13:53:56 +0200
Message-ID: <1463486036.19237.9.camel@suse.com>
References: <DB3PR04MB0812DAA98F71C30E8A8832E3847D0@DB3PR04MB0812.eurprd04.prod.outlook.com>
	 <572C9BF2.9010004@arm.com>
	 <DB3PR04MB08125A628F5034749F8109D884730@DB3PR04MB0812.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42489 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807AbcEQL51 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 May 2016 07:57:27 -0400
In-Reply-To: <DB3PR04MB08125A628F5034749F8109D884730@DB3PR04MB0812.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hongbo Zhang <hongbo.zhang@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Jan Kiszka <jan.kiszka@siemens.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Frank Li <Frank.Li@freescale.com>, Peng Fan <Peng.Fan@freescale.com>, Tom Warren <twarren@nvidia.com>, Vincent Guittot <vincent.guittot@linaro.org>, "jszhang@marvell.com" <jszhang@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 2016-05-12 at 09:42 +0000, Hongbo Zhang wrote:
> On our platform we have some shallow states which maps to cpuidle
> well, 
> and we have two more deeper states:
> 
> Sleep state:
> All cores are in WFI state,
> Core cluster is in standby state, e.g. L2 cache is flushed then stops 
> snooping,
> Only those modules which are required to wake up the device still have
> a 
> running clock, other device modules in chip are clock gated.
> 
> Deep sleep state:
> ARM cores and DDR controller are switched off,
> DDR is in self-refresh mode,
> VDD power to off domain IPs are removed, Only the blocks needed to 
> detect wake up and sequence the chip out of deep sleep are on.

For the pm module of the core kernel a low power state is a sleep
state if even one of three conditions is met:

a) a device that can be used for input is not a source of wake ups
b) tasks need to be frozen to enter it
c) the display goes off, while it should be on

Generally runtime PM is better if you can get the same results.
Going to a system sleep state is a necessary evil.

	Regards
		Oliver


