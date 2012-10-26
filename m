From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: fix jiffies/cputime mixup in conservative/ondemand governors
Date: Fri, 26 Oct 2012 23:10:10 +0200
Message-ID: <6739224.35DjQmzyyR@vostro.rjw.lan>
References: <m21ugq1vfi.fsf@igel.home> <1448859.RJLWEdIAIe@vostro.rjw.lan> <m2625x5shx.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <m2625x5shx.fsf@igel.home>
Sender: cpufreq-owner@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, October 26, 2012 02:26:34 PM Andreas Schwab wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > http://git.kernel.org/?p=linux/kernel/git/rafael/linux-pm.git;a=shortlog;h=refs/heads/linux-next
> 
> 91f347c looks good, unfortunately d7d6f64 undoes the change.

I didn't notice that, sorry.  Thanks for the heads up.

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
