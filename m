From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 02/17] rtc: ab8500: remove misuse of IRQF_NO_SUSPEND flag
Date: Fri, 2 Oct 2015 03:41:37 -0700
Message-ID: <CACRpkdZO2nPex=aKCXEw_Cpq7GMvJBAwiRq471mL-iwUVGZJMA@mail.gmail.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
	<1442850433-5903-3-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36697 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbbJBKli (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2015 06:41:38 -0400
Received: by obcgx8 with SMTP id gx8so78704420obc.3
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2015 03:41:37 -0700 (PDT)
In-Reply-To: <1442850433-5903-3-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>

On Mon, Sep 21, 2015 at 8:46 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
> be left enabled so as to allow them to work as expected during the
> suspend-resume cycle, but doesn't guarantee that it will wake the system
> from a suspended state, enable_irq_wake is recommended to be used for
> the wakeup.
>
> This patch removes the use of IRQF_NO_SUSPEND flags and uses newly
> introduce PM wakeup APIs dev_pm_{set,clear}_wake_irq.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
