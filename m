From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: OF: Use pr_debug() instead of pr_err() while adding OPP table
Date: Sat, 22 Jul 2017 00:40:46 +0200
Message-ID: <14322466.yTyg3YtxMl@aspire.rjw.lan>
References: <3b5b0e789b7296f7b38f4ab9503a53031280a672.1499831484.git.viresh.kumar@linaro.org> <20170713061014.GU22780@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57044 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753527AbdGUWsk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2017 18:48:40 -0400
In-Reply-To: <20170713061014.GU22780@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Mason <slash.tmp@free.fr>, linux-kernel@vger.kernel.org

On Wednesday, July 12, 2017 11:10:14 PM Stephen Boyd wrote:
> On 07/12, Viresh Kumar wrote:
> > Some platforms add the OPPs dynamically from platform specific drivers
> > instead of getting them statically from DT. The cpufreq-dt driver
> > already ignores the return value of dev_pm_opp_of_cpumask_add_table() to
> > not error out for such cases, but we still end up printing error message
> > from that routine. That's not nice.
> > 
> > Convert the print message to use pr_debug() instead.
> > 
> > Reported-by: Mason <slash.tmp@free.fr>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Applied, thanks!
