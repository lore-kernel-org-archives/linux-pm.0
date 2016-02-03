From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in
 __cpufreq_governor
Date: Wed, 3 Feb 2016 12:29:17 +0530
Message-ID: <20160203065917.GY31828@vireshk>
References: <1703921.2AHaiQoggk@vostro.rjw.lan>
 <20160201060943.GH13476@vireshk>
 <CAJZ5v0gzKkoKsbv_KG0qL-7=j4a3DU-nOTCG71fZcoumQ0UZUw@mail.gmail.com>
 <56AFBEE5.70501@codeaurora.org>
 <20160202063449.GF31828@vireshk>
 <56B12191.8020407@codeaurora.org>
 <20160203021359.GL31828@vireshk>
 <56B17C56.1030504@codeaurora.org>
 <20160203050256.GQ31828@vireshk>
 <56B18ACB.5070704@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35272 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933049AbcBCG7U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 01:59:20 -0500
Received: by mail-pf0-f178.google.com with SMTP id 65so8773076pfd.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2016 22:59:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56B18ACB.5070704@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com

On 02-02-16, 21:06, Saravana Kannan wrote:
> I disagree. I think it's way better and simpler than this patch set. It also
> doesn't tie into cpufreq_governor.* which is a good thing IMO since it keeps
> things simpler for sched-dvfs too.

Lets discuss it further on the other thread .. 

-- 
viresh
