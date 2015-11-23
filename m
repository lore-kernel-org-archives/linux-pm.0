From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v1 5/5] cpufreq: intel_pstate: try load instead of busy_scaled
Date: Mon, 23 Nov 2015 08:10:19 -0800
Message-ID: <001101d12609$73987ef0$5ac97cd0$@net>
References: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com> <1448284006-13596-11-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta11.telus.net ([209.171.16.84]:36114 "EHLO cmta11.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbbKWQKW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 11:10:22 -0500
In-Reply-To: <1448284006-13596-11-git-send-email-philippe.longepe@linux.intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Philippe Longepe' <philippe.longepe@linux.intel.com>
Cc: srinivas.pandruvada@linux.intel.com, 'Stephane Gasparini' <stephane.gasparini@intel.com>, linux-pm@vger.kernel.org

On 2015.11.23 05:47 Philippe Longepe wrote:

> static inline int32_t intel_pstate_calc_scaled_busy(struct cpudata *cpu)
>  {
> +	u64 cummulative_iowait, delta_iowait_us;
> +	u64 delta_iowait_mperf;
> +	u64 mperf, now;
>  	struct sample *sample = &cpu->sample;
>  	struct pstate_data *pstate = &cpu->pstate;

To prevent a build "unused variable 'pstate'" warning, suggest deleting that last line.
As of this patch 5 of 5 it is no longer used. i.e.:

-  	struct pstate_data *pstate = &cpu->pstate;


