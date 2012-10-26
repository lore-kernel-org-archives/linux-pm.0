From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] cpufreq: fix jiffies/cputime mixup in conservative/ondemand governors
Date: Fri, 26 Oct 2012 14:26:34 +0200
Message-ID: <m2625x5shx.fsf@igel.home>
References: <m21ugq1vfi.fsf@igel.home> <1448859.RJLWEdIAIe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1448859.RJLWEdIAIe@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Wed, 24 Oct 2012 23:16:49 +0200")
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> http://git.kernel.org/?p=linux/kernel/git/rafael/linux-pm.git;a=shortlog;h=refs/heads/linux-next

91f347c looks good, unfortunately d7d6f64 undoes the change.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
