From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH v2] PM / Domains: Fixup domain-idle-states OF parsing
Date: Tue, 23 Jan 2018 21:01:28 +0000
Message-ID: <20180123210128.GA16708@codeaurora.org>
References: <1516740188-3580-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45042 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbeAWVBa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jan 2018 16:01:30 -0500
Content-Disposition: inline
In-Reply-To: <1516740188-3580-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, khilman@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

On Tue, Jan 23 2018 at 20:43 +0000, Ulf Hansson wrote:
>The commit b539cc82d493 ("PM / Domains: Ignore domain-idle-states that are
>not compatible"), made it possible to ignore non-compatible
>domain-idle-states OF nodes. However, in case that happens while doing the
>OF parsing, the number of elements in the allocated array would exceed the
>numbers actually needed, thus wasting memory.
>
>Fix this by pre-iterating the genpd OF node and counting the number of
>compatible domain-idle-states nodes, before doing the allocation. While
>doing this, it makes sense to rework the code a bit to avoid open coding,
>of parts responsible for the OF node iteration.
>
>Let's also take the opportunity to clarify the function header for
>of_genpd_parse_idle_states(), about what is being returned in case of
>errors.
>
>Fixes: b539cc82d493 ("PM / Domains: Ignore domain-idle-states that are not compatible")
>Cc: Lina Iyer <ilina@codeaurora.org>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>---
>
>Changes in v2:
>	- Updated changelog to clarify the problem is really about avoiding to
>	waste memory, according to comment from Lina.
>
>---
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
