From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH] timekeeping: Cap array access in timekeeping_debug to
 protect against invalid sleep times
Date: Thu, 18 Aug 2016 15:31:20 +0800
Message-ID: <a34f51a8-9d40-0f9a-1e8c-f4feb2654bbe@intel.com>
References: <1469892465-15853-1-git-send-email-yu.c.chen@intel.com>
 <1471461530-19575-1-git-send-email-john.stultz@linaro.org>
 <2035113.3OJj8z3OVW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60465 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753237AbcHRHXU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Aug 2016 03:23:20 -0400
In-Reply-To: <2035113.3OJj8z3OVW@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Janek Kozicki <cosurgi@gmail.com>, Xunlei Pang <xpang@redhat.com>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, John Stultz <john.stultz@linaro.org>



On 2016年08月18日 09:09, Rafael J. Wysocki wrote:
> If pm_trace_enabled is set, we can (or maybe even should) just skip
> timekeeping_inject_sleeptime() entirely in rtc_resume() at least, because
> sleep_time is almost certainly bogus in that case, even if it doesn't
> overflow.
>
> Of course, the above is still needed then.
>
> Thanks,
> Rafael
>
OK, I'll provide another version on top of John's patch and consider the 
pm_trace. thanks.
Yu
