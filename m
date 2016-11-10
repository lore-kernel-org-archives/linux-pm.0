From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH][RFC v7] timekeeping: Ignore the bogus sleep time if
 pm_trace is enabled
Date: Thu, 10 Nov 2016 18:16:58 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1611101816370.3501@nanos>
References: <1478753753-24650-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478753753-24650-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 10 Nov 2016, Chen Yu wrote:

> Previously we encountered some memory overflow issues due to
> the bogus sleep time brought by inconsistent rtc, which is
> triggered when pm_trace is enabled, and we have fixed it
> in recent kernel. However it's improper in the first place
> to call __timekeeping_inject_sleeptime() in case that pm_trace
> is enabled simply because that "hash" time value will wreckage
> the timekeeping subsystem.
> 
> This patch is originally written by Thomas, which would bypass
> the bogus rtc interval when pm_trace is enabled.
> Meanwhile, if system succeed to resume back with pm_trace set, the
> users are warned to adjust the bogus rtc either by ntp-date or rdate,
> by resetting pm_trace_rtc_abused to false, otherwise above tools might
> not work as expected.
> 
> Originally-from: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Xunlei Pang <xlpang@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>


Acked-by: Thomas Gleixner <tglx@linutronix.de>
