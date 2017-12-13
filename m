From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: schedutil: Don't call sugov_get_util()
 unnecessarily
Date: Wed, 13 Dec 2017 17:32:24 +0530
Message-ID: <20171213120224.GM3322@vireshk-i7>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <7b0698a61bcb959704f58dbabe8c70d657210301.1513158452.git.viresh.kumar@linaro.org>
 <20171213113435.GF30887@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f48.google.com ([209.85.160.48]:37549 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752279AbdLMMC2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 07:02:28 -0500
Received: by mail-pl0-f48.google.com with SMTP id s3so867548plp.4
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2017 04:02:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171213113435.GF30887@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, tkjos@android.com, joelaf@google.com, linux-kernel@vger.kernel.org, Patrick Bellasi <patrick.bellasi@arm.com>

On 13-12-17, 12:34, Juri Lelli wrote:
> It seems that Patrick already posted basically the same change:
> 
> https://patchwork.kernel.org/patch/10084669/

Yeah, only that the reasoning is completely different from what he had (to which
many doubts were raised).

> Also, Cc-ing him for this.. I just noticed he wasn't Cc-ed to the series.

I copied everyone in cc from one of Patrick's email and forgot to copy the guy
in the From field :)

I have bounced all the emails to him now, he should get them.

-- 
viresh
