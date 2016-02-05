From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/11] cpufreq: governor: Use common global_dbs_data
 pointer
Date: Fri, 5 Feb 2016 08:32:54 +0530
Message-ID: <20160205030254.GA21792@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <1876466.AY9fn15fDn@vostro.rjw.lan>
 <20160204053614.GV3469@vireshk>
 <CAJZ5v0hfNE9HPkHN4up_gL6HNa-sqW5VzJpO1swPwoNPoycuCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33349 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbcBEDC6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 22:02:58 -0500
Received: by mail-pf0-f173.google.com with SMTP id w123so60899573pfb.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2016 19:02:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hfNE9HPkHN4up_gL6HNa-sqW5VzJpO1swPwoNPoycuCQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 04-02-16, 17:52, Rafael J. Wysocki wrote:
> On Thu, Feb 4, 2016 at 6:36 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> > Consider a two policy system, who is stopping us from setting ondemand
> > for one of them and conservative for the other one ? And so, we will
> > have two gdbs_data ..
> 
> I don't really regard that as an entirely sane thing to do, but you
> have a point here.

Why? Its quite useful IMO. For example on TC2, we have two clusters of
A7 and A15. And we actually can configure A7 for interactive and A15
for ondemand. And this is very useful for performance/power metrics.

-- 
viresh
