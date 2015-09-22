From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/17] input: tegra-kbc: drop use of IRQF_NO_SUSPEND flag
Date: Tue, 22 Sep 2015 22:08:16 +0100
Message-ID: <20150922210632.GB3442@x1>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-8-git-send-email-sudeep.holla@arm.com>
 <20150921232132.GE11284@x1>
 <CAKdAkRRWWxwWREiBiBcqBwBcZ6q0GHDgR1pyKfBXw=trP3cX_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34054 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbbIVVIX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 17:08:23 -0400
Received: by padhy16 with SMTP id hy16so19588238pad.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2015 14:08:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKdAkRRWWxwWREiBiBcqBwBcZ6q0GHDgR1pyKfBXw=trP3cX_A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Samuel Ortiz <sameo@linux.intel.com>

On Mon, 21 Sep 2015, Dmitry Torokhov wrote:

> On Mon, Sep 21, 2015 at 4:21 PM, Lee Jones <lee.jones@linaro.org> wro=
te:
> > The $SUBJECT is not correct.
> >
> >> The driver handles wakeup irq correctly using irq_set_irq_wake. Th=
ere's
> >> no need to use IRQF_NO_SUSPEND while registering the interrupt.
> >>
> >> This patch removes the use of IRQF_NO_SUSPEND flag.
> >>
> >> Cc: Samuel Ortiz <sameo@linux.intel.com>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >> ---
> >>  drivers/mfd/qcom_rpm.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > ... code is fine though:
> >
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> >
> > Please re-submit with the subject line fixed.
>=20
> What's wrong with the subject?

This patch has nothing to do with Input and the first word of the
explanatory sentence should start with an uppercase character.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
