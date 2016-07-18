From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH] cpufreq: Intel P state driver: clean remnant struct element
Date: Tue, 19 Jul 2016 01:19:15 +0200
Message-ID: <baa442ec-5845-6438-8c03-6793220883e1@osadl.org>
References: <66b88042-0f03-893b-33ac-c4e6df17534c@osadl.org>
 <1468859382.13661.167.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:42065 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbcGRXUT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 Jul 2016 19:20:19 -0400
In-Reply-To: <1468859382.13661.167.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM mailing list <linux-pm@vger.kernel.org>

Hi Srinivas,

BTW: when I was working with the Intel P state driver I came across
a remnant struct element that is no longer needed after the function
intel_pstate_calc_freq() was retired.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

Index: linux-4.7.0-rc7+/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-4.7.0-rc7+.orig/drivers/cpufreq/intel_pstate.c
+++ linux-4.7.0-rc7+/drivers/cpufreq/intel_pstate.c
@@ -96,7 +96,6 @@ static inline u64 div_ext_fp(u64 x, u64
  *                     read from MPERF MSR between last and current sample
  * @tsc:               Difference of time stamp counter between last and
  *                     current sample
- * @freq:              Effective frequency calculated from APERF/MPERF
  * @time:              Current time from scheduler
  *
  * This structure is used in the cpudata structure to store performance sample
@@ -108,7 +107,6 @@ struct sample {
        u64 aperf;
        u64 mperf;
        u64 tsc;
-       int freq;
        u64 time;
 };
 

