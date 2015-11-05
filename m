From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 0/4] OPP: Some cleanups
Date: Thu, 05 Nov 2015 23:44:55 +0100
Message-ID: <2102129.RnCaCYDZEq@vostro.rjw.lan>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47670 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754274AbbKEWPn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2015 17:15:43 -0500
In-Reply-To: <cover.1444925400.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, nm@ti.com

On Thursday, October 15, 2015 09:42:42 PM Viresh Kumar wrote:
> Rafael,
> 
> These are some random cleanups, which were part of the multi-regulator
> series earlier. Sending them separately to make that series a bit light
> weight.
> 
> V1->V2:
> - Just sending them separately.
> 
> Viresh Kumar (4):
>   PM / OPP: Improve debug print messages with pr_fmt
>   PM / OPP: Rename routines specific to old bindings with _v1
>   PM / OPP: Parse all power-supply related bindings together
>   PM / OPP: Create separate structure for regulator/supplies
> 
>  drivers/base/power/opp/core.c | 78 +++++++++++++++++++++++++++----------------
>  drivers/base/power/opp/cpu.c  |  3 ++
>  drivers/base/power/opp/opp.h  | 29 +++++++++++-----
>  3 files changed, 73 insertions(+), 37 deletions(-)

Applied [1-3/4], thanks!

Rafael

