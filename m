From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 01/17] rtc: pl031: remove misuse of IRQF_NO_SUSPEND flag
Date: Fri, 2 Oct 2015 15:16:43 +0200
Message-ID: <20151002131643.GD10444@piout.net>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdaa+J76vMGHrZsTZukUS-VyDQFPqwg6teV=m050a=P8Pg@mail.gmail.com>
 <560E603E.8080603@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <560E603E.8080603@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alessandro Zummo <a.zummo@towertech.it>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>
List-Id: linux-pm@vger.kernel.org

On 02/10/2015 at 11:45:18 +0100, Sudeep Holla wrote :
> 
> 
> On 02/10/15 11:40, Linus Walleij wrote:
> >On Mon, Sep 21, 2015 at 8:46 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> >>The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
> >>be left enabled so as to allow them to work as expected during the
> >>suspend-resume cycle, but doesn't guarantee that it will wake the system
> >>from a suspended state, enable_irq_wake is recommended to be used for
> >>the wakeup.
> >>
> >>This patch removes the use of IRQF_NO_SUSPEND flags and uses newly
> >>introduce PM wakeup APIs dev_pm_{set,clear}_wake_irq.
> >>
> >>Cc: Linus Walleij <linus.walleij@linaro.org>
> >>Cc: Alessandro Zummo <a.zummo@towertech.it>
> >>Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >>Cc: rtc-linux@googlegroups.com
> >>Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> >Looks correct to me.
> >Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >
> 
> Thanks, while you are at it, do you know what interrupt stv2_pl031
> shares so that I can fix the TODO in the comment or the code(whichever
> applicable).
> 

So that you know, I'm planning to apply them this weekend, I couldn't
find time to do it before.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
