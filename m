From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: Make sure CPU is running on a freq from freq-table
Date: Wed, 27 Nov 2013 08:31:02 +0530
Message-ID: <CAKohpokjAuUA-o4cJi=N7mO93kTwrmfVqtL-zOHAs6awKoXn1A@mail.gmail.com>
References: <046513da96dfec919a1a41d270c167147d4a9c8d.1385353358.git.viresh.kumar@linaro.org>
	<2997050.eogEtPXZyL@vostro.rjw.lan>
	<CAKohpon22PxGdTFcaOqzpLpVZd75OPP470Wyy95GjBhG2gViyQ@mail.gmail.com>
	<2309056.KUZA1Fnj0Y@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33883 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab3K0DBE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2013 22:01:04 -0500
Received: by mail-ob0-f169.google.com with SMTP id wm4so6844675obc.28
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2013 19:01:03 -0800 (PST)
In-Reply-To: <2309056.KUZA1Fnj0Y@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Carlos Hernandez <ceh@ti.com>

On 27 November 2013 01:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> I was talking about the case when your
>
> __cpufreq_driver_target(policy, policy->cur - 1, CPUFREQ_RELATION_L);
>
> fails.  The other case is not really interesting.

Okay.. I actually thought the context of this chat is about "not fixing the
frequency silently". That's what Dirk pointed out, if I am not wrong.

And hence I also support the new pr_warn I have added in those cases.
But yes a WARN_ON() can be printed out in case
__cpufreq_driver_target() fails.
