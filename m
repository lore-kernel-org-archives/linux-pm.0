From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5] cpufreq: Add SFI based cpufreq driver support
Date: Wed, 19 Nov 2014 13:03:38 +0530
Message-ID: <CAKohpo=hveN_pcmNHz4G2dGRM4u+ZSZEUTBgOTUzTqK-SPW-wQ@mail.gmail.com>
References: <20141118054537.GA28516@intel-desktop>
	<CAKohpokVi-6+mwhm6qqWCbjnNmm0L-3=6hezYBNg2zoE=ov=5Q@mail.gmail.com>
	<20141118172130.GA29590@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:56502 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbaKSHdj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Nov 2014 02:33:39 -0500
Received: by mail-ob0-f169.google.com with SMTP id vb8so27029obc.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2014 23:33:38 -0800 (PST)
In-Reply-To: <20141118172130.GA29590@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>, Len Brown <lenb@kernel.org>

On 18 November 2014 22:51, Kasagar, Srinidhi <srinidhi.kasagar@intel.com> wrote:
> Not anymore now..I have fixed it in my earlier version.
>
> $ cat /sys/devices/system/cpu/cpu*/cpufreq/affected_cpus
> 0
> 1
> 2
> 3
>
> $  cat /sys/devices/system/cpu/cpu*/cpufreq/related_cpus
> 0
> 1
> 2
> 3

What do you mean by you have fixed it? Weren't the CPUs sharing clock lines?
I hope cpu 0 and 1 should be sharing their clock lines, i.e. they
change freq together.
Also same for cpu 2 and 3.
