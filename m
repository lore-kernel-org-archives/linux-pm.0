From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to
 update_cfs_rq_load_avg()
Date: Wed, 30 Mar 2016 18:42:20 -0700
Message-ID: <56FC807C.80204@linaro.org>
References: <1458606068-7476-1-git-send-email-smuckle@linaro.org>
 <56F91D56.4020007@arm.com> <56F95D10.4070400@linaro.org>
 <56F97856.4040804@arm.com> <56F98832.3030207@linaro.org>
 <20160330193544.GD407@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32979 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbcCaBmY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 21:42:24 -0400
Received: by mail-pf0-f179.google.com with SMTP id 4so56738432pfd.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2016 18:42:23 -0700 (PDT)
In-Reply-To: <20160330193544.GD407@worktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On 03/30/2016 12:35 PM, Peter Zijlstra wrote:
> On Mon, Mar 28, 2016 at 12:38:26PM -0700, Steve Muckle wrote:
>> Without covering all the paths where CFS utilization changes it's
>> possible to have to wait up to a tick to act on some changes, since the
>> tick is the only guaranteed regularly-occurring instance of the hook.
>> That's an unacceptable amount of latency IMO...
> 
> Note that even with your patches that might still be the case. Remote
> wakeups might not happen on the destination CPU at all, so it might not
> be until the next tick (which always happens locally) that we'll
> 'observe' the utilization change brought with the wakeups.
> 
> We could force all the remote wakeups to IPI the destination CPU, but
> that comes at a significant performance cost.

What about only IPI'ing the destination when the utilization change is
known to require a higher CPU frequency?

