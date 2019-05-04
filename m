Return-Path: <SRS0=K6pn=TE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D14AC43219
	for <linux-pm@archiver.kernel.org>; Sat,  4 May 2019 20:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB7320652
	for <linux-pm@archiver.kernel.org>; Sat,  4 May 2019 20:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfEDU06 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 4 May 2019 16:26:58 -0400
Received: from smtpout-52.fbg1.glesys.net ([185.39.145.52]:37380 "EHLO
        smtpout-52.fbg1.glesys.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726890AbfEDU06 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 May 2019 16:26:58 -0400
X-Greylist: delayed 965 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 May 2019 16:26:57 EDT
Received: from [192.168.1.192] (unknown [155.4.225.32])
        by mail-halon-02.fbg1.glesys.net (Halon) with ESMTPSA
        id ab855f9c-6ea8-11e9-b6c2-2f60bddcfa2d;
        Sat, 04 May 2019 22:10:49 +0200 (CEST)
To:     linux-pm@vger.kernel.org
From:   Magnus Olsson <magnus@minimum.se>
Subject: Correctly setting up a wake IRQ
Message-ID: <7d4da0fb-8a88-430d-58c9-eeb8aca9382c@minimum.se>
Date:   Sat, 4 May 2019 22:10:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I'm debugging an issue on a SMP system running Linux 4.4 where system 
suspend is in progress but a wake-up IRQ occurs. When it reaches 
suspend_device_irqs() (kernel/irq/pm.c) and tries to synchronize_irq(), 
it finds that another CPU is handling the wakeup IRQ. The IRQ handler 
that process the wake-up IRQ fails due to i2c read errors (likely 
because it's i2c parent bus is already suspended) and the suspend is 
aborted due to error ("PM: noirq suspend of devices failed"). I think 
it's fair that wake-up IRQs should abort ongoing suspend, but not due to 
errors. After this has happened once, the same kind of i2c read errors 
happen on every subsequent suspend and the system is unable to go to 
sleep unless I powercycle the system. Which is bad, considering its a 
battery-powered device.

The driver that handles the wake-up IRQ is 
drivers/input/keyboard/adp5589-keys.c; in its suspend callback, it'll do 
disable_irq() and enable_irq_wake(). This does not work on my system, 
because disable_irq() will completely disable the IRQ and 
enable_irq_wake() won't enable it again. We go to sleep with a disabled 
IRQ. So I removed the disable_irq(), and it "works". If I understand 
Documentation/power/suspend-and-interrupts.txt correctly, disable_irq 
should not be called before enable_irq_wake. However, I suspect this 
modification is what makes it possible for the kernel to handle wake-ups 
in the middle of suspend and therefore get the race between the CPU 
suspending the system and the CPU trying to handle the wake-up?

What is the correct way to setup a wake-irq? If I don't do 
disable_irq(), my suspend breaks as described. If I do disable_irq(), 
the device will never wake up. In order to handle a wake-up IRQ 
mid-suspend, I must ensure that all the parent devices are resumed 
before the handler of a wake IRQ is run. How can I achieve that?

PS. Apologies for running an ancient kernel (4.4). I see that a lot wrt 
wake-up has changed in Linux 5.2. DS.

Best regards, Magnus.



