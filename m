From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Eas-dev] [PATCH V3 1/3] sched: cpufreq: Allow remote cpufreq
 callbacks
Date: Mon, 31 Jul 2017 09:28:02 +0530
Message-ID: <20170731035802.GA4260@vireshk-i7>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
 <0f950529a63fb95e87944644c4854be4fcfaea38.1499927699.git.viresh.kumar@linaro.org>
 <20170721130349.mv7soic62jdnirq5@hirez.programming.kicks-ass.net>
 <597902DA.8060608@codeaurora.org>
 <20170727033059.GD352@vireshk-i7>
 <597A452C.7000303@codeaurora.org>
 <20170728060054.GU352@vireshk-i7>
 <597BA723.1060908@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33312 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdGaD6H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jul 2017 23:58:07 -0400
Received: by mail-pg0-f52.google.com with SMTP id c14so40566123pgn.0
        for <linux-pm@vger.kernel.org>; Sun, 30 Jul 2017 20:58:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <597BA723.1060908@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: eas-dev@lists.linaro.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, smuckle.linux@gmail.com, Len Brown <lenb@kernel.org>

On 28-07-17, 14:05, Saravana Kannan wrote:
> 1. I'm not saying that. I'm saying assuming CPUs can change the freq only on
> behalf of all the CPUs in the same policy is wrong. Again, the scheduler or
> governor shouldn't even be making any of that assumption. That's a CPUfreq
> driver problem.
> 
> 2. No, that is not the basis of the entire cpufreq core design. None of the
> existing CPUfreq code has any assumptions that only CPUs in a policy can
> change their frequency. It doesn't break in any way in system where any CPU
> can change any other CPU's frequency -- all Qualcomm chips are like that.
> It's only the recent scheduler notifier changes that are adding this
> additional limitation and breaking stuff for systems where any CPU can
> change any other CPU's frequency.

Can you please have a look at V5 and see f the solution proposed there would be
fine ?

-- 
viresh
