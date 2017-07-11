From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Tue, 11 Jul 2017 12:09:44 +0530
Message-ID: <20170711063944.GA17115@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan>
 <20170710065443.GG2928@vireshk-i7>
 <4673356.gkeX7KYvlb@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34150 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753946AbdGKGjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 02:39:52 -0400
Received: by mail-pf0-f169.google.com with SMTP id q85so61929856pfq.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2017 23:39:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4673356.gkeX7KYvlb@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 10-07-17, 14:46, Rafael J. Wysocki wrote:
> This particular change is about a new feature, so making it in the core is OK
> in two cases IMO: (a) when you actively want everyone to be affected by it and

IMO this change should be done for the whole ARM architecture. And if some
regression happens due to this, then we come back and solve it.

> (b) when the effect of it on the old systems should not be noticeable.

I am not sure about the effects of this on performance really.

@Dietmar: Any inputs for that ?

-- 
viresh
