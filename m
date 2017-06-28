From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: dt: Set default policy->transition_delay_ns
Date: Wed, 28 Jun 2017 22:52:53 +0200
Message-ID: <3617293.cCXa2uXImB@aspire.rjw.lan>
References: <16157eb75bb26cca73a0da930e49f2549b96fd65.1495429745.git.viresh.kumar@linaro.org> <CAJZ5v0hWQ0=3aB1Xp2tU1RyMfVhg-9xZiix8ccpH_MjvqS5PAw@mail.gmail.com> <20170628041455.GE29665@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48270 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751501AbdF1VAW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2017 17:00:22 -0400
In-Reply-To: <20170628041455.GE29665@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Leo Yan <leo.yan@linaro.org>, Brendan Jackman <brendan.jackman@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>

On Wednesday, June 28, 2017 09:44:55 AM Viresh Kumar wrote:
> On 27-06-17, 18:08, Rafael J. Wysocki wrote:
> > On Tue, Jun 27, 2017 at 6:20 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > @Rafael: Will it be fine to lower down the value of LATENCY_MULTIPLIER?
> > 
> > We can do that, but then I think we need to compensate for the change
> > in the old governors code or there may be surprises.
> 
> Why shouldn't we change the value of LATENCY_MULTIPLIER for old
> governors as well? They use the same calculations and the sampling
> rate there is also this bad (like rate_limit_us).

On some systems.  On other systems it isn't.

> If we aren't going to change that for old governors, then we can
> create a local version of LATENCY_MULTIPLIER for schedutil I believe.

OK, so at least for intel_pstate and acpi-cpufreq we want a 10 ms default
which is what we have currently.

If you want to rework all that, make sure you preserve that.

Thanks,
Rafael
