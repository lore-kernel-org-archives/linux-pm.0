From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/asm/power: Fix hibernation return address corruption
Date: Fri, 29 Jul 2016 09:16:27 +0200
Message-ID: <20160729071627.GA29186@gmail.com>
References: <16541580.dFLT14ScxF@vostro.rjw.lan>
 <1670639.GCDubuBUSI@vostro.rjw.lan>
 <20160728151707.nmtkzri4jtumaq6h@treble>
 <1760536.lNRnLG8nBr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34223 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbcG2HQc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jul 2016 03:16:32 -0400
Content-Disposition: inline
In-Reply-To: <1760536.lNRnLG8nBr@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, shuzzle@mailbox.org


* Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> > Fixes: ef0f3ed5a4ac ("x86/asm/power: Create stack frames in hibernate_asm_64.S")
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=150021
> > Reported-by: <shuzzle@mailbox.org>
> > Tested-by: <shuzzle@mailbox.org>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> I've queued this up as an urgent fix.  I hope there are no objections.

Looks good to me too!

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
