From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v9] cpufreq: Add SFI based cpufreq driver support
Date: Sat, 20 Dec 2014 13:44:26 -0500
Message-ID: <CAJvTdKmPLHV9ge3MWRRWidN3MjPoNuUmEzvOU8dGm_fYT=WYZw@mail.gmail.com>
References: <20141219174344.GA823@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:38112 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbaLTSo1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 20 Dec 2014 13:44:27 -0500
Received: by mail-yk0-f178.google.com with SMTP id 20so1273270yks.9
        for <linux-pm@vger.kernel.org>; Sat, 20 Dec 2014 10:44:26 -0800 (PST)
In-Reply-To: <20141219174344.GA823@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com

> v9:
>
>  arch/x86/include/uapi/asm/msr-index.h |    1 +
>  drivers/cpufreq/Kconfig.x86           |   10 +++
>  drivers/cpufreq/Makefile              |    1 +
>  drivers/cpufreq/sfi-cpufreq.c         |  136 +++++++++++++++++++++++++++++++++
>  4 files changed, 148 insertions(+)
>  create mode 100644 drivers/cpufreq/sfi-cpufreq.c

Good work!
Applied.

thanks,
Len Brown, Intel Open Source Technology Center
