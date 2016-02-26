From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: race condition on min/max update?
Date: Fri, 26 Feb 2016 08:23:15 +0530
Message-ID: <20160226025315.GA9159@vireshk-i7>
References: <56CE1432.2020409@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36532 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbcBZCxR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 21:53:17 -0500
Received: by mail-pf0-f181.google.com with SMTP id e127so43709446pfe.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Feb 2016 18:53:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56CE1432.2020409@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Juri Lelli <Juri.Lelli@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

+Rafael and linux-pm list

On 24-02-16, 12:36, Steve Muckle wrote:
> Hi Viresh,
> 
> A while back you mentioned that it is not required to hold policy->rwsem
> when calling __cpufreq_driver_target. This simplified things for us a
> bit in schedfreq.
> 
> But if policy->rwsem is not held, how does the frequency transition
> process protect itself against policy->min or policy->max changing?
> Don't you have a race there where it'd be possible to end up with the
> frequency being set to a rate lower than min or higher than max?
> 
> I've taken a cursory look through the code and don't see what would
> prevent this from happening.

It seems that we were not being consistent with this stuff and might have
ignored this race altogether. On some cases we do update the frequency with
policy->rwsem and in others we don't.

It requires a closer look and cleanup I believe.

-- 
viresh
