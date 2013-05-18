From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] CPUFreq Fixes for 3.10-rc2
Date: Sat, 18 May 2013 07:45:45 +0530
Message-ID: <CAKohponks5tAHGt6wYP13W8y6JiVVAhNW2wTK4GH=MSWe7wcEQ@mail.gmail.com>
References: <cover.1368679353.git.viresh.kumar@linaro.org>
	<10164364.7LZaY8si4T@vostro.rjw.lan>
	<CAKohpo=bNzYw5ire+6XnM+cv6fnPBDN-CX0DRonc5qhpKC01yA@mail.gmail.com>
	<3949011.nZfu3g41l4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3949011.nZfu3g41l4@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com
List-Id: linux-pm@vger.kernel.org

On 18 May 2013 05:10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Well, I actually meant "can you please verify your belief?". :-)
>
> And that's because I'm wondering why the zero-day build testing doesn't
> catch this problem.  Apparently, it doesn't build .configs with cpufreq
> governors configured as modules, although I believe it does test
> "make allmodconfig" for a couple of architectures at least.  What gives?

My assumption was wrong. Actually cpufreq_governor.c is never compiled
as module, but cpufreq_ondemand is...

And this routine isn't used from cpufreq_ondemand but cpufreq_governor..

But we were lucky that we didn't get a error here and EXPORT_SYMBOL
is still required :)
