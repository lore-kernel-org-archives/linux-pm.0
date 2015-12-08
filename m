From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 5/6] cpufreq: governor: replace per-cpu delayed work with timers
Date: Tue, 08 Dec 2015 15:04:37 +0100
Message-ID: <3708603.AceXez1tmv@vostro.rjw.lan>
References: <cover.1449115453.git.viresh.kumar@linaro.org> <7208072.lZriMRM1aD@vostro.rjw.lan> <20151208133036.GB3692@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57968 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756350AbbLHNei (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2015 08:34:38 -0500
In-Reply-To: <20151208133036.GB3692@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>

On Tuesday, December 08, 2015 07:00:36 PM Viresh Kumar wrote:
> On 08-12-15, 14:18, Rafael J. Wysocki wrote:
> > Well, if the timer function runs on all CPUs at the same time, they all
> > can see skip_work > 1 and none of them will queue the work.
> 
> You are talking about code after my patch, right?

No, I was talking about my first attempt at using the atomic variable. :-)

Thanks,
Rafael

