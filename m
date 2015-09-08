From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: System will not suspend with highest numbered CPU offline
 [REGRESSION][BISECTED]
Date: Tue, 8 Sep 2015 08:10:14 +0530
Message-ID: <20150908024014.GD26760@linux>
References: <001401d0e691$302127b0$90637710$@net>
 <001601d0e7af$01a22140$04e663c0$@net>
 <20150905081407.GK5285@linux>
 <36067670.SJVW3MBOsV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36192 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbIHCkT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 22:40:19 -0400
Received: by padhk3 with SMTP id hk3so25232437pad.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2015 19:40:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <36067670.SJVW3MBOsV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Saravana Kannan' <skannan@codeaurora.org>, linux-pm@vger.kernel.org

On 07-09-15, 15:32, Rafael J. Wysocki wrote:
> First, if policy->cpu is offline, the policy will be inactive to my eyes, so
> we don't need the second check.

Hmm, or maybe just drop the first check.

> But if the policy is active (and policy->cpu is online), it will not generally
> fail for an offline CPU.

Right.

> So, if the policy applies to more than 1 CPU, you
> can use any of them to manipulate it, even if one of them is offline as long
> as there are any online CPUs in the set.

Right.

> This isn't entirely consistent.  We should either fail store() for any offline
> CPU

At that point we have no idea of the CPU for which the sysfs operation
is called. And so we have to go ahead without failing, if policy is
active.

> or make the changes for offline CPUs to.

What does that mean? Most of the stuff we do is for the policy, rather
than per-cpu. And if there is per-cpu stuff, then we *only* should be
doing that for the online ones.

Not sure if I understood what you meant here. :(

> And in the particular case of
> the governor, I'm wondering what will be the problem with changing last_governor
> for an inactive policy?

I don't think we should be adding special cases for updating sysfs
attributes of an inactive policy. Its not just about the last_governor
thing, but other sysfs attributes as well.

-- 
viresh
