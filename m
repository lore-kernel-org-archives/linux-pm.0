From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 4/9] cpufreq: governor: Drop __gov_queue_work()
Date: Wed, 09 Sep 2015 03:04:34 +0200
Message-ID: <1661501.6U4Cb8rbZs@vostro.rjw.lan>
References: <cover.1437999691.git.viresh.kumar@linaro.org> <288361840.gGA5ernLiT@vostro.rjw.lan> <20150908020044.GZ26760@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43837 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754173AbbIIAgo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 20:36:44 -0400
In-Reply-To: <20150908020044.GZ26760@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, open list <linux-kernel@vger.kernel.org>

On Tuesday, September 08, 2015 07:30:44 AM Viresh Kumar wrote:
> On 08-09-15, 03:15, Rafael J. Wysocki wrote:
> > On Monday, July 27, 2015 05:58:09 PM Viresh Kumar wrote:
> > > __gov_queue_work() isn't required anymore and can be merged with
> > > gov_queue_work(). Do it.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > Quite frankly I don't see the point.
> 
> But isn't that just an unnecessary wrapper ?

It isn't a wrapper, just a separation of code executed in each step of
the loop.  There's nothing wrong with having a separate function for that
in principle.

I wouldn't make a fuss about that if that was new code even, so I don't
see why we should change it.

> > I'd even remove the inline from its definition and let the compiler decide
> > what to do with it.
> 
> What if the compiler decides to link it? Why add a function call for
> (almost) no use?

If the compiler does that, let it do it. :-)

If you think that you can outsmart the compiler people by doing such
optimizations at this level manually, you're likely wrong.  Serious
man-hours go into making that stuff work as well as it can in compilers.

Thanks,
Rafael

