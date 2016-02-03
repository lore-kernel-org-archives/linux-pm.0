From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/5] cpufreq: governors: Solve the ABBA lockups
Date: Wed, 3 Feb 2016 07:52:34 +0530
Message-ID: <20160203022234.GM31828@vireshk>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
 <CAJZ5v0gcpZWOoY407cKZJgPfbhutbry8hE-mEyzXKx6+tqCgLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36081 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965AbcBCCWi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 21:22:38 -0500
Received: by mail-pf0-f182.google.com with SMTP id n128so4648676pfn.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2016 18:22:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gcpZWOoY407cKZJgPfbhutbry8hE-mEyzXKx6+tqCgLQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 02-02-16, 21:04, Rafael J. Wysocki wrote:
> On Tue, Feb 2, 2016 at 11:57 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Hi Rafael,
> >
> > Sorry for doing this, I know you were also looking to fix this in a
> > possibly different way. But I thought, it would be better if we fix
> > that. We can scrap this version and take yours if that looks better.
> 
> That's not nice to be honest.  At the very least you could have asked
> me about the status of my work before sending this.

I started looking into this yesterday morning, while you were away and
finished it before you came back. So, it would have taken more time
and so I just sent them. I don't have any issues (as mentioned
earlier) is discarding them for the work you might have already done.

> Fortunately, though, when I started to look deeper into fixing this
> problem I thought I didn't like the overall design of things in the
> governor land, so I started to change that and my modifications turn
> out to be sort of complementary with respect to this patchset.

That's good.

> Of
> course, they do conflict, but I can redo my patches on top of these if
> that's necessary.

Yeah, even I don't have any issues in rebasing over your work, if I
have to.

> That said I'm going to post them in their current
> form anyway, at least to show the direction I want to take going
> forward.

Sure.

> > I thought, perhaps the best way to fix it is to give separate sysfs-ops
> > to governors. And that's what I did.
> 
> Yes, that's what I was talking about in the other thread.

I must have missed that then :(

> My overall impression here is that the code changes make sense.  Some
> details need to be improved (like the concurrent ->store for governor
> tunables pointed out by Juri). 

> The patch changelogs suck, though.

Like always :(

> If your hope was that this might go into 4.5, there is a small chance
> of that happening, but only if it can be made ready this week.

Will try my best.

> Otherwise, I'd prefer it to be redone on top of my changes.

No worries.

> Let me comment on the individual patches.

Thanks for taking this up Rafael, really appreciate it :)

-- 
viresh
