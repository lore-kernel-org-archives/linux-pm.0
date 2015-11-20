From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/2] cpufreq, intel_pstate, Fix limits->max_policy_pct
 rounding error
Date: Fri, 20 Nov 2015 10:43:54 -0500
Message-ID: <564F3FBA.6030806@redhat.com>
References: <1448022757-7856-1-git-send-email-prarit@redhat.com> <1448022757-7856-2-git-send-email-prarit@redhat.com> <20151120131833.GD3957@ubuntu> <564F37C8.60307@redhat.com> <20151120151944.GE3957@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163001AbbKTPn4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Nov 2015 10:43:56 -0500
In-Reply-To: <20151120151944.GE3957@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Len Brown <len.brown@intel.com>, Alexandra Yates <alexandra.yates@intel.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org



On 11/20/2015 10:19 AM, Viresh Kumar wrote:
> On 20-11-15, 10:10, Prarit Bhargava wrote:
>>>>  	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);
>>>
>>> And put this after the later one ?
>>>
>>>> +	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
>>>> +					      policy->cpuinfo.max_freq);
>>>>  
>>>>  	/* Normalize user input to [min_policy_pct, max_policy_pct] */
>>>>  	limits->min_perf_pct = max(limits->min_policy_pct,
>>>
>>> Sure you tested it  ? :)
>>
>> Oops -- and yeah, tested.  It works because I rewrite the value of
>> max_policy_pct :).  I'll repost shortly.
> 
> But we aren't doing below anymore, doesn't this change the
> calculations at all?
> 
>   	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);

The clamp only confines the max_policy between 0 and 100.  AFAIK it doesn't make
any change tothe value of limits->max_policy_pct unless it was outside of that
range.

P.
> 
