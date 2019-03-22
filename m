From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS
 handling
Date: Fri, 22 Mar 2019 17:43:39 +0100
Message-ID: <20190322164339.GF12472@zn.tnic>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1605148.8jT99SsvVP@aspire.rjw.lan>
 <2431307.7efAn4P022@house>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2431307.7efAn4P022@house>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 22, 2019 at 05:27:43PM +0100, Thomas Renninger wrote:
> Thanks Rafael for your quick look at and all the time you spend for this!
> 
> A /sys userspace knob will certainly not be enough for us.
> You'll need a tool installed fixing this.

We won't pick up the second patch converting to the sysfs interface of
course - only the first one. The second patch is beginning the slow
phasing out of the direct /dev/msr access.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
