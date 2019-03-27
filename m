From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Date: Wed, 27 Mar 2019 15:57:53 +0000
Message-ID: <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
 <1553701479.2561.38.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553701479.2561.38.camel@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Abel Vesa <abel.vesa@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27/03/2019 15:44, Lucas Stach wrote:
> Hi Abel,
> 
> Am Mittwoch, den 27.03.2019, 13:21 +0000 schrieb Abel Vesa:
>> This work is a workaround I'm looking into (more as a background task)
>> in order to add support for cpuidle on i.MX8MQ based platforms.
>>
>> The main idea here is getting around the missing GIC wake_request signal
>> (due to integration design issue) by waking up a each individual core through
>> some dedicated SW power-up bits inside the power controller (GPC) right before
>> every IPI is requested for that each individual core.
> 
> Just a general comment, without going into the details of this series:
> this issue is not only affecting IPIs, but also MSIs terminated at the
> GIC. Currently MSIs are terminated at the PCIe core, but terminating
> them at the GIC is clearly preferable, as this allows assigning CPU
> affinity to individual MSIs and lowers IRQ service overhead.
> 
> I'm not sure what the consequences are for upstream Linux support yet,
> but we should keep in mind that having a workaround for IPIs is only
> solving part of the issue.

If this erratum is affecting more than just IPIs, then indeed I don't
see how this patch series solves anything.

But the erratum documentation seems to imply that only SGIs are
affected, and goes as far as suggesting to use an external interrupt
would solve it. How comes this is not the case? Or is it that anything
directly routed to a redistributor is also affected? This would break
LPIs (and thus MSIs) and PPIs (the CPU timer, among others).

What is the *exact* status of this thing? I have the ugly feeling that
the true workaround is just to disable cpuidle.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
