From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/3] cpufreq: schedutil: map raw required frequency to
 driver frequency
Date: Tue, 31 May 2016 11:02:51 +0200
Message-ID: <20160531090251.GJ3193@twins.programming.kicks-ass.net>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
 <1464231181-30741-4-git-send-email-smuckle@linaro.org>
 <20160526071629.GW17585@vireshk-i7>
 <CAJZ5v0gxfRBeQTyHACVtRpon50N_t3qytrFPT4ga2zwPhVYYdw@mail.gmail.com>
 <20160530101830.GE30066@vireshk-i7>
 <CAJZ5v0hwohZh_Pubt5pc2NoiMWrSDkcfjkbcFuugPkRTwKhejQ@mail.gmail.com>
 <20160530153233.GA9463@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48021 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756701AbcEaJC5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 05:02:57 -0400
Content-Disposition: inline
In-Reply-To: <20160530153233.GA9463@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Mon, May 30, 2016 at 09:02:33PM +0530, Viresh Kumar wrote:
> But this is something that is fundamentally broken for now. The user writes
> updates the policy->max/min, we return the call to the user thinks that it has

IMO the presence of these user min/max files is the broken part.
