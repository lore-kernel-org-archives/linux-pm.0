From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: cpufreq_stats NULL deref on second system suspend
Date: Mon, 09 Sep 2013 22:24:06 +0200
Message-ID: <6639035.alELXsX8ZI@vostro.rjw.lan>
References: <522E1FEF.6080803@wwwdotorg.org> <114906795.XcxkLqsNxY@vostro.rjw.lan> <522E291C.6040304@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:39686 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755628Ab3IIUNG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Sep 2013 16:13:06 -0400
In-Reply-To: <522E291C.6040304@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Monday, September 09, 2013 02:01:32 PM Stephen Warren wrote:
> On 09/09/2013 02:01 PM, Rafael J. Wysocki wrote:
> > On Monday, September 09, 2013 01:22:23 PM Stephen Warren wrote:
> >> Viresh,
> >>
> >> I'm seeing the crash below when suspending my system for the second time.
> >>
> >> I can avoid this with the following patch, which adds a check which
> >> already exists in all-but-one other places that the same lookup is made:
> > 
> > Which kernel did you test?
> 
> next-20130909.

Is it reproducible with the current mainline?

Rafael

