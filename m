From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: schedutil: Examine the correct CPU when we
 update util
Date: Fri, 3 Nov 2017 09:10:22 +0530
Message-ID: <20171103034022.GD4240@vireshk-i7>
References: <20171102111022.GB4240@vireshk-i7>
 <20171102113840.17439-1-chris.redpath@arm.com>
 <20171102114048.GC4240@vireshk-i7>
 <037169f3-61f9-b29e-9561-0f7dba213cd5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:49031 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbdKCDk1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2017 23:40:27 -0400
Received: by mail-pg0-f50.google.com with SMTP id v78so1396528pgb.5
        for <linux-pm@vger.kernel.org>; Thu, 02 Nov 2017 20:40:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <037169f3-61f9-b29e-9561-0f7dba213cd5@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Redpath <chris.redpath@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On 02-11-17, 12:06, Chris Redpath wrote:
> According to my diff, this was the commit which switched from assigning
> the values directly (and not overwriting the cpu member, which was
> introduced in the other commit you reference) to using a memset and
> clearing the whole struct.

I understand what you want to convey here but the log says something
else according to me. It says:

"Since: 4296f23ed cpufreq: schedutil: Fix per-CPU structure
initialization in sugov_start(), We lost the value of sg_cpu->cpu
which is assigned during sugov_register."

Reading this line it looks like sg_cpu->cpu was screwed up by
4296f23ed, which happened in 4.9. But the sg_cpu->cpu field itself got
added in 4.14 and so I think we should write it differently.

If I were you, I wouldn't mention 4296f23ed here at all but just say
that memset() is clearing the value of sg_cpu->cpu, fix that.

Thanks.

-- 
viresh
