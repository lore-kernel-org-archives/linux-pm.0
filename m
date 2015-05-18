From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 14/14] cpufreq: Add support for physical hoplug of CPUs
Date: Mon, 18 May 2015 02:30:19 +0200
Message-ID: <6810633.U8XLCHe8Cd@vostro.rjw.lan>
References: <cover.1431065963.git.viresh.kumar@linaro.org> <3771347.4CYzBDSQ1Q@vostro.rjw.lan> <20150516021307.GE4600@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64324 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751102AbbERAFB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 17 May 2015 20:05:01 -0400
In-Reply-To: <20150516021307.GE4600@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On Saturday, May 16, 2015 07:43:07 AM Viresh Kumar wrote:
> On 16-05-15, 03:18, Rafael J. Wysocki wrote:
> > You seem to be breaking things first and then fixing them up with this patch.
> > 
> > Would it be possible to avoid breaking them in the first place?
> 
> I thought it was already broken in mainline and so did it towards the
> end. Will check that again.

Well, if the sysfs directories are removed on every offline, then in particular
they will be removed when the device is physically going away, so it should
actually work (unless we've broken it already and nobody noticed).

If you want to keep them around after offline, you need to become careful
about the "physical hot-remove" case at the same time (and not several patches
later).


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
