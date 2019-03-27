From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI
 wakeup
Date: Wed, 27 Mar 2019 18:11:48 +0100
Message-ID: <1553706708.2561.42.camel@pengutronix.de>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
         <1553701479.2561.38.camel@pengutronix.de>
         <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
         <1553702767.2561.40.camel@pengutronix.de>
         <d31f84030f48f3dad9dd5d144724979543006406.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d31f84030f48f3dad9dd5d144724979543006406.camel@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, Richard Zhu <hongxing.zhu@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Mircea Pop <mircea.pop@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Aisheng Dong <aisheng.dong@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Robert Chiras <robert.chiras@nxp.com>, Anson Huang <anson.huang@nxp.com>, Jun Li <jun.li@nxp.com>, Abel Vesa <abel.vesa@nxp.com>, "robh@kernel.org" <robh@kernel.org>, Zening Wang <zening.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, BOUGH CHEN <haibo.chen@nxp.com>, Horia Geanta <horia.geanta@nxp.com>, Peter Chen <peter.chen@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Leo
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, den 27.03.2019, 17:00 +0000 schrieb Leonard Crestez:
> On Wed, 2019-03-27 at 17:06 +0100, Lucas Stach wrote:
> > Am Mittwoch, den 27.03.2019, 15:57 +0000 schrieb Marc Zyngier:
> > > On 27/03/2019 15:44, Lucas Stach wrote:
> > > > Am Mittwoch, den 27.03.2019, 13:21 +0000 schrieb Abel Vesa:
> > > > > This work is a workaround I'm looking into (more as a
> > > > > background task)
> > > > > in order to add support for cpuidle on i.MX8MQ based
> > > > > platforms.
> > > > > 
> > > > > The main idea here is getting around the missing GIC
> > > > > wake_request signal
> > > > > (due to integration design issue) by waking up a each
> > > > > individual core through
> > > > > some dedicated SW power-up bits inside the power controller
> > > > > (GPC) right before
> > > > > every IPI is requested for that each individual core.
> > > > 
> > > > Just a general comment, without going into the details of this
> > > > series:
> > > > this issue is not only affecting IPIs, but also MSIs terminated
> > > > at the
> > > > GIC. Currently MSIs are terminated at the PCIe core, but
> > > > terminating
> > > > them at the GIC is clearly preferable, as this allows assigning
> > > > CPU
> > > > affinity to individual MSIs and lowers IRQ service overhead.
> > > > 
> > > > I'm not sure what the consequences are for upstream Linux
> > > > support yet,
> > > > but we should keep in mind that having a workaround for IPIs is
> > > > only
> > > > solving part of the issue.
> > > 
> > > If this erratum is affecting more than just IPIs, then indeed I
> > > don't
> > > see how this patch series solves anything.
> > > 
> > > But the erratum documentation seems to imply that only SGIs are
> > > affected, and goes as far as suggesting to use an external
> > > interrupt
> > > would solve it. How comes this is not the case? Or is it that
> > > anything
> > > directly routed to a redistributor is also affected? This would
> > > break
> > > LPIs (and thus MSIs) and PPIs (the CPU timer, among others).
> > > 
> > > What is the *exact* status of this thing? I have the ugly feeling
> > > that
> > > the true workaround is just to disable cpuidle.
> > 
> > As far as I understand the erratum, the basic issue is that the GIC
> > wake_request signals are not connected to the GPC (the
> > CPU/peripheral
> > power sequencer). The SPIs are routed through the GPC and thus are
> > visible as wakeup sources, which is why the workaround of using an
> > external SPI as wakeup trigger for the IPI works.
> 
> We had a kernel workaround for IPIs in our internal tree for a long
> time and I don't think we do anything special for PCI. Does PCI MSI
> really bypass the GPC on 8mq?
> 
> Adding Richard/Jacky, they might know about this.

Currently the MSIs are terminated at the PCIe controller and routed to
the CPU via a normal interrupt line that is going through the GPC, so
there are no workaround required today.

But then this setup severely limits the usefulness of PCI MSIs, as they
incur an additional overhead of working with the DWC MSI controller and
are unable to target a specific CPU, as they are all routed via a
single IRQ line.

> This seems like something of a corner case to me, don't many imx
> boards
> ship without PCI; especially for low-power scenarios? If required it
> might be reasonable to add an additional workaround to disable all
> cpuidle if pci msis are used.

I don't know how common using PCIe with the i.MX8M is, but even the
reference board ships with the WLAN connected to PCIe.

I'm working with a design that has both a multi-queue and TSN capable
ethernet card connected to one PCIe controller and a NVMe SSD with
multiple queues connected to the second controller. Being able to
terminate the MSIs at the GIC level and have proper CPU affinity makes
a lot of sense in that scenario.

Regards,
Lucas
