From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/3] cpufreq: TEGRA: Set policy->cpus from driver->init()
Date: Mon, 04 Feb 2013 09:36:47 -0700
Message-ID: <510FE39F.9070403@wwwdotorg.org>
References: <1bf82454ab1f16b13212548d7c9605067c8b7a0d.1359700705.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:48865 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756391Ab3BDQgv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 11:36:51 -0500
In-Reply-To: <1bf82454ab1f16b13212548d7c9605067c8b7a0d.1359700705.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, Stephen Warren <swarren@nvidia.com>, Joseph Lo <josephl@nvidia.com>

On 01/31/2013 11:40 PM, Viresh Kumar wrote:
> For multicore SoC's, with cores sharing clock line, we are required to set
> policy->cpus and policy->related_cpus with mask of cpus.
> 
> With following patch, we need to set policy->cpus with mask of all possible cpus
> and policy->related_cpus would be filled automatically by the cpufreq core.
> 
> commit 4948b355e90080cd5ec1e91189f65a01e4186ef2
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Tue Jan 29 14:39:08 2013 +0000
> 
>     cpufreq: Simplify cpufreq_add_dev()
> 
> Current Tegra driver fills only ->related_cpus and not ->cpus, which looks to be
> incorrect. Lets fix it.

Joseph Lo reviewed/tested this and it looks fine, so,

Acked-by: Stephen Warren <swarren@nvidia.com>
