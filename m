From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: conservative: Fix next frequency selection
Date: Thu, 13 Oct 2016 11:56:16 +0530
Message-ID: <20161013062616.GC2991@vireshk-i7>
References: <5054177.pbJ46HCkrN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34650 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755317AbcJMG0U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2016 02:26:20 -0400
Received: by mail-pf0-f179.google.com with SMTP id r16so6897502pfg.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2016 23:26:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5054177.pbJ46HCkrN@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Aleksey Rybalkin <aleksey@rybalkin.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 12-10-16, 21:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit d352cf47d93e (cpufreq: conservative: Do not use transition
> notifications) overlooked the case when the "frequency step" used
> by the conservative governor is small relative to the distances
> between the available frequencies and broke the algorithm by
> using policy->cur instead of the previously requested frequency
> when computing the next one.
> 
> As a result, the governor may not be able to go outside of a narrow
> range between two consecutive available frequencies.
> 
> Fix the problem by making the governor save the previously requested
> frequency and select the next one relative that value (unless it is
> out of range, in which case policy->cur will be used instead).
> 
> Fixes: d352cf47d93e (cpufreq: conservative: Do not use transition notifications)
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=177171
> Reported-and-tested-by: Aleksey Rybalkin <aleksey@rybalkin.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |   19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
