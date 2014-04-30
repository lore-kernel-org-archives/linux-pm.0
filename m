From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 1/3] sched: idle: Encapsulate the code to compile it
 out
Date: Wed, 30 Apr 2014 13:39:28 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1404301311390.980@knanqh.ubzr>
References: <1398342291-16322-1-git-send-email-daniel.lezcano@linaro.org> <1398342291-16322-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:37082 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945926AbaD3Rjc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Apr 2014 13:39:32 -0400
Received: by mail-qc0-f170.google.com with SMTP id x13so2266657qcv.15
        for <linux-pm@vger.kernel.org>; Wed, 30 Apr 2014 10:39:31 -0700 (PDT)
In-Reply-To: <1398342291-16322-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, mingo@elte.hu, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org

On Thu, 24 Apr 2014, Daniel Lezcano wrote:

> Encapsulate the large portion of cpuidle_idle_call inside another
> function so when CONFIG_CPU_IDLE=n, the code will be compiled out.
> Also that is benefitial for the clarity of the code as it removes
> a nested indentation level.

I agree with the nesting level concern.

However I dislike the proliferation of #ifdef's in the main code. Those 
added in this patch are unnecessary. We want as much compilation 
coverage as possible.

With cpuidle_enabled() already hardcoded to return -ENODEV when 
CONFIG_CPU_IDLE=n, the compiler should already be smart enough to 
optimize away all the redundant code in that case.  You may look at the 
assembly output from the compiler if you're not sure.

And if you're still not trusting the compiler then the second best 
option is to use IS_ENABLED(CONFIG_CPU_IDLE) inside some if statement.


Nicolas
