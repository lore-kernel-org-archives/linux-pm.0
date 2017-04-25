From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 11/17] thermal: cpu_cooling: get rid of 'allowed_cpus'
Date: Tue, 25 Apr 2017 10:27:13 +0530
Message-ID: <20170425045713.GU26900@vireshk-i7>
References: <cover.1492579345.git.viresh.kumar@linaro.org>
 <4da549d2565a75420633850b6963fe50b3f02bad.1492579345.git.viresh.kumar@linaro.org>
 <78b14ec9-e107-95dc-03b6-194b00834d6a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36719 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S972896AbdDYE5S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 00:57:18 -0400
Received: by mail-pg0-f49.google.com with SMTP id g2so22463450pge.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Apr 2017 21:57:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <78b14ec9-e107-95dc-03b6-194b00834d6a@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>

On 24-04-17, 17:53, Lukasz Luba wrote:
> The policy pointer forwarded from cpufreq_update_policy()
> is a local variable 'new_policy' so cannot be compared with pinned
> policy pointer in the cooling device.
> You should do the cpumask test like before:
> 	if (!cpumask_test_cpu(policy->cpu,
> 			      cpufreq_cdev->policy->related_cpus))

Right. I have fixed it a bit differently now.

> But there is something still in the patch set...
> I will try to check it tomorrow.

I reviewed all the patches very carefully again, trying to find out the culprit
(I don't have the right hardware to test it like you have).

Found out that max_level isn't used properly at few places, fixed and pushed my
branch now. See if it works fine now.

HEAD: 6a883ddf73cd

-- 
viresh
