From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC/RFT][PATCH 1/2] cpufreq: schedutil: Use policy-dependent
 transition delays
Date: Mon, 17 Apr 2017 11:11:50 +0530
Message-ID: <20170417054150.GH28191@vireshk-i7>
References: <3498238.liCqOyIkGA@aspire.rjw.lan>
 <2407280.n9qVSLCrF5@aspire.rjw.lan>
 <71055380.gdY33coAtF@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34836 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932455AbdDQFmB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 01:42:01 -0400
Received: by mail-pf0-f179.google.com with SMTP id i5so61313076pfc.2
        for <linux-pm@vger.kernel.org>; Sun, 16 Apr 2017 22:42:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <71055380.gdY33coAtF@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Brendan Jackman <brendan.jackman@arm.com>

On 11-04-17, 00:20, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the schedutil governor take the initial (default) value of the
> rate_limit_us sysfs attribute from the (new) transition_delay_us
> policy parameter (to be set by the scaling driver).
> 
> That will allow scaling drivers to make schedutil use smaller default
> values of rate_limit_us and reduce the default average time interval
> between consecutive frequency changes.
> 
> Make intel_pstate set transition_delay_us to 500.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a replacement for https://patchwork.kernel.org/patch/9671831/

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
