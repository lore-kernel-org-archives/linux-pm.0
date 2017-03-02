From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] cpufreq: schedutil: move cached_raw_freq to struct sugov_policy
Date: Thu, 02 Mar 2017 23:05:39 +0100
Message-ID: <1692186.fFRXBJz7b4@aspire.rjw.lan>
References: <cover.1488437503.git.viresh.kumar@linaro.org> <0ee63c640d47281997d544d05f9dd543aef80588.1488437503.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50114 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751229AbdCBX7N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Mar 2017 18:59:13 -0500
In-Reply-To: <0ee63c640d47281997d544d05f9dd543aef80588.1488437503.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On Thursday, March 02, 2017 02:03:20 PM Viresh Kumar wrote:
> cached_raw_freq applies to the entire cpufreq policy and not individual
> CPUs. Apart from wasting per-cpu memory, it is actually wrong to keep it
> in struct sugov_cpu as we may end up comparing next_freq with a stale
> cached_raw_freq of a random CPU.
> 
> Move cached_raw_freq to struct sugov_policy.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Any chance for a Fixes: tag?

Thanks,
Rafael
