From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] cpufreq: Use sorted frequency tables
Date: Thu, 2 Jun 2016 06:55:46 +0530
Message-ID: <20160602012546.GU3725@vireshk-i7>
References: <cover.1464694144.git.viresh.kumar@linaro.org>
 <CAJZ5v0ig61Q+EDjjcyHef5e9B4dKY+BhF802uV61w-G5CdRQvA@mail.gmail.com>
 <20160601104243.GL3725@vireshk-i7>
 <73262725.a4M1UCMWse@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33107 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbcFBBZu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 21:25:50 -0400
Received: by mail-pf0-f171.google.com with SMTP id b124so24462872pfb.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2016 18:25:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <73262725.a4M1UCMWse@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Steve Muckle <smuckle@linaro.org>

On 01-06-16, 18:37, Rafael J. Wysocki wrote:
> On Wednesday, June 01, 2016 04:12:43 PM Viresh Kumar wrote:
> > On 01-06-16, 00:50, Rafael J. Wysocki wrote:
> > > I'm not particularly liking this due to the possible confusion that
> > > may result from it.
> > 
> > I have gotten rid of most of it now in V2.
> > 
> > > Perhaps we can require drivers implementing ->fast_switch to sort
> > > their frequency tables to start with?
> > 
> > I wasn't *only* concerned about the fast-switch case, but the case of
> > normal governors that we use today. After all that's what everybody is
> > using right now.
> 
> Sure, but the "to start with" part of my question was essential.

We can make that a requirement, but I am not sure if that will help us
much. I want to use the same routines for the target_index() callbacks
and the fast_switch() ones.

And that's what I have done in V2 of this series.

> The ordering didn't matter before, so drivers may do silly things related
> to it

Yes they do and that's why I couldn't get rid of policy->freq_table
for now. Though I have plans to sort that out.

> and those may break if we try to change the rules wholesale.

Yes. But the V2 of this series isn't making any such change. Just that
we are keeping a backup sorted table (which drivers wouldn't know
about) to find the right match. We will still keep passing the index
to their *unsorted* tables in target_index() for example.

> In turn, if the (prospective) ->fast_switch users are required to clean up
> their stuff while working on implementig it, we could avoid that breakage,
> or at least some of it.

I understand your point of view, but I think V2 is sorting all that
out without breaking anything at all.

> > > Or maybe make the core check
> > > whether or not the table is sorted
> > 
> > Platforms are already broken for this, and so wouldn't be possible to
> > check for existing governors.
> 
> I really don't know what you wanted to say here.

Oh, I was saying that existing drivers of course don't guarantee that
today, and if we want to make the search fast for existing governors,
we wouldn't be able to do it for all.

> Anyway, I agree that using one ordering would be cleaner, but I'm sort of
> concerned about how painful the switch-over may be to the users.

They wouldn't notice at all. V2 handles that properly.

-- 
viresh
