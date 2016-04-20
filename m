From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 0/2] Skylake PSys support
Date: Wed, 20 Apr 2016 15:59:45 +0200
Message-ID: <20160420135945.GY3448@twins.programming.kicks-ass.net>
References: <1460930581-29748-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:53957 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbcDTN7x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 09:59:53 -0400
Content-Disposition: inline
In-Reply-To: <1460930581-29748-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net, x86@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com, linux-pm@vger.kernel.org

On Sun, Apr 17, 2016 at 03:02:59PM -0700, Srinivas Pandruvada wrote:
> Skylake processor supports a new set of RAPL registers for controlling
> entire SoC instead of just CPU package called PSys. This change adds
> support in two sub systems:
> 
> x86/perf: Adds basic support for Skylake RAPL and PSys support
> 
> powercap/rapl: A new platform domain to the current power capping Intel
> RAPL driver.

> Srinivas Pandruvada (2):
>   perf/x86/intel/rapl: support Skylake RAPL domains
>   powercap: intel_rapl: PSys support
> 
>  arch/x86/events/intel/rapl.c     | 51 +++++++++++++++++++++++++++--
>  arch/x86/include/asm/msr-index.h |  2 ++
>  drivers/powercap/intel_rapl.c    | 69 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+), 2 deletions(-)

These two patches depend on one another, right? Because the first patch
adds the MSR the second patch uses?

How should we go about merging this? The perf-rapl stuff normally goes
through tip while the powercap stuff goes through Rafael's tree.
