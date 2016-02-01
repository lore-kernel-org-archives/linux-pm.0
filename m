From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 00/19] cpufreq locking cleanups and documentation
Date: Mon, 1 Feb 2016 11:32:56 +0530
Message-ID: <20160201060256.GG13476@vireshk>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <56AC0A5E.1010505@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35070 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbcBAGC7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2016 01:02:59 -0500
Received: by mail-pf0-f179.google.com with SMTP id 65so77645639pfd.2
        for <linux-pm@vger.kernel.org>; Sun, 31 Jan 2016 22:02:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56AC0A5E.1010505@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 29-01-16, 16:57, Saravana Kannan wrote:
> I haven't looked at the cpufreq-tests, but I doubt they do hotplug testing
> where they remove all the CPUs of a policy (to trigger a policy exit).

They do.

-- 
viresh
