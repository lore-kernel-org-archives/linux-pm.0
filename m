From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] PM / sleep: enable suspend-to-idle even without registered suspend_ops
Date: Wed, 14 Sep 2016 03:06:24 +0200
Message-ID: <4275273.9VZ8d8sI3E@vostro.rjw.lan>
References: <1471538554-28315-1-git-send-email-sudeep.holla@arm.com> <1471614060-15120-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42110 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1759680AbcINBAQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 21:00:16 -0400
In-Reply-To: <1471614060-15120-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Friday, August 19, 2016 02:41:00 PM Sudeep Holla wrote:
> Suspend-to-idle (aka the "freeze" sleep state) is a system sleep state
> in which all of the processors enter deepest possible idle state and
> wait for interrupts right after suspending all the devices.
> 
> There is no hard requirement for a platform to support and register
> platform specific suspend_ops to enter suspend-to-idle/freeze state.
> Only deeper system sleep states like PM_SUSPEND_STANDBY and
> PM_SUSPEND_MEM rely on such low level support/implementation.
> 
> suspend-to-idle can be entered as along as all the devices can be
> suspended. This patch enables the support for suspend-to-idle even on
> systems that don't have any low level support for deeper system sleep
> states and/or don't register any platform specific suspend_ops.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Applied.

Thanks,
Rafael

