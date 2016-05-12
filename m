From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PSCI DISCUSS] How to implement standby and suspend-to-ram by
 PSCI
Date: Thu, 12 May 2016 11:08:46 +0100
Message-ID: <5734562E.40303@arm.com>
References: <DB3PR04MB0812DAA98F71C30E8A8832E3847D0@DB3PR04MB0812.eurprd04.prod.outlook.com>
 <572C9BF2.9010004@arm.com>
 <DB3PR04MB08125A628F5034749F8109D884730@DB3PR04MB0812.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57345 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbcELKIu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 12 May 2016 06:08:50 -0400
In-Reply-To: <DB3PR04MB08125A628F5034749F8109D884730@DB3PR04MB0812.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hongbo Zhang <hongbo.zhang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, "jszhang@marvell.com" <jszhang@marvell.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Frank Li <Frank.Li@freescale.com>, Marc Zyngier <marc.zyngier@arm.com>, Jan Kiszka <jan.kiszka@siemens.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Peng Fan <Peng.Fan@freescale.com>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Tom Warren <twarren@nvidia.com>, Vincent Guittot <vincent.guittot@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



On 12/05/16 10:42, Hongbo Zhang wrote:
> Hi Sudeep,
> 

[...]

> 
> Sleep state:
> All cores are in WFI state,
> Core cluster is in standby state, e.g. L2 cache is flushed then stops
> snooping,
> Only those modules which are required to wake up the device still have a
> running clock, other device modules in chip are clock gated.
> 
> Deep sleep state:
> ARM cores and DDR controller are switched off,
> DDR is in self-refresh mode,
> VDD power to off domain IPs are removed, Only the blocks needed to
> detect wake up and sequence the chip out of deep sleep are on.
> 
> For the two states, except for the wake-up devices, all the other device
> dirver's suspend callback needs to be called because those devices will
> be clock or power gated off. So, the kernel suspend process (freeze
> tasks, suspend devices etc) are needed for our sleep and deep sleep states.
> In fact we've already implemented these two stated by legacy way, e.g.
> mapping sleep state to STANDBY and deep sleep to MEM, both states are
> implemented in one traditional .enter callback and can be indexed by a
> 'state' parameter.
> 

Yes I understand that.

> While transferring to PSCI, we met the problem I mentioned.
> 
> As to the freeze(suspend-to-idle), it is described as "a generic, pure
> software, light-weight, system sleep state" in the Document, and the
> fact is only acpi is using it, 

No, it independent of ACPI. It can be used on any platform with CPUIdle
support.

> what's more, I don't think it satisfy us
> well, because the freeze_enter() is executed before
> disable_nonboot_cpus() and syscore_suspend(), while the later two are
> necessary for us.
> 

Care to explain ? With suspend-to-idle, wakeup latency is much lesser as
the CPUs are not hotplugged out. I don't think it makes huge different
with power on ARM platforms. So its is much better than standby which
does CPU hotplugging IMO.

> So it seems another 'state' parameter for SYSTEM_SUSPEND can settle this
> problem, but it is lack in the spec.
> 

If you still think you can't make use of suspend-to-idle with added
advantage of reduced wakeup latency, please send email with all the
details to errata@arm.com as suggested in the PSCI specification.

> There are diverse kinds of ARM SOC, and divers kind of peripheral
> devices in each SOC, so even for the SYSTEM_SUSPEND, there may be
> different states too(deeper or shallower states of each device, more or
> less of devices are put to idle), the more the PSCI spec supports, the
> better.
> 

With runtime PM, you can work out on the peripheral device PM directly,
so I can't imagine how the diversity there adds to SYSTEM_SUSPEND
complexity.

-- 
Regards,
Sudeep
