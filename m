From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V3 0/7] PM / Domains: Implement domain performance states
Date: Fri, 10 Mar 2017 12:38:19 -0800
Message-ID: <m237ekrhok.fsf@baylibre.com>
References: <cover.1487926924.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35550 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755424AbdCJUiW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2017 15:38:22 -0500
Received: by mail-pf0-f177.google.com with SMTP id j5so45869042pfb.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2017 12:38:21 -0800 (PST)
In-Reply-To: <cover.1487926924.git.viresh.kumar@linaro.org> (Viresh Kumar's
        message of "Fri, 24 Feb 2017 14:36:32 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, rnayak@codeaurora.org, lina.iyer@linaro.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> This series contain V3 of both the bindings and the code that implement
> them. They were sent separately earlier.
>
> Some platforms have the capability to configure the performance state of
> their power domains. The process of configuring the performance state is
> pretty much platform dependent and we may need to work with a wide range
> of configurables.  For some platforms, like Qcom, it can be a positive
> integer value alone, while in other cases it can be voltage levels, etc.

Why limit it to just voltage levels.

As I suggested earlier, I think this should use OPPs.  Remember that a
PM domain is not limited to a hardware power domain, but is just a
grouping mechanism for devices that share some PM properties.  As
mentioned by Geert, this can also be a clock domain, where frequencies
would make sense as well.  One can imagine using this type of PM domain
to manage an interconnect/bus which has scalable voltage/frequencies as
well.

Kevin
