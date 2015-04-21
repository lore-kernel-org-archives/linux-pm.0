From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH/RFC 00/03] irqchip: renesas-irqc: Fine grained Runtime PM support
Date: Wed, 22 Apr 2015 00:01:15 +0900
Message-ID: <20150421150115.14288.88519.sendpatchset@little-apple>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34656 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbbDUO7l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2015 10:59:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: jason@lakedaemon.net, geert+renesas@glider.be, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

irqchip: renesas-irqc: Fine grained Runtime PM support

[PATCH/RFC 01/03] irqchip: renesas-irqc: Add irq_enable() and irq_disable()
[PATCH/RFC 02/03] irqchip: renesas-irqc: Add fine grained Runtime PM code
[PATCH/RFC 03/03] irqchip: renesas-irqc: Rely on Runtime PM for wakeup

These patches attempt to convert the IRQC driver from using a mix of clock
framework and Runtime PM into only using Runtime PM and doing that in a
more fine grained way than before. With these patches in place, if there
is no interrupt used then the clock and/or power domain will not be used.

Basic operation is that With these patches applied ->irq_enable() will
perform Runtime PM 'get sync' and ->irq_disable() simply performs
Runtime PM 'put'. The trigger mode callback is assumed to happen at any
time so there is a get/put wrapper there.

Unless I'm misunderstanding the IRQ core code this means that the IRQC
struct device will be in Runtime PM 'get sync' state after someone has
started using an interrupt.

As for wakeup support, based on IRQ_WAKEUP_STATE being toggled in
irq_set_irq_wake() together with the irqd_is_wakeup_set() usage in
suspend_device_irqs() it looks like interrupts used for wakeup will
stay enabled once we use Runtime PM in ->irq_enable() and ->irq_disable()
and because of that the clock operations and custom ->irq_set_wake()
should not be necessary.

I have boot tested this with some simple PHY link state change IRQs
on a Koelsch board, but I have not tried Suspend-to-RAM yet with wakeup
support. It would be useful to test this with Suspend-to-RAM on APE6EVM.

Thanks to Geert for hooking up APE6EVM interrupt wake support!

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---
 Written against next-20150421

 drivers/irqchip/irq-renesas-irqc.c |   61 +++++++++++++++---------------------
 1 file changed, 27 insertions(+), 34 deletions(-)
