From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [RFC][PATCH 1/2] PM: Print pending wakeup IRQ preventing suspend
 to dmesg
Date: Mon, 18 Aug 2014 19:19:58 -0700
Message-ID: <CAAW3YpbpA_x4tgSFXtsjHJE1JUvFS3wywk-8XZHRkLdOM0Nrjw@mail.gmail.com>
References: <1406910649-4028-1-git-send-email-amit.pundir@linaro.org>
	<1406910649-4028-2-git-send-email-amit.pundir@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:46729 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbaHSCT7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Aug 2014 22:19:59 -0400
Received: by mail-qc0-f174.google.com with SMTP id l6so5662863qcy.33
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2014 19:19:58 -0700 (PDT)
In-Reply-To: <1406910649-4028-2-git-send-email-amit.pundir@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Pundir <amit.pundir@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, John Stultz <john.stultz@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Ruchi Kandoi <kandoiruchi@google.com>

On Fri, Aug 1, 2014 at 9:30 AM, Amit Pundir <amit.pundir@linaro.org> wrote:
> From: Todd Poynor <toddpoynor@google.com>
>
> Currently when a pending wakeup irq stops suspend, it can be difficult
> to determine why suspend was prevented and which IRQ was actually
> responsible.
>
> In order to help debug these situations, this patch prints the IRQ
> number and action name of that pending wakeup irq which prevents suspend.
> This patch comes from the Android patch set, where its been used to debug
> suspend problems.

This info is sometimes useful to debugging Android suspend / battery
life problems, such as to detect a driver that is failing to service
or clear a wakeup interrupt condition.

In general, we intend to fold reporting of suspend abort reasons
(wakeup IRQ pending, wakelock grabbed, task refusing to freeze...)
into the wakeup reason reporting API to userspace previously discussed
on the linux-pm list (and also revive discussion of how to rework that
for mainline acceptance soon).

Thanks,


Todd
