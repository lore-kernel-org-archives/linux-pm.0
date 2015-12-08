From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH v2 0/4]  cpufreq governors and Intel P state driver compatibility
Date: Tue, 08 Dec 2015 18:45:49 -0500
Message-ID: <56676BAD.4030707@redhat.com>
References: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbbLHXpu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Dec 2015 18:45:50 -0500
In-Reply-To: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, trenn@suse.de



On 12/08/2015 05:31 PM, Srinivas Pandruvada wrote:
> Intel P State driver implements two policies, performance and powersave.
> The powersave policy is similar to ondemand cpufreq governor when using
> acpi-cpufreq. This causes lots of confusion among users. This results
> in invalid comparison of performance when acpi-cpufreq and Intel P state
> performance is compared.
> 
> The reason Intel P state called powersave when it actually implemented
> ondemand style P State selection, because the cpufreq core only allows
> two generic policies "performance and powersave" for drivers which has
> setpolicy() interface. All drivers using this interface are forced to
> support these two policies.
> 
> This patchset adds feature to have configurable generic policies and
> allows ondemand as one of the policy. With this approach, Intel P state
> now adds support for ondemand policy and power save policy both in
> addition to performance.

Srinivas, if I read the patchset correctly then this means that ondemand ==
powersave ?

If so, is the intention to one day remove powersave altogether and switch to
only ondemand & performance?

P.
