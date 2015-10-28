From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/5] cpufreq: ondemand: update sampling rate
 immediately
Date: Wed, 28 Oct 2015 21:17:29 +0530
Message-ID: <20151028154729.GI3716@ubuntu>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
 <3215277.8YKq8PWCpx@vostro.rjw.lan>
 <20151028152811.GE3716@ubuntu>
 <3949153.K5IjKZhpbI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33874 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756112AbbJ1Prd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 11:47:33 -0400
Received: by padhk11 with SMTP id hk11so10562195pad.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2015 08:47:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3949153.K5IjKZhpbI@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 28-10-15, 17:13, Rafael J. Wysocki wrote:
> Well, the second statement above sort of contradicts the first one. :-)
> 
> I guess the answer is "it is problematic, because I can't do the other
> optimization then".

Hehe, right.

> To that I'd really suggest trying to rework the code to use timer
> functions directly in the first place.

I will, but this problem will be present there as well. Because at
that point of time, we will talk about per-cpu timers instead of
delayed-works.

-- 
viresh
