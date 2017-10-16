From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V13 1/7] PM / Domains: Add support to select performance-state of domains
Date: Mon, 16 Oct 2017 03:59:54 +0200
Message-ID: <7hk1zvx36t.fsf@baylibre.com>
References: <431a7a5803b4a552dfe2a71700e19b904c6d16dc.1507703370.git.viresh.kumar@linaro.org>
        <990605fb7b17b75abe63c542a4be2e176152b9f6.1507800860.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51743 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbdJPIff (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 04:35:35 -0400
Received: by mail-wm0-f48.google.com with SMTP id f4so669426wme.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2017 01:35:34 -0700 (PDT)
In-Reply-To: <990605fb7b17b75abe63c542a4be2e176152b9f6.1507800860.git.viresh.kumar@linaro.org>
        (Viresh Kumar's message of "Thu, 12 Oct 2017 15:07:23 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

Viresh Kumar <viresh.kumar@linaro.org> writes:

> Some platforms have the capability to configure the performance state of
> PM domains. This patch enhances the genpd core to support such
> platforms.
>
> The performance levels (within the genpd core) are identified by
> positive integer values, a lower value represents lower performance
> state.
>
> This patch adds a new genpd API, which is called by user drivers (like
> OPP framework):
>
> - int dev_pm_genpd_set_performance_state(struct device *dev,
> 					 unsigned int state);
>
>   This updates the performance state constraint of the device on its PM
>   domain. On success, the genpd will have its performance state set to a
>   value which is >= "state" passed to this routine. The genpd core calls
>   the genpd->set_performance_state() callback, if implemented,
>   else -ENODEV is returned to the caller.
>
> The PM domain drivers need to implement the following callback if they
> want to support performance states.
>
> - int (*set_performance_state)(struct generic_pm_domain *genpd,
> 			       unsigned int state);
>
>   This is called internally by the genpd core on several occasions. The
>   genpd core passes the genpd pointer and the aggregate of the
>   performance states of the devices supported by that genpd to this
>   callback. This callback must update the performance state of the genpd
>   (in a platform dependent way).
>
> The power domains can avoid supplying above callback, if they don't
> support setting performance-states.
>
> Currently we aren't propagating performance state changes of a subdomain
> to its masters as we don't have hardware that needs it right now. Over
> that, the performance states of subdomain and its masters may not have
> one-to-one mapping and would require additional information. We can get
> back to this once we have hardware that needs it.
>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

OK, I really like the OPP-related changes suggested by Ulf, and you've
removed a lot of the complexity that made it a bit confusing to follow.
It's definitley cleaned up and much easier to follow.

Thanks for your persistence.  This is definitely a needed feature.

I have some usecases in mind where the performance state might need to
be selected based on OPP voltage, but that's now a change that can be
added later when that feature is needed.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
