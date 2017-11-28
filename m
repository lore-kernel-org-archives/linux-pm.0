From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/4] cpufreq: Fix governor module removal race
Date: Tue, 28 Nov 2017 08:08:12 +0530
Message-ID: <20171128023812.GA11413@vireshk-i7>
References: <1655574.Es7zYAeW1r@aspire.rjw.lan>
 <2007526.uAUpsoPmOG@aspire.rjw.lan>
 <16997374.L1f6Qxgytn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f48.google.com ([209.85.160.48]:37992 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753241AbdK1CiQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Nov 2017 21:38:16 -0500
Received: by mail-pl0-f48.google.com with SMTP id s10so9745187plj.5
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2017 18:38:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <16997374.L1f6Qxgytn@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 23-11-17, 14:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is possible to remove a cpufreq governor module after
> cpufreq_parse_governor() has returned success in
> store_scaling_governor() and before cpufreq_set_policy()
> acquires a reference to it, because the governor list is
> not protected during that period and nothing prevents the
> governor from being unregistered then.
> 
> Prevent that from happening by acquiring an extra reference
> to the governor module temporarily in cpufreq_parse_governor(),
> under cpufreq_governor_mutex, and dropping it in
> store_scaling_governor(), when cpufreq_set_policy() returns.
> 
> Note that the second cpufreq_parse_governor() call site is fine,
> because it only cares about the policy member of new_policy.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2: Drop changes to clear policy->governor in
>        cpufreq_parse_governor() in the cpufreq_driver->setpolicy set
>        case, as that field should always be NULL then.
> 
> ---
>  drivers/cpufreq/cpufreq.c |    6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
