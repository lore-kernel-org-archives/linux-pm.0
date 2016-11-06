From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [Bug] ARM: mxs: STI: console can't wake up from freeze
Date: Sun, 6 Nov 2016 19:31:44 +0100 (CET)
Message-ID: <820961083.19871.6d6810aa-5a43-48cc-a201-6ec91fa3d7f8.open-xchange@email.1und1.de>
References: <20161023133134.GI1041@n2100.armlinux.org.uk>
 <1709157673.85170.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
 <20161031161700.GH1041@n2100.armlinux.org.uk>
 <847975190.29034.38a9c7fa-bdf8-4732-ac8b-cf15c21e3ce8.open-xchange@email.1und1.de>
 <20161101092304.GM1041@n2100.armlinux.org.uk>
 <322177156.158733.9867e3e7-5710-4844-a098-6f44bd852a6d.open-xchange@email.1und1.de>
 <1478345972.2206.15.camel@intel.com>
 <122295766.159553.9867e3e7-5710-4844-a098-6f44bd852a6d.open-xchange@email.1und1.de>
 <20161105130034.GG15759@mai>
 <1113068116.152452.34665947-6f6b-41d6-92af-eabcbcb794ea.open-xchange@email.1und1.de>
 <20161105180542.GE1041@n2100.armlinux.org.uk>
 <381813296.167766.9867e3e7-5710-4844-a098-6f44bd852a6d.open-xchange@email.1und1.de>
 <f03db663-908e-e416-ad50-bdb5cbf6c2c9@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f03db663-908e-e416-ad50-bdb5cbf6c2c9@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, joerg.krause@embedded.rocks, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


> Daniel Lezcano <daniel.lezcano@linaro.org> hat am 6. November 2016 um 15:55
> geschrieben:
> 
> 
> On 06/11/2016 11:20, Stefan Wahren wrote:
> > Hi,
> > 
> >> Russell King - ARM Linux <linux@armlinux.org.uk> hat am 5. November 2016 um
> >> 19:05 geschrieben:
> >>
> >>
> >> On Sat, Nov 05, 2016 at 04:28:37PM +0100, Stefan Wahren wrote:
> >>> As i wrote in my email before, i added a pr_info() into freeze_wake.
> >>> But i never see the output of this message. So i assume freeze_wake
> >>> is never called. Again, how could this happen?
> >>
> >> Hmm, so the bit that you're getting stuck on is:
> >>
> >>         wait_event(suspend_freeze_wait_head,
> >>                    suspend_freeze_state == FREEZE_STATE_WAKE);
> >>
> > 
> > thanks for all the feedback. The real cause for this issue is in the irqchip
> > driver. I fixed it with this patch:
> 
> Mind to give some details ?
> 

No. AFAIK the serial_core already handles the suspend to idle. But it requires
that enable_irq_wake for the UART IRQ succeed. Unfortunately the irq-mxs (like a
couple of other irqchip drivers) neither implemented set_irq_wake or set
IRQCHIP_SKIP_SET_WAKE so enable_irq_wake will fail with -ENXIO and the UART
won't be setup as wakeup source. As the mxs interrupt controller doesn't provide
any facility to setup wakeup source i choose to use IRQCHIP_SKIP_SET_WAKE.

Instead of failing silently it would be better if sysfs won't allow to enable
wakeup source in this case or at least the serial core should complains about
it.
