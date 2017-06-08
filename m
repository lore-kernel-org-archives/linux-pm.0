From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V7 1/2] PM / Domains: Add support to select
 performance-state of domains
Date: Thu, 8 Jun 2017 09:48:17 +0200
Message-ID: <CAPDyKFo1-BN2PqXZgKUCGee_QH1zevXFLFSO2+TaCpkWxd5r-g@mail.gmail.com>
References: <cover.1495003720.git.viresh.kumar@linaro.org> <4cc55fce0fd4199941f1d7b785e677255ff792d5.1495003720.git.viresh.kumar@linaro.org>
 <CAPDyKFoWXPJx9pahzv6CkXosncODHSThYA9MoMVdruRtzHRyZg@mail.gmail.com> <20170608070505.GB4634@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36790 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdFHHsS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2017 03:48:18 -0400
Received: by mail-qt0-f180.google.com with SMTP id u19so32368706qta.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2017 00:48:18 -0700 (PDT)
In-Reply-To: <20170608070505.GB4634@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>

[...]

>> As you probably figured out from my above comments, the solution here
>> isn't really working.
>>
>> Adding these new APIs, more or less requires us to manage reference
>> counting on the genpd for the device.
>
> Hmm, I am not able to understand why would we need that with this series :(
>
>> I haven't thought about that in
>> great detail, just that we of course need to be careful if we want to
>> introduce something like that, to make sure all aspect of locking
>> becomes correct.
>>
>> Moreover adding reference counting touches the idea of adding APIs to
>> genpd, to allow users/drivers to control their genpd explicitly. This
>> is required to support > 1 pm_domain per device. I assume you have
>> been following that discussion for genpd on linux-pm as well. My point
>> is that, we should consider that while inventing *any* new APIs.
>
> Not very deeply but yeah I have seen that thread.
>
> So, I couldn't find way to get the locking thing fixed to avoid deadlocks but we
> can live with a constraint (if you guys think it is fine) to have this solved.
>
> Constraint: Update performance state API wouldn't support power domains that
> don't provide a set_performance_state() callback and have multiple parent power
> domains.

No thanks.

If we are going to do this, let's do it properly. To me some minor
constraints would be okay, but this is just too much.

>
> Why: In order to guarantee that we read and update the performance_state of
> subdomains and devices properly, we need to do that under the parent domain's
> lock. And if we have multiple parent power domains, then we would be required to
> get them locked at once before updating subdomain's state and that would be a
> nightmare.

It's not a nightmare, just a tricky thing to solve. :-)

[...]

Kind regards
Uffe
