From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/4] cpufreq: governor: Implement per policy instances
 of governors
Date: Wed, 27 Mar 2013 17:05:22 +0530
Message-ID: <CAKohpok6PsvmixDUEoWMTCOWxOPH9vfeJwee0VcQJ-=JGib7VA@mail.gmail.com>
References: <cover.1362381470.git.viresh.kumar@linaro.org>
	<0823a96fea2d8284b7d83cee390dd5973fdaaa94.1362381470.git.viresh.kumar@linaro.org>
	<CAKohponTZ29BX6CrUvFMy9RXV==0wRFu4C-W1xd6t1RmLASTvQ@mail.gmail.com>
	<2565053.YP0dCLmaW9@vostro.rjw.lan>
	<20130326152059.GA1698@jshin-Toonie>
	<CAKohpons4Tr8F2RuRGCxbOFmJaK9YbAafV-3v6=cijRupe2hUA@mail.gmail.com>
	<20130326194832.GB24945@jshin-Toonie>
	<CAKohpomaTLPZjxcTGKo2mmcqgPvqQVsj1778X1u2rbb3wV+phA@mail.gmail.com>
	<CAKohpo=A4BBecmepsYSqHYrJg5n9WE-QB3ssvb_dOBZYXuB-eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:46258 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab3C0LfX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 07:35:23 -0400
Received: by mail-ob0-f177.google.com with SMTP id eh20so7889535obb.8
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2013 04:35:23 -0700 (PDT)
In-Reply-To: <CAKohpo=A4BBecmepsYSqHYrJg5n9WE-QB3ssvb_dOBZYXuB-eg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Shin <jacob.shin@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, Arvind Chauhan <Arvind.Chauhan@arm.com>

On 27 March 2013 15:34, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> I am still stuck at a issue, which i am not able to fix.
> - cat of */cpufreq/ondemand/** isn't showing anything on console, but all
>   pointers are correctly set and i can see the right values with printk()

The culprit is the part where i changed prototypes of all show/store functions.
I am still trying to understand how that part works, and will fix it soon.

--
viresh
