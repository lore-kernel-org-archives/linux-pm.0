From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv7 PATCH 02/10] cpufreq: introduce cpufreq_driver_is_slow
Date: Thu, 25 Feb 2016 17:07:01 -0800
Message-ID: <56CFA535.409@linaro.org>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <1456190570-4475-3-git-send-email-smuckle@linaro.org>
 <CAJZ5v0gM56y0+_SCV5RDQzWWJxS_aNWWpi8ZrcGtjZo+fH2uUA@mail.gmail.com>
 <20160226005029.2278.38972@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33682 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693AbcBZBHE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 20:07:04 -0500
Received: by mail-pf0-f170.google.com with SMTP id q63so42150767pfb.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Feb 2016 17:07:03 -0800 (PST)
In-Reply-To: <20160226005029.2278.38972@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>

On 02/25/2016 04:50 PM, Michael Turquette wrote:
>> > Something more sophisticated than this is needed, because one driver
>> > may actually be able to do "fast" switching in some cases and may not
>> > be able to do that in other cases.
>
> Those drivers can set the flag dynamically when they probe based on
> their ACPI tables.

I was thinking that the reference here was to a driver that may be able
to do fast switching for some transitions and not for others, say
perhaps depending on the current and target frequencies, or the state of
the regulators, or other system conditions.

Rafael has proposed a fast_switch() addition to the cpufreq API which
currently returns void. Perhaps that could be extended to return success
or failure from the driver. The driver aborts if it cannot complete the
request atomically and quickly.

The scheduler-driven governor could attempt a fast switch if the
callback is installed (and the other criteria for the fast switch are
met, such as not throttled etc, no request already in flight etc). If
the fast switch aborts, fall back to the slow path.

I suppose the governor could also just see if policy->cur has changed as
opposed to checking cpufreq_driver_fast_switch's return value. But then
we can't tell the difference between the fast transition failing because
it must be re-attempted in the slow path, and the fast transition
failing because of some other more serious reason. In the latter case
the request should probably just be dropped rather than retried in the
slow path.
