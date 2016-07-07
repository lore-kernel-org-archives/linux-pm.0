From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH][RFC v3] x86, hotplug: Use hlt instead of mwait if invoked
 from disable_nonboot_cpus
Date: Thu, 07 Jul 2016 17:03:19 +0100
Message-ID: <577E7D47.7000904@arm.com>
References: <1467105403-5085-1-git-send-email-yu.c.chen@intel.com> <209704957.TWElLMTLfP@vostro.rjw.lan> <36DF59CE26D8EE47B0655C516E9CE6402877EBB4@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37382 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178AbcGGQFi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 Jul 2016 12:05:38 -0400
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402877EBB4@shsmsx102.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On 07/07/16 03:50, Chen, Yu C wrote:
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Below is my sort of version of this (untested) and I did it this way, because the
>> issue is specific to resume from hibernation (the workaround need not be
>> applied anywhere else) and the hibernate_resume_nonboot_cpu_disable()
>> thing may be useful to arm64 too if I'm not mistaken (James?).
> 
> James might want a flag to distinguish whether it is from suspend or resume,
> in his arch-specific disabled_nonboot_cpus?

That isn't serious, we can work out whether it is hibernate/resume based on
whether we've read data out of the the arch header. I added it in the other
series as it looked cleaner to pass the value in instead of inferring it.


Thanks,

James
