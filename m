From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: Introduce cpufreq_start_governor()
Date: Tue, 22 Mar 2016 08:44:36 +0530
Message-ID: <20160322031436.GR27778@vireshk-i7>
References: <1780622.pJaGsuQWcI@vostro.rjw.lan>
 <5659583.gVxCIrvT16@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34099 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbcCVDOk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 23:14:40 -0400
Received: by mail-pf0-f170.google.com with SMTP id x3so290041828pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2016 20:14:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5659583.gVxCIrvT16@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 21-03-16, 15:45, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Starting a governor in cpufreq always follows the same pattern
> involving two calls to cpufreq_governor(), one with the event
> argument set to CPUFREQ_GOV_START and one with that argument set to
> CPUFREQ_GOV_LIMITS.
> 
> Introduce cpufreq_start_governor() that will carry out those two
> operations and make all places where governors are started use it.
> 
> That slightly modifies the behavior of cpufreq_set_policy() which
> now also will go back to the old governor if the second call to
> cpufreq_governor() (the one with event equal to CPUFREQ_GOV_LIMITS)
> fails, but that really is how it should work in the first place.
> 
> Also cpufreq_resume() will now pring an error message if the
> CPUFREQ_GOV_LIMITS call to cpufreq_governor() fails, but that
> makes it follow cpufreq_add_policy_cpu() and cpufreq_offline()
> in that respect.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
