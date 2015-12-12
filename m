From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq, intel_pstate, minor cleanup for FRAC_BITS
Date: Sat, 12 Dec 2015 03:27:31 +0100
Message-ID: <3067497.3xzDauRRix@vostro.rjw.lan>
References: <1449600299-4647-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55198 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754628AbbLLB53 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2015 20:57:29 -0500
In-Reply-To: <1449600299-4647-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On Tuesday, December 08, 2015 01:44:59 PM Prarit Bhargava wrote:
> 785ee27 ("cpufreq: intel_pstate: Fix limits->max_perf rounding error")
> hardcodes the value of FRAC_BITS.  This patch fixes that minor issue.
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Applied, thanks!

Rafael

