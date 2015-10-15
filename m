From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH Resend] cpufreq: Drop redundant check for inactive policies
Date: Thu, 15 Oct 2015 02:35:01 +0200
Message-ID: <90321921.5bFa9a5dDU@vostro.rjw.lan>
References: <2d6d59c2b0654872a32a9b63874b750e6b808cb5.1444713966.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42293 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751098AbbJOAGT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 20:06:19 -0400
In-Reply-To: <2d6d59c2b0654872a32a9b63874b750e6b808cb5.1444713966.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, open list <linux-kernel@vger.kernel.org>

On Tuesday, October 13, 2015 10:57:13 AM Viresh Kumar wrote:
> We just made sure policy->cpu is online and this check will always fail
> as the policy is active. Drop it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Saravana Kannan <skannan@codeaurora.org>

Applied, thanks!

Rafael

