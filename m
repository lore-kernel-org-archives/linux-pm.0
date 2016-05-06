From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PSCI DISCUSS] How to implement standby and suspend-to-ram by
 PSCI
Date: Fri, 6 May 2016 14:28:18 +0100
Message-ID: <572C9BF2.9010004@arm.com>
References: <DB3PR04MB0812DAA98F71C30E8A8832E3847D0@DB3PR04MB0812.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56059 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758073AbcEFN2X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 May 2016 09:28:23 -0400
In-Reply-To: <DB3PR04MB0812DAA98F71C30E8A8832E3847D0@DB3PR04MB0812.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hongbo Zhang <hongbo.zhang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Jan Kiszka <jan.kiszka@siemens.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Frank Li <Frank.Li@freescale.com>, Peng Fan <Peng.Fan@freescale.com>, Tom Warren <twarren@nvidia.com>, Vincent Guittot <vincent.guittot@linaro.org>

Hi Hongbo,

On 06/05/16 11:11, Hongbo Zhang wrote:
> Hi Guys,
> We know in the legacy kernel suspend codes, a typical suspend_ops->enter
> callback is like this:
>

[...]

>
> That means we implement standby and suspend-to-ram in one callback, and
> these two state can be identified by an input parameter 'state'.
>
> While now PSCI is used for ARM to implement cores operations and power
> management, for the above suspend_ops->enter we choose SYSTEM_SUSPEND
> function, and this function is defined for suspend-to-ram, then here
> comes the problem:
>
> How can we implement the standby state following the PSCI framework?
>

Jisheng Zhang raised similar question few months back and we had a
discussion. Please have a look at the thread [1]

> I couldn't find other PSCI function which fits for standby well.
> In the spec there isn't such a 'state' parameter passed for
> SYSTEM_SUSPEND (only entry_point_address and context_id), can we change
> the spec a bit, e.g. using one more register to pass another 'state'
> parameter? is that acceptable? (similar like CPU_SUSPEND then)
>

Since the standby state is not well defined on ARM systems, it's hard to
define the conditions like system suspend and hence difficult to
generalize in the spec. I think suspend-to-idle should suffice in your
case. Anyways its better to get more information on the definition of
standby on your platform.

-- 
Regards,
Sudeep

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/356467.html

