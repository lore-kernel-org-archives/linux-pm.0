From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 17/17] mfd : ab8500/db8500: fix the abuse of
 IRQF_NO_SUSPEND
Date: Tue, 22 Sep 2015 22:03:22 +0100
Message-ID: <20150922210322.GA3442@x1>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-18-git-send-email-sudeep.holla@arm.com>
 <20150921232027.GD11284@x1>
 <560127BE.9030604@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34045 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758949AbbIVVD3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 17:03:29 -0400
Received: by padhy16 with SMTP id hy16so19488521pad.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2015 14:03:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <560127BE.9030604@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 22 Sep 2015, Sudeep Holla wrote:
> On 22/09/15 00:20, Lee Jones wrote:
> >On Mon, 21 Sep 2015, Sudeep Holla wrote:
> >
> >>The IRQF_NO_SUSPEND flag is used to identify the interrupts that sh=
ould
> >>be left enabled so as to allow them to work as expected during the
> >>suspend-resume cycle, but doesn't guarantee that it will wake the s=
ystem
> >>from a suspended state, enable_irq_wake is recommended to be used f=
or
> >>the wakeup.
> >>
> >>This patch removes the use of IRQF_NO_SUSPEND flags replacing it wi=
th
> >>enable_irq_wake instead.
> >>
> >>Cc: Linus Walleij <linus.walleij@linaro.org>
> >>Cc: linux-arm-kernel@lists.infradead.org
> >>Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >>---
> >>  drivers/mfd/ab8500-core.c        | 11 +++++++++--
> >>  drivers/mfd/ab8500-debugfs.c     |  2 +-
> >>  drivers/mfd/ab8500-gpadc.c       | 15 +++++++++++----
> >>  drivers/mfd/db8500-prcmu.c       | 24 +++++++++++++++++-------
> >>  drivers/power/ab8500_btemp.c     |  6 ++++--
> >>  drivers/power/ab8500_charger.c   |  6 ++++--
> >>  drivers/power/ab8500_fg.c        |  9 ++++++---
> >>  drivers/thermal/db8500_thermal.c |  5 ++---
> >>  drivers/usb/phy/phy-ab8500-usb.c | 10 ++++++----
> >>  9 files changed, 60 insertions(+), 28 deletions(-)
> >
> >Is there a reason for bundling the changes in all of these subsystem=
s
> >together into a single patch?
> >
>=20
> No, I understand this needs to be split. Since I was not 100% confide=
nt
> about this change, I wanted LinusW to review and provide feedback and
> gets things working before I can split this changes. I must have adde=
d
> RFC, but usually it gets ignored :)

Best if Linus reviews the correct patch-set.  Please split and
resubmit.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
