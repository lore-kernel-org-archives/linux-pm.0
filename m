From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v3] PM / sleep: enable suspend-to-idle even without
 registered suspend_ops
Date: Wed, 24 Aug 2016 00:18:06 -0500
Message-ID: <CAPBZ5Qco3Y8an66851KJ3HUr9agk6yv7nNrhWA17hHGvbKWXTg@mail.gmail.com>
References: <1471538554-28315-1-git-send-email-sudeep.holla@arm.com> <1471614060-15120-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471614060-15120-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On 19 August 2016 at 08:41, Sudeep Holla <sudeep.holla@arm.com> wrote:
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

I tested this patch on the Qualcomm 410c platform.  It worked like a
charm.  Thanks for working on this!

Tested-by: Andy Gross <andy.gross@linaro.org>
