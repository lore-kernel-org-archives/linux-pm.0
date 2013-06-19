From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 12/13] cpufreq: tegra: call CPUFREQ_POSTCHANGE notfier
 in error cases
Date: Wed, 19 Jun 2013 11:11:45 -0600
Message-ID: <51C1E651.9040802@wwwdotorg.org>
References: <cover.1371630975.git.viresh.kumar@linaro.org> <73f480a1fa0d39b1d199e598fa9f9df4a9158d11.1371630975.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:60906 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756708Ab3FSRLs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2013 13:11:48 -0400
In-Reply-To: <73f480a1fa0d39b1d199e598fa9f9df4a9158d11.1371630975.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, dave.martin@arm.com, Stephen Warren <swarren@nvidia.com>

On 06/19/2013 02:53 AM, Viresh Kumar wrote:
> PRECHANGE and POSTCHANGE notifiers must be called in groups, i.e either both
> should be called or both shouldn't be.
> 
> In case we have started PRECHANGE notifier and found an error, we must call
> POSTCHANGE notifier with freqs.new = freqs.old to guarantee that sequence of
> calling notifiers is complete.
> 
> This patch fixes it.

Acked-by: Stephen Warren <swarren@nvidia.com>

