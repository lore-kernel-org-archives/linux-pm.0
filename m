From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 Resend 00/92] CPUFreq Cleanup Series: Part II
Date: Fri, 11 Oct 2013 15:27:28 +0200
Message-ID: <4259753.v7BpD2vKia@vostro.rjw.lan>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61255 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757893Ab3JKNPp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2013 09:15:45 -0400
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On Thursday, October 03, 2013 08:27:54 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> As discussed earlier, Part I is now part of your linux-next branch and so
> sending Part II for inclusion in bleeding-edge..
> 
> These are mostly oriented towards using generic .attr, .init(), .exit() and
> .verify() and are so clubbed together.
> 
> These doesn't conflict mostly with the other 11 cpufreq core cleanup patches
> that are floating around:
> http://www.spinics.net/lists/cpufreq/msg07920.html
> 
> Only a minor conflict with following patch of that series for arm_big_little.c
> file:
> http://www.spinics.net/lists/cpufreq/msg07929.html
> 
> You can resolve it easily, pretty straight forward.
> 
> These are based of your linux-next branch:
> ba93c78 Merge branch 'pm-cpufreq-next' into linux-next

So I've just added this to bleeding-edge, but I have a couple complaints.

First off, this is three patch sets in one.  The first part is the generic
.attr(), exit() and .verify() one, the second part is the duplicated
initialization and the third one is about cpufreq_generic_init().  They
really should have been posted and reviewed separately.

And while I'm basically OK with the first and the third part, I'm concerned
about the second one, because it has potential to introduce some subtle
initialization issues (initializing something twice is not a bug per se,
although it is inefficient, but failing to initialize that or initializing it
with an incorrect value *is* a bug).

Second, can you please make your own patch sets apply on top of each other
next time?

Besides, I'm not going to apply any patchset with more than 40 patches in it
in one go any more unless I'm seriously convinced that this is the only way
to go.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
