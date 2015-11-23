From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: Re: [PATCH v1 5/5] cpufreq: intel_pstate: try load instead of
 busy_scaled
Date: Mon, 23 Nov 2015 17:26:20 +0100
Message-ID: <56533E2C.6090506@linux.intel.com>
References: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com>
 <1448284006-13596-11-git-send-email-philippe.longepe@linux.intel.com>
 <001101d12609$73987ef0$5ac97cd0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48159 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302AbbKWQZc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 11:25:32 -0500
In-Reply-To: <001101d12609$73987ef0$5ac97cd0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: srinivas.pandruvada@linux.intel.com, 'Stephane Gasparini' <stephane.gasparini@intel.com>, linux-pm@vger.kernel.org

Thank you Smythies,

I found another small error on patch 5/5.

Let me doing few test on a CherryTrail and I'll resubmit a version 2 for 
this patch.

Thx,
Philippe

On 23/11/2015 17:10, Doug Smythies wrote:
> On 2015.11.23 05:47 Philippe Longepe wrote:
>
>> static inline int32_t intel_pstate_calc_scaled_busy(struct cpudata *cpu)
>>   {
>> +	u64 cummulative_iowait, delta_iowait_us;
>> +	u64 delta_iowait_mperf;
>> +	u64 mperf, now;
>>   	struct sample *sample = &cpu->sample;
>>   	struct pstate_data *pstate = &cpu->pstate;
> To prevent a build "unused variable 'pstate'" warning, suggest deleting that last line.
> As of this patch 5 of 5 it is no longer used. i.e.:
>
> -  	struct pstate_data *pstate = &cpu->pstate;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

