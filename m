From: Hongbo Zhang <hongbo.zhang@nxp.com>
Subject: [PSCI DISCUSS] How to implement standby and suspend-to-ram by PSCI
Date: Fri, 6 May 2016 10:11:27 +0000
Message-ID: <DB3PR04MB0812DAA98F71C30E8A8832E3847D0@DB3PR04MB0812.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-db3on0081.outbound.protection.outlook.com ([157.55.234.81]:8944
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752084AbcEFKLa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2016 06:11:30 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Frank Li <Frank.Li@freescale.com>, Peng Fan <Peng.Fan@freescale.com>, Jan Kiszka <jan.kiszka@siemens.com>, Tom Warren <twarren@nvidia.com>, Vincent Guittot <vincent.guittot@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Guys,
We know in the legacy kernel suspend codes, a typical suspend_ops->enter 
callback is like this:

static int imx6q_pm_enter(suspend_state_t state)
{
	switch (state) {
	case PM_SUSPEND_STANDBY:
		do this;
		break;
	case PM_SUSPEND_MEM:
		do that;
		break;
	default:
		return -EINVAL;
	}
	return 0;
}

That means we implement standby and suspend-to-ram in one callback, and 
these two state can be identified by an input parameter 'state'.

While now PSCI is used for ARM to implement cores operations and power 
management, for the above suspend_ops->enter we choose SYSTEM_SUSPEND 
function, and this function is defined for suspend-to-ram, then here 
comes the problem:

How can we implement the standby state following the PSCI framework?

I couldn't find other PSCI function which fits for standby well.
In the spec there isn't such a 'state' parameter passed for 
SYSTEM_SUSPEND (only entry_point_address and context_id), can we change 
the spec a bit, e.g. using one more register to pass another 'state' 
parameter? is that acceptable? (similar like CPU_SUSPEND then)

Any other ideas, suggestions?

Thanks.
