From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS
 handling
Date: Fri, 22 Mar 2019 15:31:54 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1903221531080.1729@nanos.tec.linutronix.de>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan> <1605148.8jT99SsvVP@aspire.rjw.lan> <20190322142828.GA12472@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322142828.GA12472@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

On Fri, 22 Mar 2019, Borislav Petkov wrote:
> On Thu, Mar 21, 2019 at 11:18:01PM +0100, Rafael J. Wysocki wrote:
> > Index: linux-pm/Documentation/admin-guide/pm/intel_epb.rst
> > ===================================================================
> > --- /dev/null
> > +++ linux-pm/Documentation/admin-guide/pm/intel_epb.rst
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #345: FILE: Documentation/admin-guide/pm/intel_epb.rst:1:
> +======================================

We have no proper decision/recommendation about documentation
licensing. That's being worked on.

Thanks,

	tglx
