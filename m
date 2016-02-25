From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Thu, 25 Feb 2016 10:21:50 +0100
Message-ID: <20160225092150.GC6357@twins.programming.kicks-ass.net>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <1456190570-4475-4-git-send-email-smuckle@linaro.org>
 <8427745.Y8N2bqC3SO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:55205 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758745AbcBYJVz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 04:21:55 -0500
Content-Disposition: inline
In-Reply-To: <8427745.Y8N2bqC3SO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

On Thu, Feb 25, 2016 at 04:55:57AM +0100, Rafael J. Wysocki wrote:
> Well, I'm not familiar with static keys and how they work, so you'll need to
> explain this part to me. 

See include/linux/jump_label.h, it has lots of text on them. There is
also Documentation/static-keys.txt
