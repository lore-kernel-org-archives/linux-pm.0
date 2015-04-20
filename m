From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/1] speeding up cpu_up()
Date: Mon, 20 Apr 2015 09:15:56 +0200
Message-ID: <20150420071556.GB14315@gmail.com>
References: <1429404795-23260-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429404795-23260-1-git-send-email-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> The following patch...
> 
> [PATCH 1/1] x86: replace cpu_up hard-coded mdelay with variable
> 
> enables reducing cpu_up() time by 10ms on modern systems.
> 
> This means that for every processor in the system,
> boot-time and resume-time can be reduced by 10ms per-processor.
> 
> Once this patch is accepted, I'll send a subsequent patch
> to update the default delay, as appropriate.
> 
> thanks,
> Len Brown, Intel Open Source Technology Center

So instead of playing games with an ancient delay, I'd suggest we 
install the 10 msec INIT assertion wait as a platform quirk instead, 
and activate it for all CPUs/systems that we think might need it, with 
a sufficiently robust and future-proof quirk cutoff condition.

New systems won't have the quirk active and thus won't have to have 
this delay configurable either.

Thanks,

	Ingo
