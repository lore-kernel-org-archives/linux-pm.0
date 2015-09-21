From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 17/17] mfd : ab8500/db8500: fix the abuse of
 IRQF_NO_SUSPEND
Date: Tue, 22 Sep 2015 00:20:27 +0100
Message-ID: <20150921232027.GD11284@x1>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-18-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442850433-5903-18-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, 21 Sep 2015, Sudeep Holla wrote:

> The IRQF_NO_SUSPEND flag is used to identify the interrupts that shou=
ld
> be left enabled so as to allow them to work as expected during the
> suspend-resume cycle, but doesn't guarantee that it will wake the sys=
tem
> from a suspended state, enable_irq_wake is recommended to be used for
> the wakeup.
>=20
> This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
> enable_irq_wake instead.
>=20
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/mfd/ab8500-core.c        | 11 +++++++++--
>  drivers/mfd/ab8500-debugfs.c     |  2 +-
>  drivers/mfd/ab8500-gpadc.c       | 15 +++++++++++----
>  drivers/mfd/db8500-prcmu.c       | 24 +++++++++++++++++-------
>  drivers/power/ab8500_btemp.c     |  6 ++++--
>  drivers/power/ab8500_charger.c   |  6 ++++--
>  drivers/power/ab8500_fg.c        |  9 ++++++---
>  drivers/thermal/db8500_thermal.c |  5 ++---
>  drivers/usb/phy/phy-ab8500-usb.c | 10 ++++++----
>  9 files changed, 60 insertions(+), 28 deletions(-)

Is there a reason for bundling the changes in all of these subsystems
together into a single patch?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
