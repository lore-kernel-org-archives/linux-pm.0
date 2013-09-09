From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: cpufreq_stats NULL deref on second system suspend
Date: Tue, 10 Sep 2013 01:14:30 +0200
Message-ID: <1775778.MeiRhuYy7o@vostro.rjw.lan>
References: <522E1FEF.6080803@wwwdotorg.org> <6639035.alELXsX8ZI@vostro.rjw.lan> <522E3DA2.9020707@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:39821 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756188Ab3IIXDa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Sep 2013 19:03:30 -0400
In-Reply-To: <522E3DA2.9020707@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Monday, September 09, 2013 03:29:06 PM Stephen Warren wrote:
> On 09/09/2013 02:24 PM, Rafael J. Wysocki wrote:
> > On Monday, September 09, 2013 02:01:32 PM Stephen Warren wrote:
> >> On 09/09/2013 02:01 PM, Rafael J. Wysocki wrote:
> >>> On Monday, September 09, 2013 01:22:23 PM Stephen Warren wrote:
> >>>> Viresh,
> >>>>
> >>>> I'm seeing the crash below when suspending my system for the second time.
> >>>>
> >>>> I can avoid this with the following patch, which adds a check which
> >>>> already exists in all-but-one other places that the same lookup is made:
> >>>
> >>> Which kernel did you test?
> >>
> >> next-20130909.
> > 
> > Is it reproducible with the current mainline?
> 
> This does not affect v3.11, but does affect current HEAD; 300893b "Merge
> tag 'xfs-for-linus-v3.12-rc1' of git://oss.sgi.com/xfs/xfs".

What system does it break on?

Any chance to bisect cpufreq changes between 3.11 and the current HEAD?

Rafael

