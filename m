From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC] Should we add Android's Interactive governor into mainline now?
Date: Thu, 12 May 2016 15:19:26 +0200
Message-ID: <CAJZ5v0g3Q+CUo6U55hCBSCMhmcZJ5Or2Ctq7OJx3hxaiDx+F1A@mail.gmail.com>
References: <CAKohponvfRR=nDPcVWpW0L1JZO9+7hgLL7YrWwyJXkL8BtJNpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35524 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcELNT2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2016 09:19:28 -0400
Received: by mail-wm0-f48.google.com with SMTP id e201so258318585wme.0
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2016 06:19:27 -0700 (PDT)
In-Reply-To: <CAKohponvfRR=nDPcVWpW0L1JZO9+7hgLL7YrWwyJXkL8BtJNpg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Ingo Molnar <mingo@kernel.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Thu, May 12, 2016 at 4:04 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Rafael and others,

Hi,

> Since we have moved away from the background timers to scheduler
> callbacks, should we consider merging the Interactive governor into
> mainline ?

We may, depending on how it looks like. :-)

> It was rejected earlier for few reasons, one of which was that we
> didn't wanted to add on any new governors before the background
> timers hack is removed and inputs received from scheduler.

Actually, the last submission did not receive any comments from
anyone, so I'd call it lack of interest rather than rejection.

> I can try putting some effort to do that, but wanted to check what
> others feel about it first.
>
> Its getting used for mobile phones using Android for a very long
> time now.

I think that we'd be better off if the interactive governor was in the
tree, so if you have the time to work on it, that's great.

One caveat is that I have some governor API rearrangement in the works
and you'd need to rebase your work on top of that.  I've just sent two
patches, but there's more to come.
