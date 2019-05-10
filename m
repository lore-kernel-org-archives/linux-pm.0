From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86: intel_epb: Take CONFIG_PM into account
Date: Fri, 10 May 2019 08:01:56 +0200
Message-ID: <20190510060156.GA20852@gmail.com>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1627338.1fd8ofggM8@kreacher>
 <20190509174338.GA24432@splinter>
 <3431308.1mSSVdqTRr@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3431308.1mSSVdqTRr@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Ido Schimmel <idosch@idosch.org>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Simon Schricker <sschricker@suse.de>, Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit b9c273babce7 (PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs
> interface) caused kernels built with CONFIG_PM unset to crash on
> systems supporting the Performance and Energy Bias Hint (EPB),
> because it attempts to add files to sysfs directories that don't
> exist on those systems.
> 
> Prevent that from happening by taking CONFIG_PM into account so
> that the code depending on it is not compiled at all when it is
> not set.
> 
> Fixes: b9c273babce7 (PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs interface)
> Reported-by: Ido Schimmel <idosch@mellanox.com>
> Tested-by: Ido Schimmel <idosch@mellanox.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/x86/kernel/cpu/intel_epb.c |   22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
