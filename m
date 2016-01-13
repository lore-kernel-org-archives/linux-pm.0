From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 14:11:15 -0800
Message-ID: <20160113141115.59535b45@yairi>
References: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1452647483-14244-3-git-send-email-jacob.jun.pan@linux.intel.com>
	<alpine.DEB.2.11.1601131042590.3575@nanos>
	<20160113082113.3314fa92@icelake>
	<20160113163610.GH12897@pd.tnic>
	<20160113095124.186ff487@yairi>
	<20160113180412.GN12897@pd.tnic>
	<20160113102138.4e34e890@yairi>
	<20160113191622.GP12897@pd.tnic>
	<20160113121003.3e9c2108@yairi>
	<20160113212602.GT12897@pd.tnic>
	<1452722083.3092.92.camel@linux.intel.com>
	<alpine.DEB.2.11.1601132257550.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1601132257550.3575@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, jacob.jun.pan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Jan 2016 23:02:33 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 13 Jan 2016, Srinivas Pandruvada wrote:
> > On Wed, 2016-01-13 at 22:26 +0100, Borislav Petkov wrote:
> > > 	rmwmsrl_safe_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
> > > 			=C2=A0=C2=A0=C2=A0=C2=A0INTEL_PERF_CTL_MASK,
> > > 			=C2=A0=C2=A0=C2=A0=C2=A0(u32)sfi_cpufreq_array[next_perf_state=
].ctr
> > > l_val & INTEL_PERF_CTL_MASK);
> > >=20
> > > Yikes!
> > >=20
> > > So yes, it can work but it is ugly, hard to parse and use, not
> > > generic
> > > enough, etc, etc.
> > >=20
> > > So thanks, but no thanks.
> > >=20
> > I agree, in some cases it will not make much sense to use read-
> > modify_write calls, the user may decide whether it makes sense or
> > not. But such interface is not new to Linux kernel:
> >=20
> > regmap_update_bits(), which is referenced for 346 times.
> >=20
> > Are you saying that any such calls are not useful?
>=20
> There are certainly cases when such calls are useful. And those cases
> are when we have a sufficiently big occurence of similar code which
> is sufficiently complex to justify the library code and the export.
>=20
The balance of pros and cons depends on the number of occurrence. The
lib call overhead is constant where saving from the callers are
multiplied. Anyway, I will go back to my original code until we have
enough callers to tip the balance.
