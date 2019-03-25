From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs
 interface
Date: Mon, 25 Mar 2019 12:32:18 +0100
Message-ID: <20190325113218.GG12016@zn.tnic>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1762575.ER2xjzr9E1@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1762575.ER2xjzr9E1@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 21, 2019 at 11:20:17PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The Performance and Energy Bias Hint (EPB) is expected to be set by
> user space through the generic MSR interface, but that interface is
> not particularly nice and there are security concerns regarding it,
> so it is not always available.
> 
> For this reason, add a sysfs interface for reading and updating the
> EPB, in the form of a new attribute, energy_perf_bias, located
> under /sys/devices/system/cpu/cpu#/power/ for online CPUs that
> support the EPB feature.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu |   18 ++++
>  Documentation/admin-guide/pm/intel_epb.rst         |   27 ++++++
>  arch/x86/kernel/cpu/intel_epb.c                    |   93 ++++++++++++++++++++-
>  3 files changed, 134 insertions(+), 4 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
