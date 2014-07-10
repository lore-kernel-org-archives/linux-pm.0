From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: report driver's successful {un}registration
Date: Thu, 10 Jul 2014 19:43:07 +0530
Message-ID: <CAKohpok-ZdxJMCsLMGVA1yhmCjQyTwhCTu7PuXU47wpLQQyxEg@mail.gmail.com>
References: <9e68cba2bf41923630ea93de7c3d17637f175895.1403772686.git.viresh.kumar@linaro.org>
	<20140710114828.GA3254@pd.tnic>
	<CAKohpom0Qwbj5Ma_zCE5juk=1JjbBDLZJcBXZMgnkDVPiTvRCA@mail.gmail.com>
	<20140710115934.GF2970@pd.tnic>
	<CAKohpok0M1_khYB=AobfAuPM9Tf8wi63K5o6NCQ+sC=STP5HMw@mail.gmail.com>
	<20140710140704.GG2970@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:63476 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbaGJONI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jul 2014 10:13:08 -0400
Received: by mail-ob0-f182.google.com with SMTP id wm4so3911983obc.27
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2014 07:13:07 -0700 (PDT)
In-Reply-To: <20140710140704.GG2970@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>

On 10 July 2014 19:37, Borislav Petkov <bp@alien8.de> wrote:
> On Thu, Jul 10, 2014 at 05:38:23PM +0530, Viresh Kumar wrote:
>> The problem with that is: CPUFreq may not be compiled in at all and we
>> wouldn't know the difference between success and absence.
>
> Of course you would: /sys/devices/system/cpu/cpufreq/

Yeah, with a local board its easily detectable.

But I faced the issue when I had to see some test reports from
the automated stuff and wanted to see if cpufreq is up and running.
