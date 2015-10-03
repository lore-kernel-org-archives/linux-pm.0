From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 02/17] rtc: ab8500: remove misuse of IRQF_NO_SUSPEND flag
Date: Sat, 3 Oct 2015 17:20:33 +0200
Message-ID: <20151003152033.GB2694@piout.net>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-3-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442850433-5903-3-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
List-Id: linux-pm@vger.kernel.org

On 21/09/2015 at 16:46:58 +0100, Sudeep Holla wrote :
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
> ---
>  drivers/rtc/rtc-ab8500.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
