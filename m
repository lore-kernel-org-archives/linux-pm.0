From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] cpufreq: Use sorted frequency tables
Date: Wed, 1 Jun 2016 16:12:43 +0530
Message-ID: <20160601104243.GL3725@vireshk-i7>
References: <cover.1464694144.git.viresh.kumar@linaro.org>
 <CAJZ5v0ig61Q+EDjjcyHef5e9B4dKY+BhF802uV61w-G5CdRQvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35682 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbcFAKmr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 06:42:47 -0400
Received: by mail-pf0-f172.google.com with SMTP id g64so13052612pfb.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2016 03:42:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ig61Q+EDjjcyHef5e9B4dKY+BhF802uV61w-G5CdRQvA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Steve Muckle <smuckle@linaro.org>

On 01-06-16, 00:50, Rafael J. Wysocki wrote:
> I'm not particularly liking this due to the possible confusion that
> may result from it.

I have gotten rid of most of it now in V2.

> Perhaps we can require drivers implementing ->fast_switch to sort
> their frequency tables to start with?

I wasn't *only* concerned about the fast-switch case, but the case of
normal governors that we use today. After all that's what everybody is
using right now.

And I feel (Maybe you as well), that we are better off using a single
optimized path for all cases. Otherwise things start getting too messy
too soon.

> Or maybe make the core check
> whether or not the table is sorted

Platforms are already broken for this, and so wouldn't be possible to
check for existing governors.

> and in what order and handle it
> accordingly?

We should really be handling a single order to avoid complications in
it :)

> Let's just think about the design here for a while, OK?

Sure. Lets see how bad is V2.

-- 
viresh
