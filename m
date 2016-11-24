From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH V2 4/4] cpufreq: schedutil: irq-work and mutex are only
 used in slow path
Date: Thu, 24 Nov 2016 07:24:05 +0100
Message-ID: <20161124062405.GA24022@gmail.com>
References: <cover.1479197311.git.viresh.kumar@linaro.org>
 <a099804224d5e980a78668fa111e0564b0f44029.1479197311.git.viresh.kumar@linaro.org>
 <20161124045337.GB18417@gmail.com>
 <20161124061203.GF9376@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:35920 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbcKXGYJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 01:24:09 -0500
Content-Disposition: inline
In-Reply-To: <20161124061203.GF9376@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>


* Viresh Kumar <viresh.kumar@linaro.org> wrote:

> > * Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > 
> > > Execute the irq-work specific initialization/exit code only when the
> > > fast path isn't available.
> > 
> > Is this an optimization? A correctness fix?
> 
> Its an optimization but yeah I will try to explain a bit more next time.

Thanks!

	Ingo
