From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when considering polling
Date: Fri, 18 Mar 2016 01:45:32 +0100
Message-ID: <10828426.sI6CaBvZhk@vostro.rjw.lan>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com> <CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com> <20160316121400.680a6a46@annuminas.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53240 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965586AbcCRAn3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 20:43:29 -0400
In-Reply-To: <20160316121400.680a6a46@annuminas.surriel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Wednesday, March 16, 2016 12:14:00 PM Rik van Riel wrote:
> The menu governor uses five different factors to pick the
> idle state:
> - the user configured latency_req
> - the time until the next timer (next_timer_us)
> - the typical sleep interval, as measured recently
> - an estimate of sleep time by dividing next_timer_us by an observed factor
> - a load corrected version of the above, divided again by load
> 
> Only the first three items are known with enough confidence that
> we can use them to consider polling, instead of an actual CPU
> idle state, because the cost of being wrong about polling can be
> excessive power use.
> 
> The latter two are used in the menu governor's main selection
> loop, and can result in choosing a shallower idle state when
> the system is expected to be busy again soon.
> 
> This pushes a busy system in the "performance" direction of
> the performance<>power tradeoff, when choosing between idle
> states, but stays more strictly on the "power" state when
> deciding between polling and C1.
> 
> Signed-off-by: Rik van Riel <riel@redhat.com>

Applied, thanks!

