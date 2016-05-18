From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/6] cpufreq: minor cleanups
Date: Wed, 18 May 2016 23:06:54 +0200
Message-ID: <CAJZ5v0iK4iG2NWUUMDQvb_=0JUu5_8F0jaTd_BO=R6v+50McMA@mail.gmail.com>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37982 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbcERVG4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 17:06:56 -0400
Received: by mail-wm0-f52.google.com with SMTP id n129so7541193wmn.1
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2016 14:06:55 -0700 (PDT)
In-Reply-To: <cover.1463574213.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Wed, May 18, 2016 at 2:25 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Rafael,
>
> These are few cleanup patches for cpufreq governors, they shouldn't be
> doing any functional changes.
>
> Rebased over bleeding-edge.
>
> --
> viresh
>
> Viresh Kumar (6):
>   cpufreq: governor: Remove prints from allocation failures
>   cpufreq: governor: Remove unnecessary bits from print message
>   cpufreq: schedutil: Improve prints messages with pr_fmt
>   cpufreq: conservative: Remove declaration of cs_dbs_gov
>   cpufreq: Reuse gov_attr_* macros in schedutil governor
>   cpufreq: governor: Create cpufreq_policy_apply_limits()

I'm not sure about the [5/6].  The [4/6] kind of conflicts with a
patch I've been working on recently (just posted).

The [3/6] is simple enough to go into 4.7 and the rest I'm going to
queue up for 4.8.

Thanks!
