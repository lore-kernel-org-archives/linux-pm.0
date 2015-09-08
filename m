From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 4/9] cpufreq: governor: Drop __gov_queue_work()
Date: Tue, 8 Sep 2015 07:30:44 +0530
Message-ID: <20150908020044.GZ26760@linux>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
 <4f7aef4f032e082a5093b91d244647f339ef6558.1437999691.git.viresh.kumar@linaro.org>
 <288361840.gGA5ernLiT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36234 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbbIHCAt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 22:00:49 -0400
Received: by padhk3 with SMTP id hk3so24393064pad.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2015 19:00:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <288361840.gGA5ernLiT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, open list <linux-kernel@vger.kernel.org>

On 08-09-15, 03:15, Rafael J. Wysocki wrote:
> On Monday, July 27, 2015 05:58:09 PM Viresh Kumar wrote:
> > __gov_queue_work() isn't required anymore and can be merged with
> > gov_queue_work(). Do it.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Quite frankly I don't see the point.

But isn't that just an unnecessary wrapper ?

> I'd even remove the inline from its definition and let the compiler decide
> what to do with it.

What if the compiler decides to link it? Why add a function call for
(almost) no use?

-- 
viresh
