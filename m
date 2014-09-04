From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq_opp: Fixed the order of argument for kcalloc.
Date: Fri, 05 Sep 2014 01:48 +0200
Message-ID: <156662991.4EXBqE3pLR@vostro.rjw.lan>
References: <1408180966-15493-1-git-send-email-moon.linux@yahoo.com> <5408D4A5.5040103@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60734 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750974AbaIDX2k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 19:28:40 -0400
In-Reply-To: <5408D4A5.5040103@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Anand Moon <moon.linux@yahoo.com>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, September 04, 2014 02:07:49 PM Stephen Boyd wrote:
> On 08/16/14 02:22, Anand Moon wrote:
> > These changes fix the argument to the kcalloc
> >         @n: number of elements.
> >         @size: element size.
> >         @flags: the type of memory to allocate (see kmalloc).
> >
> >         void *kcalloc(size_t n, size_t size, gfp_t flags)
> >
> > Signed-off-by: Anand Moon <moon.linux@yahoo.com>
> > ---
> 
> Oops.
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Can this be picked up?

It could be if I could find it.  Which is not the case, unfortunately.

Anybody care to resend it?

Rafael

