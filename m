From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFCv5 PATCH 41/46] sched/fair: add triggers for OPP change requests
Date: Mon, 17 Aug 2015 20:22:38 +0200
Message-ID: <2462314.0YL1RfcC5m@vostro.rjw.lan>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-42-git-send-email-morten.rasmussen@arm.com> <20150815124817.GH10304@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64526 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750894AbbHQRzS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2015 13:55:18 -0400
In-Reply-To: <20150815124817.GH10304@worktop.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

On Saturday, August 15, 2015 02:48:17 PM Peter Zijlstra wrote:
> 
> So this OPP thing, I think that got mentioned once earlier in this patch
> set, wth is that?

OPP stands for Operating Performance Points.  It is a library for representing
working clock-voltage combinations.

Described in Documentation/power/opp.txt (but may be outdated as there's some
work on it going on).

CC Viresh who's working on it right now.

Thanks,
Rafael

