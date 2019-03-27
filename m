From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI
 wakeup
Date: Wed, 27 Mar 2019 16:44:39 +0100
Message-ID: <1553701479.2561.38.camel@pengutronix.de>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abel Vesa <abel.vesa@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Abel,

Am Mittwoch, den 27.03.2019, 13:21 +0000 schrieb Abel Vesa:
> This work is a workaround I'm looking into (more as a background task)
> in order to add support for cpuidle on i.MX8MQ based platforms.
> 
> The main idea here is getting around the missing GIC wake_request signal
> (due to integration design issue) by waking up a each individual core through
> some dedicated SW power-up bits inside the power controller (GPC) right before
> every IPI is requested for that each individual core.

Just a general comment, without going into the details of this series:
this issue is not only affecting IPIs, but also MSIs terminated at the
GIC. Currently MSIs are terminated at the PCIe core, but terminating
them at the GIC is clearly preferable, as this allows assigning CPU
affinity to individual MSIs and lowers IRQ service overhead.

I'm not sure what the consequences are for upstream Linux support yet,
but we should keep in mind that having a workaround for IPIs is only
solving part of the issue.

Regards,
Lucas
