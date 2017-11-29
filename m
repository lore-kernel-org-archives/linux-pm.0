From: "dbasehore ." <dbasehore@chromium.org>
Subject: Save and Restore Generic Interrupt Controller for System Sleep on ARM
Date: Wed, 29 Nov 2017 14:49:18 -0800
Message-ID: <CAGAzgsrSDF0Hs4-=m02c6ME90RvZumYxzBFFi0oH=RuwxQnB-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:46803 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbdK2WtU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Nov 2017 17:49:20 -0500
Received: by mail-wr0-f174.google.com with SMTP id x49so4884493wrb.13
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2017 14:49:20 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, sudeep.holla@arm.com, Linux-pm mailing list <linux-pm@vger.kernel.org>

There was some work in ARM Trusted Firmware to support saving and
restoring the Generic Interrupt Controller (GICv3) before and after
sleep, but it seems that the plan is to have this all in the kernel
now. The point of doing this is to save power during sleep. On an
RK3399 system, we save about 15mW by disabling the power rail that the
GIC is on.

I was looking for whether anyone had anything in progress already or
for preferences on how to do this. Marc suggested using a device tree
entry to indicate the need to save and restore the GIC. There is
another requirement to resend MAPC commands on certain implementations
of the GICv3 which could be indicated by another device tree entry.

If someone does have patches, I'll be able to test and verify them on
my system since we've gotten things working with the ARM Trusted
Firmware patches.
