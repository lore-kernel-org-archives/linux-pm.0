From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/6] cpufreq: governor: replace per-cpu delayed work with
 timers
Date: Fri, 27 Nov 2015 11:23:27 +0530
Message-ID: <20151127055327.GX3869@ubuntu>
References: <cover.1446121217.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36796 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbbK0Fxc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Nov 2015 00:53:32 -0500
Received: by pacdm15 with SMTP id dm15so104779858pac.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2015 21:53:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cover.1446121217.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 29-10-15, 17:57, Viresh Kumar wrote:
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

Ping !!

-- 
viresh
