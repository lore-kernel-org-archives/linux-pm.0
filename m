From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: move policy kobj to policy->cpu at resume
Date: Thu, 10 Jul 2014 12:40:15 +0530
Message-ID: <CAKohpokLj3LbGeZOFpSSDQ1FDREHkigcPq88xGQNub8Hc4V4NQ@mail.gmail.com>
References: <3b19a388891fe997c6c7bc14463453c27312edfa.1404968266.git.viresh.kumar@linaro.org>
	<E807E903FE6CBE4D95E420FBFCC273B87065D4@nasanexd01h.na.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:47488 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbaGJHKQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jul 2014 03:10:16 -0400
Received: by mail-ob0-f172.google.com with SMTP id wn1so538416obc.17
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2014 00:10:15 -0700 (PDT)
In-Reply-To: <E807E903FE6CBE4D95E420FBFCC273B87065D4@nasanexd01h.na.qualcomm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Bu, Yitian" <ybu@qti.qualcomm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "arvind.chauhan@arm.com" <arvind.chauhan@arm.com>, "srivatsa@mit.edu" <srivatsa@mit.edu>, "skannan@codeaurora.org" <skannan@codeaurora.org>, Stable <stable@vger.kernel.org>

On 10 July 2014 12:38, Bu, Yitian <ybu@qti.qualcomm.com> wrote:
> Hi Viresh:
>
> I have verified this patch, all the issues I reported disappeared.
> Thanks for the quick fix.

Please don't top post. http://en.wikipedia.org/wiki/Posting_style

Rafael would be adding your:

Tested-by: Bu Yitian <ybu@qti.qualcomm.com>

Let us know if you don't want that.
