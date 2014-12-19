From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/13] cpufreq: stats: cleanups
Date: Fri, 19 Dec 2014 03:15:45 +0100
Message-ID: <3949258.uE4XDaD9A7@vostro.rjw.lan>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52393 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751211AbaLSBx6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 20:53:58 -0500
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Thursday, December 18, 2014 05:30:17 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> I finally started looking at how to make cpufreq-core somewhat less complex with
> respect to locking, its state machine, etc..
> 
> The first thing I had to get into was cpufreq-stats and so this series. Mostly
> cleanups to make things better..
> 
> Please see if they make any sense at all.
> 
> I know we are at Merge window right now and you wouldn't apply it even to
> linux-next. So, if they look fine, please don't hesitate in dropping a mail to
> confirm they look fine, so that I can send the next set of cleanups atleast for
> reviews. We can get these applied one by one then, once we are a bit confident
> of them.

Well, the timing is pretty bad for various reasons.  For one, this isn't 3.19
material, so I'm not even going to look at it tomorrow and I'm officially on
vacation from Monday onward pretty much through the first half of January.

If I have some time and really nothing else to do, I'll have a look at it, but
I can't promise anything.

It would be good if you could ask poeple to have a look at it and give comments
in the meantime.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
