From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v4] power: add an API to log wakeup reasons
Date: Mon, 7 Jul 2014 15:02:18 +0200
Message-ID: <CANcMJZAm+TfX5W_AMSECBTb8tAzts9_YtOjCXGhmy4SgPAjYqg@mail.gmail.com>
References: <1394730340-3607-1-git-send-email-kandoiruchi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37385 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbaGGNCV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jul 2014 09:02:21 -0400
In-Reply-To: <1394730340-3607-1-git-send-email-kandoiruchi@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ruchi Kandoi <kandoiruchi@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, rjw@rjwysocki.net, ghackmann@google.com, toddpoynor@google.com, Amit Kucheria <amit.kucheria@linaro.org>

On Thu, Mar 13, 2014 at 6:05 PM, Ruchi Kandoi <kandoiruchi@google.com> wrote:
> For power management diagnostic purposes, it is often useful to know
> what interrupts are frequently waking the system from low power
> suspend mode, especially on battery-powered consumer electronics
> devices that are expected to spend much of their time in low-power
> suspend while not in active use.  For example, reduced battery life on
> a mobile phone may be caused in part by frequent wakeups by broadcast
> traffic on a busy wireless LAN even while the screen is off and the
> phone not in active use.
>
> Add API log_wakeup_reason() exposes it to userspace via the sysfs path
> /sys/kernel/wakeup_reasons/last_resume_reason. This API would be called
> from the paltform specific, or from the driver for the interrupt controller,
> when the system resumes because of an IRQ. It logs the reasons which caused
> the system to wakeup from the low-power mode.
>
> This information can be collected by userspace as part of the accounting
> kept on power consumption.

Rafael,
   I realize its been awhile here, but seeing as discussion on this
petered out somewhat ambiguously, I was curious if your thoughts on
using wakeup_sources for this was considered a prereq for further
discussion or if it was a softer thought experiment?

thanks
-john
