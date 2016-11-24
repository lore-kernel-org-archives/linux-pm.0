From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 4/4] cpufreq: schedutil: irq-work and mutex are only
 used in slow path
Date: Thu, 24 Nov 2016 11:42:03 +0530
Message-ID: <20161124061203.GF9376@vireshk-i7>
References: <cover.1479197311.git.viresh.kumar@linaro.org>
 <a099804224d5e980a78668fa111e0564b0f44029.1479197311.git.viresh.kumar@linaro.org>
 <20161124045337.GB18417@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34899 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbcKXGMH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 01:12:07 -0500
Received: by mail-pg0-f53.google.com with SMTP id p66so14797915pga.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Nov 2016 22:12:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161124045337.GB18417@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>

On 24-11-16, 05:53, Ingo Molnar wrote:
> 
> Firstly, please start changes to scheduler code with a verb. This title:
> 
>   Subject: Re: [PATCH V2 4/4] cpufreq: schedutil: irq-work and mutex are only used in slow path
> 
> is totally inadequate as it's a statement that says nothing about the _change_.
> 
> What does the patch do? Does it add, remove, modify, fix or clean up?

Thanks for the tip. I have sometimes seen similar subjects-line in patches from
core developers and so thought it might be right. But yes I understand what you
are saying and will take care of this in future across all subsystems.

> * Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > Execute the irq-work specific initialization/exit code only when the
> > fast path isn't available.
> 
> Is this an optimization? A correctness fix?

Its an optimization but yeah I will try to explain a bit more next time.

-- 
viresh
