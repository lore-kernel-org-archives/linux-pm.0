From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] x86 / hibernate: Use hlt_play_dead() when resuming
 from hibernation
Date: Thu, 14 Jul 2016 10:57:15 +0200
Message-ID: <20160714085715.GA26670@gmail.com>
References: <1467105403-5085-1-git-send-email-yu.c.chen@intel.com>
 <12570565.xIMhLmhDgj@vostro.rjw.lan>
 <2496371.r57m45JVIP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35252 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbcGNI5U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2016 04:57:20 -0400
Content-Disposition: inline
In-Reply-To: <2496371.r57m45JVIP@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, x86@kernel.org, Chen Yu <yu.c.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>


* Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> A new version here.
> 
> I prefer this one, because it only adds any overhead if hibernation is actually
> used, but then it is a bit more of a hack.
> 
> If you prefer the previous one, please let me know.
> 
> ---
>  arch/x86/include/asm/smp.h |    1 +
>  arch/x86/kernel/smpboot.c  |    2 +-
>  arch/x86/power/cpu.c       |   30 ++++++++++++++++++++++++++++++
>  kernel/power/hibernate.c   |    7 ++++++-
>  kernel/power/power.h       |    2 ++
>  5 files changed, 40 insertions(+), 2 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
