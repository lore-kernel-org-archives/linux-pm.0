From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFC PATCH] x86: Move away from /dev/cpu/*/msr
Date: Mon, 20 Jun 2016 14:12:32 -0700
Message-ID: <87inx3bm4f.fsf@tassilo.jf.intel.com>
References: <20160615100029.GB32588@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160615100029.GB32588@pd.tnic> (Borislav Petkov's message of
	"Wed, 15 Jun 2016 12:00:29 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Renninger <trenn@suse.com>, Kan Liang <kan.liang@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> Comments are, as always, appreciated.

Seems like a waste of kernel code to me. The MSR interface works
perfectly fine. There are potentially hundreds of useful MSRs,
are you going to add new sysfs for each of them?

Even the more obscure ones can be very useful for debugging
and monitoring.

Most MSRs are model specific so this would end up with tons
of switch (x86_model) ... which are always difficult to maintain
and need to be updated all the time when new CPUs come out.

This will likely generate a really large ongoing number of patches,
and to solve what problem exactly?

The whole thing doesn't make any sense to me.

It's just a waste of code, maintainer time, patch review
capacity, which all could be far more usefully employed
to do something that actually solves real problems.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
