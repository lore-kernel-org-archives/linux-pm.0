From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH] cpufreq: schedutil: Reduce frequencies slower
Date: Tue, 11 Apr 2017 23:23:22 +0200
Message-ID: <CAJZ5v0hoPZM_dmfs-6jjN857K9M-RNPKN5Oen3ri7z=g-jeMow@mail.gmail.com>
References: <1514608.eWxQqcMBcc@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33468 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbdDKVXY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2017 17:23:24 -0400
In-Reply-To: <1514608.eWxQqcMBcc@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, John <john.ettedgui@gmail.com>

On Thu, Mar 30, 2017 at 11:36 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The schedutil governor reduces frequencies too fast in some
> situations which cases undesirable performance drops to
> appear.
>
> To address that issue, make schedutil reduce the frequency slower by
> setting it to the average of the value chosen during the previous
> iteration of governor computations and the new one coming from its
> frequency selection formula.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=194963
> Reported-by: John <john.ettedgui@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> This addresses a practical issue, but one in the "responsiveness" or
> "interactivity" category which is quite hard to represent quantitatively.
>
> As reported by John in BZ194963, schedutil does not ramp up P-states quickly
> enough which causes audio issues to appear in his gaming setup.  At least it
> evidently is worse than ondemand in this respect and the patch below helps.
>
> The patch essentially repeats the trick added some time ago to the load-based
> P-state selection algorithm in intel_pstate, which allowed us to make it viable
> for performance-oriented users, and which is to reduce frequencies at a slower
> pace.
>
> The reason why I chose the average is because it is computationally cheap
> and pretty much the max reasonable slowdown and the idea is that in case
> there's something about to run that we don't know about yet, it is better to
> stay at a higher level for a while more to avoid having to get up from the floor
> every time.
>
> But technically speaking it is a filter. :-)
>
> So among other things I'm wondering if that leads to substantial increases in
> energy consumption anywhere.

I haven't seen any numbers indicating that, so since the issue
addressed by this patch is real, I'd like to go ahead with it for
4.12.

Thanks,
Rafael
