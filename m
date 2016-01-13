From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Wed, 13 Jan 2016 12:01:48 +0530
Message-ID: <20160113063148.GJ6050@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
 <20160112112409.GJ1084@ubuntu>
 <20160113005452.10884.77606@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34418 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbcAMGbw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 01:31:52 -0500
Received: by mail-pa0-f48.google.com with SMTP id uo6so336855766pac.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 22:31:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160113005452.10884.77606@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 12-01-16, 16:54, Michael Turquette wrote:
> __cpufreq_driver_target should be using a per-policy lock.

It doesn't :)

-- 
viresh
