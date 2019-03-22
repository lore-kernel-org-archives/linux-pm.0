From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS
 handling
Date: Fri, 22 Mar 2019 17:12:24 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1903221712020.1729@nanos.tec.linutronix.de>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan> <1605148.8jT99SsvVP@aspire.rjw.lan> <20190322142828.GA12472@zn.tnic> <alpine.DEB.2.21.1903221531080.1729@nanos.tec.linutronix.de> <20190322143525.GB12472@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322143525.GB12472@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org


On Fri, 22 Mar 2019, Borislav Petkov wrote:

> On Fri, Mar 22, 2019 at 03:31:54PM +0100, Thomas Gleixner wrote:
> > We have no proper decision/recommendation about documentation
> > licensing. That's being worked on.
> 
> Ok, I'm ignoring this checkpatch warning from now on.

Only for Documentation/* files please.
