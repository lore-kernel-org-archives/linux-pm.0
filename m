From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: divide by zero on Knights Landing (KNL)
Date: Thu, 15 Oct 2015 23:09:54 +0200
Message-ID: <1785007.Asf1BDY8RE@vostro.rjw.lan>
References: <1444937661-9519-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1444937661-9519-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55284 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752145AbbJOUlK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 16:41:10 -0400
In-Reply-To: <1444937661-9519-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, kristen.c.accardi@intel.com
Cc: rafael.j.wysocki@intel.com, len.brown@intel.com, linux-pm@vger.kernel.org

On Thursday, October 15, 2015 12:34:21 PM Srinivas Pandruvada wrote:
> This is a workaround for KNL platform, where in some cases MPERF counter
> will not have updated value before next read of MSR_IA32_MPERF. In this
> case divide by zero will occur. This change ignores current sample for
> busy calculation in this case.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied.

I've also marked it for 4.1.y-stable (and later).

Kristen, please let me know if there are any concerns regarding this one.

Thanks,
Rafael

