From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/11] cpufreq: governor: Use common global_dbs_data
 pointer
Date: Thu, 4 Feb 2016 11:08:24 +0530
Message-ID: <20160204053824.GW3469@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <1876466.AY9fn15fDn@vostro.rjw.lan>
 <56B2A53C.8080503@codeaurora.org>
 <CAJZ5v0gdR23cCocT3qw4ry26bMQ=qjcwatk9uu-Z1JDLKTSffQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35899 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284AbcBDFi1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 00:38:27 -0500
Received: by mail-pf0-f177.google.com with SMTP id n128so32290667pfn.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2016 21:38:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gdR23cCocT3qw4ry26bMQ=qjcwatk9uu-Z1JDLKTSffQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>

On 04-02-16, 02:25, Rafael J. Wysocki wrote:
> You are talking about something like this now:
> 
>     if (condition)
>         goto label;
> 
>     return 0;
> 
> label:
>     do stuff
> 
> I'm sorry, but I fail to see how this is easier to read than
> 
>     if (!condition)
>         return 0;
> 
>     do stuff

I have seen few people (Like Dan Carpenter), mostly coccinelle guys,
saying that we should write code like this:

if (error)
        ...

return success;

Though I should accept that I would have written code the way Rafael
has done this time, but those people get back everytime :)

-- 
viresh
