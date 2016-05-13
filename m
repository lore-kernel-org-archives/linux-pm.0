From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] Should we add Android's Interactive governor into mainline
 now?
Date: Fri, 13 May 2016 08:49:18 +0530
Message-ID: <20160513031918.GD3415@vireshk-i7>
References: <CAKohponvfRR=nDPcVWpW0L1JZO9+7hgLL7YrWwyJXkL8BtJNpg@mail.gmail.com>
 <CAJZ5v0g3Q+CUo6U55hCBSCMhmcZJ5Or2Ctq7OJx3hxaiDx+F1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35552 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbcEMDTW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2016 23:19:22 -0400
Received: by mail-pf0-f171.google.com with SMTP id 77so37208437pfv.2
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2016 20:19:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g3Q+CUo6U55hCBSCMhmcZJ5Or2Ctq7OJx3hxaiDx+F1A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Ingo Molnar <mingo@kernel.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

On 12-05-16, 15:19, Rafael J. Wysocki wrote:
> Actually, the last submission did not receive any comments from
> anyone, so I'd call it lack of interest rather than rejection.

The last attempt had 70 patches in it :)

> I think that we'd be better off if the interactive governor was in the
> tree, so if you have the time to work on it, that's great.
> 
> One caveat is that I have some governor API rearrangement in the works
> and you'd need to rebase your work on top of that.  I've just sent two
> patches, but there's more to come.

That wouldn't be an issue and anyway I will take some time (I have to find some
first) to do that :)

-- 
viresh
