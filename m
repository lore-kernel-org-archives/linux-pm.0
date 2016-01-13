From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 13 Jan 2016 13:54:43 -0800
Message-ID: <1452722083.3092.92.camel@linux.intel.com>
References: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>
	 <1452647483-14244-3-git-send-email-jacob.jun.pan@linux.intel.com>
	 <alpine.DEB.2.11.1601131042590.3575@nanos>
	 <20160113082113.3314fa92@icelake> <20160113163610.GH12897@pd.tnic>
	 <20160113095124.186ff487@yairi> <20160113180412.GN12897@pd.tnic>
	 <20160113102138.4e34e890@yairi> <20160113191622.GP12897@pd.tnic>
	 <20160113121003.3e9c2108@yairi> <20160113212602.GT12897@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23278 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbcAMV4G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 Jan 2016 16:56:06 -0500
In-Reply-To: <20160113212602.GT12897@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Wed, 2016-01-13 at 22:26 +0100, Borislav Petkov wrote:

[Cut]

>=20
> 	rmwmsrl_safe_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
> 			=C2=A0=C2=A0=C2=A0=C2=A0INTEL_PERF_CTL_MASK,
> 			=C2=A0=C2=A0=C2=A0=C2=A0(u32)sfi_cpufreq_array[next_perf_state].ct=
r
> l_val & INTEL_PERF_CTL_MASK);
>=20
> Yikes!
>=20
> So yes, it can work but it is ugly, hard to parse and use, not
> generic
> enough, etc, etc.
>=20
> So thanks, but no thanks.
>=20
I agree, in some cases it will not make much sense to use read-
modify_write calls, the user may decide whether it makes sense or not.
But such interface is not new to Linux kernel:

regmap_update_bits(), which is referenced for 346 times.

Are you saying that any such calls are not useful?

Thanks,
Srinivas
