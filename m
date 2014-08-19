From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [RFC][PATCH 2/2] PM: Suspend: Print wall time at suspend entry
 and exit
Date: Mon, 18 Aug 2014 19:14:13 -0700
Message-ID: <CAAW3YpZf3pimpMu22eHMTmdp4SizE2GfXefyDaDacSKFm3KmJQ@mail.gmail.com>
References: <1406910649-4028-1-git-send-email-amit.pundir@linaro.org>
	<1406910649-4028-3-git-send-email-amit.pundir@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:39327 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbaHSCOO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Aug 2014 22:14:14 -0400
Received: by mail-qc0-f175.google.com with SMTP id w7so5726430qcr.34
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2014 19:14:13 -0700 (PDT)
In-Reply-To: <1406910649-4028-3-git-send-email-amit.pundir@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Pundir <amit.pundir@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, John Stultz <john.stultz@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Ruchi Kandoi <kandoiruchi@google.com>

> Existing printk timestamps in a dmesg only log suspend activities
> (e.g. filesystem syncs, freezing/unfreezing tasks etc) while the
> system has already started to enter/exit the suspend state. Sometimes
> it is handy to have suspend entry/exit overhead information while
> debugging suspend issues. This patch print markers with wall
> timestamps at suspend Entry and Exit in the kernel log. These
> timestamps can be used to compute how long the system spent in
> low-power suspend state plus the entry/exit overhead.
>
> This patch comes from the Android patch set, where its been used to
> help diagnose battery life problems in various Android-based devices.

Thanks Amit.  For this patch, we're actually moving away from
primarily analyzing the kernel log of suspend times, instead logging
this info via userspace.  Android is now using the wakeup_count
suspend interface (previously autosleep was employed), allowing
userspace to be informed whenever suspend is entered and resumed.  The
Android batterystats service logs timestamps for these, along with the
wakeup reason info previously discussed on the linux-pm list.  But it
still is occasionally useful to see the suspend times when debugging
problems based on the kernel log.


Todd
