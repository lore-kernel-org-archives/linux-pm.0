From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86 / PM: Replace CONFIG_PM_RUNTIME in io_apic.c
Date: Mon, 1 Dec 2014 11:04:47 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1412011101150.3961@nanos>
References: <5062650.1vTULtXiIc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41723 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbaLAKEu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 05:04:50 -0500
In-Reply-To: <5062650.1vTULtXiIc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

On Sat, 29 Nov 2014, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> depending on CONFIG_PM_RUNTIME may now be changed to depend on
> CONFIG_PM.
> 
> Replace CONFIG_PM_RUNTIME with CONFIG_PM in x86/kernel/apic/io_apic.c.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP
> is selected) which currently is only in linux-next (via linux-pm).

The function below is moving in linux-next to a different place
.... So it has to wait until everything has hit linus tree.

Feel free to send the cleanups directly to Linus after linux-pm and
x86 has been merged.
 
Thanks,

	tglx
