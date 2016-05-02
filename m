From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCHv2] cpufreq: Fix GOV_LIMITS handling for the userspace
 governor
Date: Mon, 2 May 2016 07:37:24 +0530
Message-ID: <20160502020724.GD2855@vireshk-i7>
References: <5723D5C5.9030900@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32958 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbcEBCHa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 May 2016 22:07:30 -0400
Received: by mail-pa0-f51.google.com with SMTP id zm5so76295254pac.0
        for <linux-pm@vger.kernel.org>; Sun, 01 May 2016 19:07:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5723D5C5.9030900@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sai Gurrappadi <sgurrappadi@nvidia.com>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, MLongnecker@nvidia.com

On 29-04-16, 14:44, Sai Gurrappadi wrote:
> Currently, the userspace governor only updates frequency on GOV_LIMITS
> if policy->cur falls outside policy->{min/max}. However, it is also
> necessary to update current frequency on GOV_LIMITS to match the user
> requested value if it can be achieved within the new policy->{max/min}.
> 
> This was previously the behaviour in the governor until commit d1922f0
> ("cpufreq: Simplify userspace governor") which incorrectly assumed that
> policy->cur == user requested frequency via scaling_setspeed. This won't
> be true if the user requested frequency falls outside policy->{min/max}.
> Ex: a temporary thermal cap throttled the user requested frequency.
> 
> Fix this by storing the user requested frequency in a seperate variable.
> The governor will then try to achieve this request on every GOV_LIMITS
> change.
> 
> Fixes: d1922f02562f ("cpufreq: Simplify userspace governor")
> 
> Signed-off-by: Sai Gurrappadi <sgurrappadi@nvidia.com>
> ---
> 
> Changes in v2:
> - Used policy->governor_data rather than using a per-cpu variable
> 
>  drivers/cpufreq/cpufreq_userspace.c | 43 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
