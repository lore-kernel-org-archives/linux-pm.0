From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] power: add an API to log wakeup reasons
Date: Thu, 13 Mar 2014 23:18:14 +0100
Message-ID: <1559784.2mnpODc5zV@vostro.rjw.lan>
References: <1394653598-17143-1-git-send-email-kandoiruchi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58134 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753103AbaCMWCv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Mar 2014 18:02:51 -0400
In-Reply-To: <1394653598-17143-1-git-send-email-kandoiruchi@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ruchi Kandoi <kandoiruchi@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, ghackmann@google.com, john.stultz@linaro.org, toddpoynor@google.com

Hi,

I saw the v4, but I don't have it handy, so replying here.

On Wednesday, March 12, 2014 12:46:38 PM Ruchi Kandoi wrote:
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

So what exactly is wrong with using wakeup sources for this purpose?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
