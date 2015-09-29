From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv5 PATCH 32/46] sched: Energy-aware wake-up task placement
Date: Mon, 28 Sep 2015 17:15:07 -0700
Message-ID: <5609D80B.5060507@linaro.org>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-33-git-send-email-morten.rasmussen@arm.com>
 <20150902171131.GA12510@leoy-linaro> <55FBE8AF.3050200@arm.com>
 <55FEFD54.3010206@linaro.org> <20150920220324.GA20859@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33309 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbbI2APJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2015 20:15:09 -0400
Received: by pacex6 with SMTP id ex6so187980577pac.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2015 17:15:09 -0700 (PDT)
In-Reply-To: <20150920220324.GA20859@leoy-linaro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 09/20/2015 03:03 PM, Leo Yan wrote:
> In this case of CPU is running at fmax, it's true that
> task_fits_capacity() will return true. But here i think
> cpu_overutilized() also will return true, so that means scheduler will
> go back to use CFS's old way for loading balance. Finally tasks also
> will be spread into two clusters.

Agreed that once the first cluster is overutilized, the load will
definitely spread to both clusters. My concern though is that for this
to occur, the first cluster will likely be pushed to a high OPP. For
power (and even perhaps performance) spreading the load earlier may be
better. Or not, my observation is really just that we're encoding policy
here which ideally would be the result of calculations in the energy model.
