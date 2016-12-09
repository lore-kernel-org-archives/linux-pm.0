From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v8 8/8] cpufreq: intel_pstate: Use CPPC to get max
 performance
Date: Fri, 9 Dec 2016 15:45:51 +0100
Message-ID: <20161209144551.jhnbfsxdxsk4ld6s@linutronix.de>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
 <20161207190608.boi7svavwrkx3epm@breakpoint.cc>
 <1481152373.3064.77.camel@linux.intel.com>
 <4248602.ecJ9y5gJMR@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4248602.ecJ9y5gJMR@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 2016-12-08 00:29:29 [+0100], Rafael J. Wysocki wrote:
> Agreed, but the bug fixed by the first hunk is real too.  I'd fix it a bit
> differently, though:
> 
> Tentatively-signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Is there anything you want me to do here? The hunk in
acpi_cppc_processor_exit() is unchanged and is the one that led to the
crash. The other hunk I made (the one you changed) was something I
noticed while looking at the code - nothing that hit me directly.

Sebastian
