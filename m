From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH] x86: Move away from /dev/cpu/*/msr
Date: Wed, 15 Jun 2016 12:36:22 +0200
Message-ID: <20160615103622.GA19822@pd.tnic>
References: <20160615100029.GB32588@pd.tnic>
 <CADjb_WSTH6b2vpM2A=Kp_NKdUzVEoAhPNAQgU0jCuLS2_o55xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41054 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbcFOKgZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jun 2016 06:36:25 -0400
Content-Disposition: inline
In-Reply-To: <CADjb_WSTH6b2vpM2A=Kp_NKdUzVEoAhPNAQgU0jCuLS2_o55xw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: chenyu <yu.chen.surf@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Renninger <trenn@suse.com>, Kan Liang <kan.liang@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, Jun 15, 2016 at 06:22:59PM +0800, chenyu wrote:
> MSR_IA32_ENERGY_PERF_BIAS is of core scope, should we use rdmsr_on_cpu?

Ah, yes, good point. Will change.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
