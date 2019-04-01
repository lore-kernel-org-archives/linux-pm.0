From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] cpufreq/intel_pstate: Do not issue the not supported
 message on !Intel
Date: Mon, 1 Apr 2019 10:39:02 +0200
Message-ID: <20190401083902.GC28264@zn.tnic>
References: <20190330100225.14744-1-bp@alien8.de>
 <fa14666a-269c-249a-f603-b00f6301c1a6@criteo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fa14666a-269c-249a-f603-b00f6301c1a6@criteo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Erwan Velu <e.velu@criteo.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 01, 2019 at 08:11:51AM +0000, Erwan Velu wrote:
> I'd suggest something like this and keep the 'CPUID not supported' part 
> untouched.
> 
>      if (no_load) || (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)

Yeah, that's the usual thing we do in such cases and the better idea,
I'll do that in v2.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
