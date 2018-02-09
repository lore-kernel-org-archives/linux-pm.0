From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Date: Fri, 9 Feb 2018 14:10:39 +0530
Message-ID: <20180209084039.GZ28462@vireshk-i7>
References: <1518109302-8239-1-git-send-email-claudio@evidence.eu.com>
 <20180209035143.GX28462@vireshk-i7>
 <197c26ba-c2a6-2de7-dffa-5b884079f746@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:40723 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbeBIIkn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Feb 2018 03:40:43 -0500
Received: by mail-pg0-f47.google.com with SMTP id g2so3178106pgn.7
        for <linux-pm@vger.kernel.org>; Fri, 09 Feb 2018 00:40:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <197c26ba-c2a6-2de7-dffa-5b884079f746@evidence.eu.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09-02-18, 09:02, Claudio Scordino wrote:
> If I'm not wrong, at the hardware level we do have a physical rate limit (as we cannot trigger a frequency update when there is one already on-going).
> Don't know if this could somehow mitigate such effect.

Yeah, so in the worst case we will start a new freq-change right after
the previous one has finished.

-- 
viresh
