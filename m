From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v3 1/3] cpufreq: add cpufreq_driver_resolve_freq()
Date: Thu, 21 Jul 2016 17:44:05 -0700
Message-ID: <20160722004405.GA27987@graphite.smuckle.net>
References: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
 <1468441527-23534-2-git-send-email-smuckle@linaro.org>
 <20160721195926.GF3122@ubuntu>
 <2012245.HQXNKhffmu@vostro.rjw.lan>
 <20160721203041.GH3122@ubuntu>
 <20160721232131.GS27987@graphite.smuckle.net>
 <20160721233003.GM3122@ubuntu>
 <20160721233648.GV27987@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34413 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbcGVAoJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2016 20:44:09 -0400
Received: by mail-pa0-f44.google.com with SMTP id fi15so33890997pac.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2016 17:44:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160721233648.GV27987@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Thu, Jul 21, 2016 at 04:36:48PM -0700, Steve Muckle wrote:
> As another alternative, this could be caught in cpufreq driver
> initialization? I believe you suggested that originally, but I avoided
> it as I didn't want to have to implement resolve_freq() for every
> target() style driver. It sounds like there aren't many though.

Going back and checking I see I was thinking of your suggestion that
cpufreq_register_driver() check that only target() drivers offer a
resolve_freq() callback. I put a comment for this in cpufreq.h but not a
check - I could add a check in another patch if you like.

Long term as I was mentioning in the other thread I think it'd be good
if the current target() drivers were modified to supply resolve_freq(),
and that cpufreq_register_driver() were again changed to require it for
those drivers.

