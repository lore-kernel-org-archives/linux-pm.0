From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] Should we add Android's Interactive governor into mainline
 now?
Date: Fri, 13 May 2016 11:47:01 +0530
Message-ID: <20160513061701.GD4723@vireshk-i7>
References: <CAKohponvfRR=nDPcVWpW0L1JZO9+7hgLL7YrWwyJXkL8BtJNpg@mail.gmail.com>
 <20160512163648.GB12886@graphite.smuckle.net>
 <CAJZ5v0jYqLKf-ckpEm7dm_jHeUkD6ey_cAgdrgFFuFnMYa-HUw@mail.gmail.com>
 <20160512211012.GA28594@graphite.smuckle.net>
 <20160513032156.GE3415@vireshk-i7>
 <20160513061438.GB28594@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35311 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbcEMGRE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2016 02:17:04 -0400
Received: by mail-pa0-f44.google.com with SMTP id iv1so37386399pac.2
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2016 23:17:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160513061438.GB28594@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Ingo Molnar <mingo@kernel.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>

On 12-05-16, 23:14, Steve Muckle wrote:
> Is there precedent for putting in artificial dependencies (i.e. ones
> with no real runtime technical justification) for this kind of purpose,
> i.e. to limit who starts using a merged feature? It seems a bit messy to me.

I am against doing that as well. It was just an option if we want to
*force* people to not use it :)

I think we better leave it to individuals to choose what they want (we
can't control that anyway) and lets include interactive.

Will do some work on that soon.

-- 
viresh
