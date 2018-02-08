From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / Domains: Fixup domain-idle-states OF parsing
Date: Thu, 08 Feb 2018 11:09:49 +0100
Message-ID: <2218102.7hfeEuz1Tu@aspire.rjw.lan>
References: <1516740188-3580-1-git-send-email-ulf.hansson@linaro.org> <20180123210128.GA16708@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:63099 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBHKLd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Feb 2018 05:11:33 -0500
In-Reply-To: <20180123210128.GA16708@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, khilman@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

On Tuesday, January 23, 2018 10:01:28 PM CET Lina Iyer wrote:
> On Tue, Jan 23 2018 at 20:43 +0000, Ulf Hansson wrote:
> >The commit b539cc82d493 ("PM / Domains: Ignore domain-idle-states that are
> >not compatible"), made it possible to ignore non-compatible
> >domain-idle-states OF nodes. However, in case that happens while doing the
> >OF parsing, the number of elements in the allocated array would exceed the
> >numbers actually needed, thus wasting memory.
> >
> >Fix this by pre-iterating the genpd OF node and counting the number of
> >compatible domain-idle-states nodes, before doing the allocation. While
> >doing this, it makes sense to rework the code a bit to avoid open coding,
> >of parts responsible for the OF node iteration.
> >
> >Let's also take the opportunity to clarify the function header for
> >of_genpd_parse_idle_states(), about what is being returned in case of
> >errors.
> >
> >Fixes: b539cc82d493 ("PM / Domains: Ignore domain-idle-states that are not compatible")
> >Cc: Lina Iyer <ilina@codeaurora.org>
> >Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >---
> >
> >Changes in v2:
> >	- Updated changelog to clarify the problem is really about avoiding to
> >	waste memory, according to comment from Lina.
> >
> >---
> Reviewed-by: Lina Iyer <ilina@codeaurora.org>
> 

Patch applied, thanks!
