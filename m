From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [RFC 0/7] cpuidle: Add poking mechanism to support non-IPI wakeup
Date: Wed, 27 Mar 2019 18:13:20 +0000
Message-ID: <0ac4b527-2f79-4d21-7408-18c87cadb512@arm.com>
References: <1553692845-20983-1-git-send-email-abel.vesa@nxp.com>
 <1553701479.2561.38.camel@pengutronix.de>
 <564216aa-1144-71de-e887-00c58f466bf5@arm.com>
 <1553702767.2561.40.camel@pengutronix.de>
 <d31f84030f48f3dad9dd5d144724979543006406.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d31f84030f48f3dad9dd5d144724979543006406.camel@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Leonard Crestez <leonard.crestez@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, Richard Zhu <hongxing.zhu@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Peter Chen <peter.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, Leo Zhang <leo.zhang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mircea Pop <mircea.pop@nxp.com>, Robin Gong <yibin.gong@nxp.com>, "robh@kernel.org" <robh@kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>, BOUGH CHEN <haibo.chen@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Iuliana Prodan <iuliana.prodan@nxp.com>, Zening Wang <zening.wang@nxp.com>, Robert
List-Id: linux-pm@vger.kernel.org

On 27/03/2019 17:00, Leonard Crestez wrote:
> On Wed, 2019-03-27 at 17:06 +0100, Lucas Stach wrote:
>> Am Mittwoch, den 27.03.2019, 15:57 +0000 schrieb Marc Zyngier:
>>> On 27/03/2019 15:44, Lucas Stach wrote:
>>>> Am Mittwoch, den 27.03.2019, 13:21 +0000 schrieb Abel Vesa:
>>>>> This work is a workaround I'm looking into (more as a background task)
>>>>> in order to add support for cpuidle on i.MX8MQ based platforms.
>>>>>
>>>>> The main idea here is getting around the missing GIC wake_request signal
>>>>> (due to integration design issue) by waking up a each individual core through
>>>>> some dedicated SW power-up bits inside the power controller (GPC) right before
>>>>> every IPI is requested for that each individual core.
>>>>
>>>> Just a general comment, without going into the details of this series:
>>>> this issue is not only affecting IPIs, but also MSIs terminated at the
>>>> GIC. Currently MSIs are terminated at the PCIe core, but terminating
>>>> them at the GIC is clearly preferable, as this allows assigning CPU
>>>> affinity to individual MSIs and lowers IRQ service overhead.
>>>>
>>>> I'm not sure what the consequences are for upstream Linux support yet,
>>>> but we should keep in mind that having a workaround for IPIs is only
>>>> solving part of the issue.
>>>
>>> If this erratum is affecting more than just IPIs, then indeed I don't
>>> see how this patch series solves anything.
>>>
>>> But the erratum documentation seems to imply that only SGIs are
>>> affected, and goes as far as suggesting to use an external interrupt
>>> would solve it. How comes this is not the case? Or is it that anything
>>> directly routed to a redistributor is also affected? This would break
>>> LPIs (and thus MSIs) and PPIs (the CPU timer, among others).
>>>
>>> What is the *exact* status of this thing? I have the ugly feeling that
>>> the true workaround is just to disable cpuidle.
>>
>> As far as I understand the erratum, the basic issue is that the GIC
>> wake_request signals are not connected to the GPC (the CPU/peripheral
>> power sequencer). The SPIs are routed through the GPC and thus are
>> visible as wakeup sources, which is why the workaround of using an
>> external SPI as wakeup trigger for the IPI works.
> 
> We had a kernel workaround for IPIs in our internal tree for a long
> time and I don't think we do anything special for PCI. Does PCI MSI
> really bypass the GPC on 8mq?

If you have an ITS, certainly. If you don't, it depends. MSIs can hit
the distributor's MBI registers and generate non-wired SPIs, which I
assume will bypass the GPC altogether.

> Adding Richard/Jacky, they might know about this.
> 
> This seems like something of a corner case to me, don't many imx boards
> ship without PCI; especially for low-power scenarios? If required it
> might be reasonable to add an additional workaround to disable all
> cpuidle if pci msis are used.

Establishing a link between cpuidle and PCI in the kernel would be
pretty invasive, and that would come on top of what this series also
mandates.

At that level of apparent brokenness, it is far safer to get cpuidle out
of the picture altogether, and I'd rather see these patches in a vendor
tree (for once).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
