From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] x86: Remove duplicate turbo ratio MSRs
Date: Thu, 7 Jul 2016 01:21:22 +0200
Message-ID: <CAJZ5v0iTb5GMwLgHnMJOCQnwnCwgDQyziCdoxWaX5Bq57Qk=+g@mail.gmail.com>
References: <1467846477-13659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32798 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932593AbcGFXVY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2016 19:21:24 -0400
In-Reply-To: <1467846477-13659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@suse.de>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jul 7, 2016 at 1:07 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> MSR_NHM_TURBO_RATIO_LIMIT and MSR_IVT_TURBO_RATIO_LIMIT are
> duplicate MSRs with MSR_TURBO_RATIO_LIMIT and MSR_TURBO_RATIO_LIMIT1
> respectively. So remove them by first removing their usage and then
> from msr-index.h.
>
> Srinivas Pandruvada (3):
>   cpufreq: intel_pstate: Replace MSR_NHM_TURBO_RATIO_LIMIT
>   tools/power turbostat: Replace MSR_NHM_TURBO_RATIO_LIMIT
>   x86: remove duplicate turbo ratio limit MSRs
>
>  arch/x86/include/asm/msr-index.h      | 2 --
>  drivers/cpufreq/intel_pstate.c        | 4 ++--
>  tools/power/x86/turbostat/turbostat.8 | 2 +-
>  tools/power/x86/turbostat/turbostat.c | 2 +-
>  4 files changed, 4 insertions(+), 6 deletions(-)

The series looks good to me.

If anyone has any objections against this going in through the PM
tree, please let me know.

Thanks,
Rafael
