From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/3] Revert "ACPI,PCI,IRQ: remove SCI penalize
 function"
Date: Tue, 4 Oct 2016 09:23:30 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610040919110.5278@nanos>
References: <1475343976-20744-1-git-send-email-okaya@codeaurora.org> <1475343976-20744-3-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35373 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbcJDH0k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Oct 2016 03:26:40 -0400
In-Reply-To: <1475343976-20744-3-git-send-email-okaya@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com, ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com, linux-pci@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 1 Oct 2016, Sinan Kaya wrote:

> This reverts commit 9e5ed6d1fb87 ("ACPI,PCI,IRQ: remove SCI penalize
> function"). SCI penalty API was replaced by the runtime penalty calculation
> based on the value of acpi_gbl_FADT.sci_interrupt.

This does more than only reverting said commit ....
 
> acpi_gbl_FADT.sci_interrupt type does not get updated at the right time
> for some platforms and results in incorrect penalty assignment for PCI
> IRQs as irq_get_trigger_type returns the wrong type.

And the obvious question is: Why does irq_get_trigger_type() return the
wrong type?

What's the root cause of this problem? Your changelog does not tell
anything.

Thanks,

	tglx
