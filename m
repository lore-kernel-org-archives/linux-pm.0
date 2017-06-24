From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/4 v2] x86: use common aperfmperf_khz_on_cpu() to
 calculate KHz using APERF/MPERF
Date: Sat, 24 Jun 2017 10:56:40 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706241052050.1941@nanos>
References: <1498281114-3868-1-git-send-email-lenb@kernel.org> <7c8784a63cdab6ff5ff7756060be6a77f5fe5915.1498280509.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35375 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdFXI4r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2017 04:56:47 -0400
In-Reply-To: <7c8784a63cdab6ff5ff7756060be6a77f5fe5915.1498280509.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: rafael@kernel.org, x86@kernel.org, srinivas.pandruvada@linux.intel.com, peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri, 23 Jun 2017, Len Brown wrote:
> This x86 native method to calculate MHz returns a meaningful result
> no matter if P-states are controlled by hardware or firmware
> and/or if the Linux cpufreq sub-system is or is-not installed.
> 
> When this routine is invoked more frequently, the measurement
> interval becomes shorter.  However, the code limits re-computation
> to 10ms intervals so that average frequency remains meaningful.
> 
> Discerning users are encouraged to take advantage of
> the turbostat(8) utility, which can gracefully handle
> concurrent measurement intervals of arbitrary length.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Raphael, please take the whole lot through the cpufreq tree.

Thanks,

	tglx
