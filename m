From: Andy Lutomirski <luto@kernel.org>
Subject: Getting rid of i7300_idle's idle notifier?
Date: Thu, 4 Jun 2015 16:32:25 -0700
Message-ID: <CALCETrVGefbgXzvjC3bTm9DgSr2UkpsPn6P_QwKm1cogZ0AVkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59107 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518AbbFDXcv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Jun 2015 19:32:51 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 3593920762
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2015 23:32:49 +0000 (UTC)
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com [209.85.217.176])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id AD69D2071E
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2015 23:32:47 +0000 (UTC)
Received: by lbbtu8 with SMTP id tu8so20274262lbb.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2015 16:32:45 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Henroid <andrew.d.henroid@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

AFAICT the sole purpose for the hideous x86_64 idle_notifier mess is
to support i7300_idle.  IMO this junk does not belong in IRQ handling,
etc.  Can we redo this to work in some kind of generic way?

I have no idea why it makes sense to twiddle I/O AT registers in the
beginning of whatever IRQ wakes up the CPU.

Note that, if absolutely necessary, the ECX bit 0 MWAIT extension can
be used to reliably execute code before handling interrupts that wake
us from idle.  That is, there could be a real cpuidle driver for that
chip that does:

cli;
poke ioat;
mwait(ecx = 1);
poke ioat;
sti;

Or we could delete the driver entirely.

--Andy
