From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V2 0/6] PM / Domains: Implement domain performance states
Date: Fri, 17 Feb 2017 15:22:19 -0800
Message-ID: <m2mvdk4d3o.fsf@baylibre.com>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33414 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964874AbdBQXWb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2017 18:22:31 -0500
Received: by mail-pf0-f176.google.com with SMTP id c73so16535303pfb.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2017 15:22:22 -0800 (PST)
In-Reply-To: <cover.1486611268.git.viresh.kumar@linaro.org> (Viresh Kumar's
        message of "Thu, 9 Feb 2017 09:11:46 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> An earlier series[1] tried to implement bindings for PM domain
> performance states. Rob Herring suggested that we can actually merge the
> supporting code first instead of bindings, as that will make things
> easier to understand for all. The bindings can be decided and merged
> later.
>
> The bindings [1] aren't discarded yet and this series is based on a
> version of those only. The bindings are only used by the last patch,
> which should not be applied and is only sent for completeness.
>
> IOW, this series doesn't have any dependencies and can be merged
> straight away without waiting for the DT bindings.
>
> A brief summary of the problem this series is trying to solve:
>
> Some platforms have the capability to configure the performance state of
> their Power Domains. The performance levels are represented by positive
> integer values, a lower value represents lower performance state.

And what about domains where the performance levels are represented by
someting other than positive integer values? 

IMO, this implementation should start with a more generic approach
(e.g. OPPs) that would be useful on more SoCs that just qcom.  For SoCs
like QCOM, you could use dummy/simplfied OPPs that represent the integer
values passed to the qcom firmware.

> We decided earlier that we should extend Power Domain framework to
> support active state power management as well. The power-domains until
> now were only concentrating on the idle state management of the device
> and this needs to change in order to reuse the infrastructure of power
> domains for active state management.

Yes.  Thanks for working on it!

Kevin
