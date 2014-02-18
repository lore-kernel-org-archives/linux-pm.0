From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Kconfig.arm: Do not select GENERIC_CPUFREQ_CPU0
Date: Tue, 18 Feb 2014 11:07:17 +0530
Message-ID: <CAKohponYMWSARUXuga9ep9nYWGzgoShTH+cp62zhGxgP=VG=kQ@mail.gmail.com>
References: <1392662127-31005-1-git-send-email-fabio.estevam@freescale.com>
	<8017605.Hn2oDKGgE8@vostro.rjw.lan>
	<20140218022619.GD15716@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:41052 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaBRFhS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2014 00:37:18 -0500
Received: by mail-oa0-f47.google.com with SMTP id m1so18628794oag.6
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2014 21:37:17 -0800 (PST)
In-Reply-To: <20140218022619.GD15716@S2101-09.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Fabio Estevam <fabio.estevam@freescale.com>, festevam@gmail.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 18 February 2014 07:56, Shawn Guo <shawn.guo@linaro.org> wrote:
> Dropping this selection does not break build of highbank cpufreq driver,
> but will result in a non-functional driver.  So maybe we need
>
>         depends on GENERIC_CPUFREQ_CPU0

+1
