From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH V4] intel_pstate: Use avg_pstate instead of current_pstate
Date: Fri, 22 Apr 2016 08:18:49 -0700
Message-ID: <004701d19caa$4644c360$d2ce4a20$@net>
References: <1459754617-8872-1-git-send-email-philippe.longepe@linux.intel.com>	<1662176.YWLDtbbot1@vostro.rjw.lan>	<1461286745.8946.203.camel@linux.intel.com> <CAJZ5v0hMTanSQQ9VX2YbTgRvtUkkTDJAJSYcHGxAdtm=xEHE6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta8.telus.net ([209.171.16.81]:46822 "EHLO cmta8.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149AbcDVPSw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Apr 2016 11:18:52 -0400
In-Reply-To: <CAJZ5v0hMTanSQQ9VX2YbTgRvtUkkTDJAJSYcHGxAdtm=xEHE6g@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Philippe Longepe' <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, 'Len Brown' <len.brown@intel.com>, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Stephane Gasparini' <stephane.gasparini@linux.intel.com>

Srinivas,

Recall a couple of months ago, on the "Increase hold-off time before busyness is scaled"
thread, Stephane suggested we try applying this method on the get_target_pstate_use_performance
branch of the intel_pstate driver, as opposed to just on the get_target_pstate_use_cpu_load branch.

It didn't make any difference with respect to the hold-off time issue.
However, I did spend considerable time testing it in other scenarios.
It does somewhat temper the occasional tendency to suddenly have a ridiculously high
scaled busy number with virtually no load (the same issue from the
"[intel-pstate driver regression] processor frequency very high even if in idle" thread,
that continued in https://bugzilla.kernel.org/show_bug.cgi?id=115771 )
I didn't find any significant regression, and did observe some small energy savings
in some scenarios (admittedly, small enough to have possibly been simply test to test
variations, and I didn't do enough tests to extract a definite trend).

I am suggesting to consider extending the patch to get_target_pstate_use_performance also.

... Doug


