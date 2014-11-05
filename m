From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 1/5] sched: idle: cpuidle: Check the latency req before idle
Date: Wed, 05 Nov 2014 22:57:47 +0100
Message-ID: <1637800.Fp0noCplzq@vostro.rjw.lan>
References: <1414054881-17713-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55283 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751115AbaKEVhC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Nov 2014 16:37:02 -0500
In-Reply-To: <1414054881-17713-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org

On Thursday, October 23, 2014 11:01:17 AM Daniel Lezcano wrote:
> When the pmqos latency requirement is set to zero that means "poll in all the
> cases".
> 
> That is correctly implemented on x86 but not on the other archs.
> 
> As how is written the code, if the latency request is zero, the governor will
> return zero, so corresponding, for x86, to the poll function, but for the
> others arch the default idle function. For example, on ARM this is wait-for-
> interrupt with a latency of '1', so violating the constraint.
> 
> In order to fix that, do the latency requirement check *before* calling the
> cpuidle framework in order to jump to the poll function without entering
> cpuidle. That has several benefits:
> 
>  1. It clarifies and unifies the code
>  2. It fixes x86 vs other archs behavior
>  3. Factors out the call to the same function
>  4. Prevent to enter the cpuidle framework with its expensive cost in
>     calculation
> 
> As the latency_req is needed in all the cases, change the select API to take
> the latency_req as parameter in case it is not equal to zero.
> 
> As a positive side effect, it introduces the latency constraint specified
> externally, so one more step to the cpuidle/scheduler integration.

I'm expecting to see a new version of this patchset relatively soon.

Are you planning to send one?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
