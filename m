From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix HWP on boot CPU after system
 resume
Date: Mon, 2 May 2016 07:42:12 +0530
Message-ID: <20160502021212.GE2855@vireshk-i7>
References: <7068194.yg8ROcCISN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35058 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbcEBCMS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 May 2016 22:12:18 -0400
Received: by mail-pa0-f54.google.com with SMTP id iv1so68002523pac.2
        for <linux-pm@vger.kernel.org>; Sun, 01 May 2016 19:12:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7068194.yg8ROcCISN@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 02-05-16, 02:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 41cfd64cf49fc "Update frequencies of policy->cpus only from
> ->set_policy()" changed the way the intel_pstate driver's ->set_policy
> callback updates the HWP (hardware-managed P-states) settings.
> A side effect of it is that if those settings are modified on the
> boot CPU during system suspend and wakeup, they will never be
> restored during subsequent system resume.
> 
> To address this problem, allow cpufreq drivers that don't provide
> ->target or ->target_index callbacks to use ->suspend and ->resume
> callbacks and add a ->resume callback to intel_pstate to restore
> the HWP settings on the CPUs that belong to the given policy.
> 
> Fixes: 41cfd64cf49fc "Update frequencies of policy->cpus only from ->set_policy()"
> Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Note: We've tried to address that issue by adding syscore_ops to
> intel_pstate and restoring the boot CPU's HWP setting from a
> syscore resume, but that turns out to be too early (apparently,
> the processor is not ready for that at that point).
> 
> ---
>  drivers/cpufreq/cpufreq.c      |   28 ++++++++++++++++------------
>  drivers/cpufreq/intel_pstate.c |   12 ++++++++++--
>  2 files changed, 26 insertions(+), 14 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
