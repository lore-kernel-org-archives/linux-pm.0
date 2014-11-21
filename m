From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: qoriq: rename the driver
Date: Fri, 21 Nov 2014 14:47:33 +0530
Message-ID: <CAKohpomtSBosPqU_DcB2Y=gxLXCG9d7MSy92LsMjeebQmVwDxg@mail.gmail.com>
References: <1416554882-16566-1-git-send-email-Yuantian.Tang@freescale.com>
	<1416554882-16566-2-git-send-email-Yuantian.Tang@freescale.com>
	<CAKohpo=xLOxXrCJNO0LmrVxMDNsFy2Kxg6bNzHm=vQCJnBvSaw@mail.gmail.com>
	<dedc11e3150d44ee89bb1e96b5447687@DM2PR03MB574.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:49829 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbaKUJRd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Nov 2014 04:17:33 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so3627419obc.25
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2014 01:17:33 -0800 (PST)
In-Reply-To: <dedc11e3150d44ee89bb1e96b5447687@DM2PR03MB574.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>

On 21 November 2014 14:46, Yuantian Tang <Yuantian.Tang@freescale.com> wrote:
> When I use -C -M options, checkpatch reports error:
>
> [tangyt@titan linux-pm]$ ./scripts/checkpatch.pl 0002-cpufreq-qoriq-rename-the-driver.patch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #15:
>  drivers/cpufreq/{ppc-corenet-cpufreq.c => qoriq-cpufreq.c} | 0
>
> ERROR: Does not appear to be a unified-diff format patch
>
> total: 1 errors, 1 warnings, 0 lines checked
>
> 0002-cpufreq-qoriq-rename-the-driver.patch has style problems, please review.
>
> I just rename it and do not change anyting. Isn't that allowed?

Ignore these warnings.
