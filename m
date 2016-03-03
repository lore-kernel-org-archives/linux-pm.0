From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Wed, 2 Mar 2016 19:50:03 -0800
Message-ID: <56D7B46B.9070508@linaro.org>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <1456190570-4475-4-git-send-email-smuckle@linaro.org>
 <8427745.Y8N2bqC3SO@vostro.rjw.lan> <56CF9D8F.7010607@linaro.org>
 <20160302074910.10178.35029@quark.deferred.io>
 <CAJZ5v0h7HeQYgx91Z4EQLrWh=xa+NP9zunMUvBy6XLt-863n_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34153 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754995AbcCCDuH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 22:50:07 -0500
Received: by mail-pf0-f171.google.com with SMTP id 4so6647979pfd.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2016 19:50:06 -0800 (PST)
In-Reply-To: <CAJZ5v0h7HeQYgx91Z4EQLrWh=xa+NP9zunMUvBy6XLt-863n_A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Ricky Liang <jcliang@chromium.org>

On 03/02/2016 06:49 PM, Rafael J. Wysocki wrote:
> I'm not actually sure if RT is the right answer here.  DL may be a
> better choice.  After all, we want the thing to happen shortly, but
> not necessarily at full speed.
> 
> So something like a DL workqueue would be quite useful here it seems.

The DL idea seems like a good one to me.

It would also prevent cpufreq changes from being delayed by other RT or
DL tasks.

thanks,
Steve
