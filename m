From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: schedutil: set cpu freq to min in idle state
Date: Thu, 18 Aug 2016 13:10 +0200
Message-ID: <5157068.Mf44In0Tcp@vostro.rjw.lan>
References: <1471510531-7330-1-git-send-email-pingbo.wen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51026 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1946029AbcHRLE2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Aug 2016 07:04:28 -0400
In-Reply-To: <1471510531-7330-1-git-send-email-pingbo.wen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: WEN Pingbo <pingbo.wen@linaro.org>
Cc: linux-pm@vger.kernel.org, steve.muckle@linaro.org, Peter Zijlstra <peterz@infradead.org>

On Thursday, August 18, 2016 04:55:31 PM WEN Pingbo wrote:
> The schedutil will keep the frequency high until next thread is arrived,
> when the cpu/cluster enter idle state, which is obviously abnormal and
> inefficient.

It actually is fine on platforms where the energy consumed by CPUs in idle
doesn't depend on the frequency.

> This patch added a idle_timer, which will re-feed in every util
> callback. When cpu enter idle state, the idle_timer expires, and will
> pull down the frequency.

No timers in this code, please.

Thanks,
Rafael

