From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] cpufreq: Use sorted frequency tables
Date: Wed, 1 Jun 2016 16:16:12 +0530
Message-ID: <20160601104612.GM3725@vireshk-i7>
References: <cover.1464694144.git.viresh.kumar@linaro.org>
 <CAJZ5v0ig61Q+EDjjcyHef5e9B4dKY+BhF802uV61w-G5CdRQvA@mail.gmail.com>
 <20160601010856.GM9864@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36621 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbcFAKqQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 06:46:16 -0400
Received: by mail-pf0-f176.google.com with SMTP id f144so13071662pfa.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2016 03:46:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160601010856.GM9864@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 31-05-16, 18:08, Steve Muckle wrote:
> Checking the table type

I hope you are talking about my patch here and in that case its not
table-type, but relation-type.

> and performing the associated lookup seems
> workable to me though it adds a bit of complexity.
> 
> Also what about leaving it as is?

So, your series kind of just triggered this thing, but freq matching
should always be really fast. And I feel that we should attempt to
making it fast.

> I didn't fully catch the concern with
> abuse in the series I posted, and it pushes this complexity of dealing
> with the freq table efficiently down into the driver, which is best
> suited for that IMO.

Not really. Its a single driver today, it will be 20 drivers tomorrow.
We really want to do such common stuff in core whenever it is
possible.

> Another thought is that it'd be nice to eventually reduce
> cpufreq_driver_{fast_switch,resolve_freq} into simple inline functions
> so that we could jump to the driver directly from schedutil, eliminating
> a function call.

That's kind of orthogonal to this :)

-- 
viresh
