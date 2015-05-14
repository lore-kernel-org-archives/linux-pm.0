From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 00/17] Tegra124 CL-DVFS / DFLL clocksource + cpufreq
Date: Thu, 14 May 2015 22:15:40 +0200
Message-ID: <3099473.H5qjMpDQKF@vostro.rjw.lan>
References: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi> <2216026.DiZ8MPKfdF@vostro.rjw.lan> <55543D6F.2040704@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52492 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965068AbbENTu1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2015 15:50:27 -0400
In-Reply-To: <55543D6F.2040704@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Cc: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, viresh.kumar@linaro.org, mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi

On Thursday, May 14, 2015 09:15:11 AM Mikko Perttunen wrote:
> On 05/14/2015 01:47 AM, Rafael J. Wysocki wrote:
>  > ...
> >
> > If I'm supposed to apply this, I need ACKs from the appropriate people on
> > all the patches where they are still missing.  Thanks!
> >
> >
> 
> I believe Thierry Reding will apply the series; your ACK as cpufreq 
> maintainer for patch 13, and maybe also 12, would be welcome, though :)
> 
> Patch 13 just renames the old tegra-cpufreq driver that only applies to 
> Tegra20 chips to tegra20-cpufreq.
> 
> Patch 12 adds device tree bindings. Maybe these can also be acked by 
> Thierry? I'm not completely sure what's the convention.

You need ACKs from Viresh for those two, then.  He's officially responsible
for ARM cpufreq drivers.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
