From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: race condition on min/max update?
Date: Fri, 26 Feb 2016 15:11:29 +0100
Message-ID: <5917491.2o5563OMLE@vostro.rjw.lan>
References: <56CE1432.2020409@linaro.org> <20160226025315.GA9159@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46174 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751678AbcBZOJy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 09:09:54 -0500
In-Reply-To: <20160226025315.GA9159@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Friday, February 26, 2016 08:23:15 AM Viresh Kumar wrote:
> +Rafael and linux-pm list
> 
> On 24-02-16, 12:36, Steve Muckle wrote:
> > Hi Viresh,
> > 
> > A while back you mentioned that it is not required to hold policy->rwsem
> > when calling __cpufreq_driver_target. This simplified things for us a
> > bit in schedfreq.
> > 
> > But if policy->rwsem is not held, how does the frequency transition
> > process protect itself against policy->min or policy->max changing?
> > Don't you have a race there where it'd be possible to end up with the
> > frequency being set to a rate lower than min or higher than max?
> > 
> > I've taken a cursory look through the code and don't see what would
> > prevent this from happening.
> 
> It seems that we were not being consistent with this stuff and might have
> ignored this race altogether. On some cases we do update the frequency with
> policy->rwsem and in others we don't.
> 
> It requires a closer look and cleanup I believe.

A min/max update should trigger ->governor(limits) and then the governor
is responsible for taking care of the race (if it needs to).

At least that's how it should work IMO.

Thanks,
Rafael

