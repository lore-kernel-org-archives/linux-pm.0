From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 0/2] cpufreq: Use sorted frequency tables
Date: Wed, 1 Jun 2016 12:23:21 -0700
Message-ID: <20160601192321.GO9864@graphite.smuckle.net>
References: <cover.1464694144.git.viresh.kumar@linaro.org>
 <CAJZ5v0ig61Q+EDjjcyHef5e9B4dKY+BhF802uV61w-G5CdRQvA@mail.gmail.com>
 <20160601010856.GM9864@graphite.smuckle.net>
 <20160601104612.GM3725@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34183 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcFATXZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 15:23:25 -0400
Received: by mail-pf0-f172.google.com with SMTP id 62so20649633pfd.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2016 12:23:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160601104612.GM3725@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Jun 01, 2016 at 04:16:12PM +0530, Viresh Kumar wrote:
> On 31-05-16, 18:08, Steve Muckle wrote:
> > Checking the table type
> 
> I hope you are talking about my patch here and in that case its not
> table-type, but relation-type.

I was referring to Rafael's comment about having the core check how the
table was sorted and process it accordingly. It doesn't apply to the
approach in your patches.

> 
> > and performing the associated lookup seems
> > workable to me though it adds a bit of complexity.
> > 
> > Also what about leaving it as is?
> 
> So, your series kind of just triggered this thing, but freq matching
> should always be really fast. And I feel that we should attempt to
> making it fast.

I agree with that goal.

> 
> > I didn't fully catch the concern with
> > abuse in the series I posted, and it pushes this complexity of dealing
> > with the freq table efficiently down into the driver, which is best
> > suited for that IMO.
> 
> Not really. Its a single driver today, it will be 20 drivers tomorrow.
> We really want to do such common stuff in core whenever it is
> possible.
> 
> > Another thought is that it'd be nice to eventually reduce
> > cpufreq_driver_{fast_switch,resolve_freq} into simple inline functions
> > so that we could jump to the driver directly from schedutil, eliminating
> > a function call.
> 
> That's kind of orthogonal to this :)

Handling freq table walking exclusively in cpufreq core will add to the
size of stuff to be inlined in schedutil to avoid extra function calls.	

thanks,
Steve

