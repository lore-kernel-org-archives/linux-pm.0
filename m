From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH] PM / Domains: Fixup domain-idle-states OF parsing
Date: Tue, 23 Jan 2018 16:12:01 +0000
Message-ID: <20180123161201.GA29171@codeaurora.org>
References: <1516702990-25564-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50350 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeAWQMD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jan 2018 11:12:03 -0500
Content-Disposition: inline
In-Reply-To: <1516702990-25564-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, khilman@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Ulf,

Thanks for the fix. The allocation is more than what is needed and this
will fix that.

On Tue, Jan 23 2018 at 10:23 +0000, Ulf Hansson wrote:
>but also makes of_genpd_parse_idle_states() to return the wrong number of
>allocated elements to the caller.
>
How is this happening?

>
>Fixes: b539cc82d493 ("PM / Domains: Ignore domain-idle-states that are not compatible")
>Cc: Lina Iyer <ilina@codeaurora.org>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>---
> drivers/base/power/domain.c | 76 +++++++++++++++++++++++++++------------------
> 1 file changed, 45 insertions(+), 31 deletions(-)
>
>-	/* Loop over the phandles until all the requested entry is found */
>-	of_for_each_phandle(&it, err, dn, "domain-idle-states", NULL, 0) {
>-		np = it.node;
>-		match_id = of_match_node(idle_state_match, np);
>-		if (!match_id)
>-			continue;
>-		ret = genpd_parse_state(&st[i++], np);
This increments only if the state node matches the compatible.

>-		if (ret) {
>-			pr_err
>-			("Parsing idle state node %pOF failed with err %d\n",
>-							np, ret);
>-			of_node_put(np);
>-			kfree(st);
>-			return ret;
>-		}
>+	ret = genpd_iterate_idle_states(dn, st);
>+	if (ret <= 0) {
>+		kfree(st);
>+		return ret < 0 ? ret : -EINVAL;
> 	}
>
>-	*n = i;
Returns the count of matched state nodes.

What am I missing?

-- Lina
