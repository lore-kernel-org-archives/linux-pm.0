From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v2] cpufreq: CPPC: Correct desired_perf calculation
Date: Thu, 13 Oct 2016 13:37:11 -0600
Message-ID: <b027d9b7-67c5-68e7-d412-1f22edef34cc@codeaurora.org>
References: <1476380015-21001-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756677AbcJMTqk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2016 15:46:40 -0400
In-Reply-To: <1476380015-21001-1-git-send-email-hotran@apm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hoan Tran <hotran@apm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Al Stone <ahs3@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lho@apm.com, Duc Dang <dhdang@apm.com>, Christopher Covington <cov@codeaurora.org>

On 10/13/2016 11:33 AM, Hoan Tran wrote:
> The desired_perf is an abstract performance number. Its value should
> be in the range of [lowest perf, highest perf] of CPPC.
> The correct calculation is
>   desired_perf = freq * cppc_highest_perf / cppc_dmi_max_khz
>
> And cppc_cpufreq_set_target() returns if desired_perf is exactly
> the same with the old perf.
>
> Signed-off-by: Hoan Tran <hotran@apm.com>
Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>

Hi Rafael,
Can you please pick this one for 4.9, as it is bug fix?

--
Thanks,
Prashanth
