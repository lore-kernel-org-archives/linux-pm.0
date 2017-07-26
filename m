From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [Eas-dev] [PATCH V3 2/3] cpufreq: schedutil: Process remote callback
 for shared policies
Date: Wed, 26 Jul 2017 13:56:10 -0700
Message-ID: <597901EA.6080702@codeaurora.org>
References: <cover.1499927699.git.viresh.kumar@linaro.org> <3fbaa9aaba19bfff5ff25d2c4141e88fb83f1ea9.1499927699.git.viresh.kumar@linaro.org> <5968263D.1020801@codeaurora.org> <20170720122239.licc6yjd7jwipcvk@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:57114 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdGZU4M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2017 16:56:12 -0400
In-Reply-To: <20170720122239.licc6yjd7jwipcvk@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, eas-dev@lists.linaro.org

On 07/20/2017 05:22 AM, Peter Zijlstra wrote:
> So the typical implementation of fast switching we're thinking of is the
> CPU writing the DVFS request into a machine register. Now machine
> registers are typically per logical CPU.

Writing to a memory addressable register. AFAIK, ARM has no support for 
a machine register for DVFS request. So, even if any ARM licensee wants 
to add one, it won't be possible.

Also, even if we have an ARM CPU with a machine register, rejecting a 
valid frequency switch just because it happened to come on a different 
CPU seem silly (you can have a huge performance hit due to that). A much 
better solution is to just make an IPI to the right CPU and execute the 
machine register write on the right CPU.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
