From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [Bug] ARM: mxs: STI: console can't wake up from freeze
Date: Sun, 6 Nov 2016 11:20:56 +0100 (CET)
Message-ID: <381813296.167766.9867e3e7-5710-4844-a098-6f44bd852a6d.open-xchange@email.1und1.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161105180542.GE1041@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, joerg.krause@embedded.rocks, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,

> Russell King - ARM Linux <linux@armlinux.org.uk> hat am 5. November 2016 um
> 19:05 geschrieben:
> 
> 
> On Sat, Nov 05, 2016 at 04:28:37PM +0100, Stefan Wahren wrote:
> > As i wrote in my email before, i added a pr_info() into freeze_wake.
> > But i never see the output of this message. So i assume freeze_wake
> > is never called. Again, how could this happen?
> 
> Hmm, so the bit that you're getting stuck on is:
> 
>         wait_event(suspend_freeze_wait_head,
>                    suspend_freeze_state == FREEZE_STATE_WAKE);
> 

thanks for all the feedback. The real cause for this issue is in the irqchip
driver. I fixed it with this patch:

diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index 1730470..05fa9f7 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -131,12 +131,16 @@ static void asm9260_unmask_irq(struct irq_data *d)
 	.irq_ack = icoll_ack_irq,
 	.irq_mask = icoll_mask_irq,
 	.irq_unmask = icoll_unmask_irq,
+	.flags = IRQCHIP_MASK_ON_SUSPEND |
+		 IRQCHIP_SKIP_SET_WAKE,
 };
 
 static struct irq_chip asm9260_icoll_chip = {
 	.irq_ack = icoll_ack_irq,
 	.irq_mask = asm9260_mask_irq,
 	.irq_unmask = asm9260_unmask_irq,
+	.flags = IRQCHIP_MASK_ON_SUSPEND |
+		 IRQCHIP_SKIP_SET_WAKE,
 };
 
 asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
