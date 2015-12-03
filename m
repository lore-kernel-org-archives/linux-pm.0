From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/6] cpufreq: governor: replace per-cpu delayed work with timers
Date: Thu, 03 Dec 2015 03:22:58 +0100
Message-ID: <14079625.yLsVluqBo8@vostro.rjw.lan>
References: <cover.1446121217.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63446 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753662AbbLCBxI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2015 20:53:08 -0500
In-Reply-To: <cover.1446121217.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Thursday, October 29, 2015 05:57:19 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> As suggested by you yesterday, I have updated the governor core to keep
> per-cpu timers and a shared work for the entire policy.
> 
> More details are present in the changelogs, hope they are somewhat
> better this time.
> 
> I have tested it with the test-suite, that I created sometime back while
> fixing locking issues in governors.. Tried all kind of stuff in parallel
> that could have broken it (those are the testcases that separate people
> reported over time, around governors). It works fine.
> 
> The first one is a bug fix really, which I noticed today only :), next
> three are minor cleanups to prepare for the big change. Fourth one is
> the main patch that does the conversion and the final one is
> cherry-picked from the last series as that was still relevant.
> 
> This is rebased over: pm/bleeding-edge + "[PATCH V4] cpufreq: governor:
> Quit work-handlers early if governor is stopped", which I sent
> separately this morning with the changelog you suggested.
> 
> Please see if this meets your expectations or not :)

I like this set overall, except for the useless code shuffling in the first
patch.  Can you please update this one so it doesn't move code it has no
reason to move and resend?

Thanks,
Rafael

