From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 00/12] thermal/x86_pkg_temp: Sanitize yet another hotplug
 and locking trainwreck
Date: Tue, 22 Nov 2016 10:05:50 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1611221001120.3521@nanos>
References: <20161117231435.891545908@linutronix.de>  <1479758532.6544.169.camel@intel.com>  <alpine.DEB.2.20.1611212228220.3677@nanos> <1479770177.6544.195.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479770177.6544.195.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "Zhang, Rui" <rui.zhang@intel.com>, "rt@linutronix.de" <rt@linutronix.de>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

On Mon, 21 Nov 2016, Pandruvada, Srinivas wrote:
> Your change below fixes the crash issue. Now I tested a case where the
> last cpu offlined from a package, it removed thermal zone and added
> zone back once any cpu from the package onlined. So this is working.
> 
> I want to try to run some workload on those cpu to bump up the
> temperature and check interrupts. I am hitting some issue unrelated to
> this change may be. I onlined three cpus from the package 1.
> 
> [189443.567728] smpboot: Booting Node 1 Processor 15 APIC 0x2e
> [189656.625947] smpboot: Booting Node 1 Processor 8 APIC 0x20
> [189829.545851] smpboot: Booting Node 1 Processor 24 APIC 0x21
> 
> But I can't schedule anything on those CPUs. For example now can't run
> turbostat, it complains
> "
> turbostat: re-initialized with num_cpus 19
> Could not migrate to CPU 8
> "
> 
> Same with
> 
> #taskset 0x100 stress -c 1
> taskset: failed to set pid 0's affinity: Invalid argument
> 
> I am on the latest linux-pm/linux-next tree on this server. I will
> switch to latest main line and try.

That must be something unrelated. I can use turbostat and taskset after
doing the above.

Thanks,

	tglx
