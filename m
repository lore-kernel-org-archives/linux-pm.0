From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 23:02:33 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601132257550.3575@nanos>
References: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>  <1452647483-14244-3-git-send-email-jacob.jun.pan@linux.intel.com>  <alpine.DEB.2.11.1601131042590.3575@nanos>  <20160113082113.3314fa92@icelake> <20160113163610.GH12897@pd.tnic>
  <20160113095124.186ff487@yairi> <20160113180412.GN12897@pd.tnic>  <20160113102138.4e34e890@yairi> <20160113191622.GP12897@pd.tnic>  <20160113121003.3e9c2108@yairi> <20160113212602.GT12897@pd.tnic> <1452722083.3092.92.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1863996531-1452722557=:3575"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452722083.3092.92.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1863996531-1452722557=:3575
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 Jan 2016, Srinivas Pandruvada wrote:
> On Wed, 2016-01-13 at 22:26 +0100, Borislav Petkov wrote:
> > 	rmwmsrl_safe_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
> > 			    INTEL_PERF_CTL_MASK,
> > 			    (u32)sfi_cpufreq_array[next_perf_state].ctr
> > l_val & INTEL_PERF_CTL_MASK);
> > 
> > Yikes!
> > 
> > So yes, it can work but it is ugly, hard to parse and use, not
> > generic
> > enough, etc, etc.
> > 
> > So thanks, but no thanks.
> > 
> I agree, in some cases it will not make much sense to use read-
> modify_write calls, the user may decide whether it makes sense or not.
> But such interface is not new to Linux kernel:
> 
> regmap_update_bits(), which is referenced for 346 times.
> 
> Are you saying that any such calls are not useful?

There are certainly cases when such calls are useful. And those cases are when
we have a sufficiently big occurence of similar code which is sufficiently
complex to justify the library code and the export.

Thanks,

	tglx
--8323329-1863996531-1452722557=:3575--
