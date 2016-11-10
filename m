From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH][RFC v7] timekeeping: Ignore the bogus sleep time if
 pm_trace is enabled
Date: Thu, 10 Nov 2016 10:26:09 -0800
Message-ID: <CALAqxLXVaVWBTNs2w-4t6wNsPukQu40wgVcM9B9zudv2KL682Q@mail.gmail.com>
References: <1478753753-24650-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34994 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755465AbcKJS0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 13:26:10 -0500
Received: by mail-yw0-f181.google.com with SMTP id i145so157095234ywg.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2016 10:26:10 -0800 (PST)
In-Reply-To: <1478753753-24650-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Nov 9, 2016 at 8:55 PM, Chen Yu <yu.c.chen@intel.com> wrote:
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


Looks ok to me. I'm queueing it up for testing.  If no one objects
(and I don't see any issues) I'll merge it to my tree and push it to
-tip through Thomas.

thanks
-john
