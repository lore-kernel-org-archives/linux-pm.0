From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 00/13] cpufreq: governors: Fix ABBA lockups
Date: Mon, 08 Feb 2016 18:21:25 +0530
Message-ID: <56B88F4D.2030307@linux.vnet.ibm.com>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:48559 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbcBHMwZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 07:52:25 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Mon, 8 Feb 2016 22:52:23 +1000
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org

Hi,

On 02/08/2016 05:09 PM, Viresh Kumar wrote:
> Hi Rafael,
> 
> Things look much much better now. I have rebased this series over
> pm/bleeding-edge, that has all your patches.
> 
> I have moved ahead and done few more changes in this series, that should
> get rid of all the lockdeps we were getting earlier, that includes
> fixing lockdep issue in update_sampling_rate() that we were chasing.
> 
> These are pushed here again:
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/governor-kobject
> 
> @Juri/Shilpa: Can you please confirm if all the issues got resolved now
> ?

I have tested this patchset on Power8 box and did not find any lockdep warnings.

Thanks and Regards,
Shilpa

