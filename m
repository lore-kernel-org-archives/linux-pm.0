From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 3/5] cpufreq: ondemand: queue work for policy->cpus together
Date: Wed, 28 Oct 2015 07:38:20 +0100
Message-ID: <1864040.ba6Ezq0vlE@vostro.rjw.lan>
References: <cover.1444723240.git.viresh.kumar@linaro.org> <b98689db34097553ee142bbb2efda2612af553e5.1444723240.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64464 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753192AbbJ1GJX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 02:09:23 -0400
In-Reply-To: <b98689db34097553ee142bbb2efda2612af553e5.1444723240.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Tuesday, October 13, 2015 01:39:03 PM Viresh Kumar wrote:
> Currently update_sampling_rate() runs over each online CPU and
> cancels/queues work on it. Its very inefficient for the case where a
> single policy manages multiple CPUs, as they can be processed together.

In the case of one policy object shared between multiple CPUs, I'm
wondering why we don't use a single delayed work function for all of them
in the first place.  That would address the problem at the source instead
of dealing with the symptoms.

> Also drop the unnecessary cancel_delayed_work_sync() as we are doing a
> mod_delayed_work_on() in gov_queue_work(), which will take care of
> pending works for us.

I'd prefer a separate patch for that if poss.

Thanks,
Rafael

