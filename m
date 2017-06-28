From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: Set default policy->transition_delay_ns
Date: Wed, 28 Jun 2017 09:44:55 +0530
Message-ID: <20170628041455.GE29665@vireshk-i7>
References: <16157eb75bb26cca73a0da930e49f2549b96fd65.1495429745.git.viresh.kumar@linaro.org>
 <20170522111738.GB9325@leoy-ThinkPad-T440>
 <20170522112727.GI6510@vireshk-i7>
 <1537403.PHBCuCX8Fr@aspire.rjw.lan>
 <20170627042041.GA29665@vireshk-i7>
 <CAJZ5v0hWQ0=3aB1Xp2tU1RyMfVhg-9xZiix8ccpH_MjvqS5PAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34783 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdF1EO7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2017 00:14:59 -0400
Received: by mail-pg0-f42.google.com with SMTP id t186so25554940pgb.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2017 21:14:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hWQ0=3aB1Xp2tU1RyMfVhg-9xZiix8ccpH_MjvqS5PAw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Leo Yan <leo.yan@linaro.org>, Brendan Jackman <brendan.jackman@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>

On 27-06-17, 18:08, Rafael J. Wysocki wrote:
> On Tue, Jun 27, 2017 at 6:20 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > @Rafael: Will it be fine to lower down the value of LATENCY_MULTIPLIER?
> 
> We can do that, but then I think we need to compensate for the change
> in the old governors code or there may be surprises.

Why shouldn't we change the value of LATENCY_MULTIPLIER for old
governors as well? They use the same calculations and the sampling
rate there is also this bad (like rate_limit_us).

If we aren't going to change that for old governors, then we can
create a local version of LATENCY_MULTIPLIER for schedutil I believe.

-- 
viresh
