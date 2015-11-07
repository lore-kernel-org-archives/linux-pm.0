From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 0/4] PM / OPP: Fixes
Date: Sat, 07 Nov 2015 02:06:55 +0100
Message-ID: <2575401.jBOmqxrMET@vostro.rjw.lan>
References: <cover.1446713282.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41859 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753326AbbKGAhm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2015 19:37:42 -0500
In-Reply-To: <cover.1446713282.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Thursday, November 05, 2015 02:21:17 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> V1 only contained a single patch, i.e. 2/4 from this series. And then
> there were few suggestions to incorporate.
> 
> All are marked for stable 4.3, as this got changed recently.
> 
> I have tested it on exynos (Yeah, I was able to reproduce the lockdep
> with few config changes).
> 
> Viresh Kumar (4):
>   PM / OPP: Propagate error properly from dev_pm_opp_set_sharing_cpus()
>   PM / OPP: Protect updates to list_dev with mutex
>   PM / OPP: Hold dev_opp_list_lock for writers
>   PM / OPP: Add opp_rcu_lockdep_assert() to _find_device_opp()
> 
>  drivers/base/power/opp/core.c | 21 +++++++++++++++++----
>  drivers/base/power/opp/cpu.c  | 10 +++++-----
>  drivers/base/power/opp/opp.h  |  3 +++
>  3 files changed, 25 insertions(+), 9 deletions(-)

Applied, but I removed the stable tag from the last patch as it really
is not a bug fix.

Thanks,
Rafael

