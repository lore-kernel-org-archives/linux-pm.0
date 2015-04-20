From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/1] x86: replace cpu_up hard-coded mdelay with variable
Date: Mon, 20 Apr 2015 19:45:44 +0200
Message-ID: <20150420174544.GA18931@gmail.com>
References: <1429404795-23260-1-git-send-email-lenb@kernel.org>
 <87d69aab88c14d65ae1e7be55050d1b689b59b4b.1429402494.git.len.brown@intel.com>
 <20150420071306.GA14315@gmail.com>
 <1A7043D5F58CCB44A599DFD55ED4C94846861500@fmsmsx115.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34416 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbDTRpu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2015 13:45:50 -0400
Content-Disposition: inline
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C94846861500@fmsmsx115.amr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Len Brown <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>


* Brown, Len <len.brown@intel.com> wrote:

> > What's the cutoff for 'modern hardware' - which CPUs stopped requiring
> > the delay?
> 
> This is the topic of ongoing research, and I'm not ready to send
> the patch setting a new default until I've heard back from a few more HW people.
> 
> Every system I've tested appears to work with delay 0.
> Were I to guess, I'd venture that every
> system that runs an X86_64 kernel might count as "modern" -- even
> the 2005 AMD Turion laptop I've got in the bone pile.

Could we use the apic version as a cutoff perhaps?

It would be nice to 'automatically' include modern 32-bit x86 systems 
as well.

Any failure here would be relatively easy to bisect to, so we might as 
well guess a bit and refine the quirk condition if needed?

Thanks,

	Ingo
