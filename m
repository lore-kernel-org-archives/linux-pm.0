From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Sleep: Set pm_generic functions to NULL for !CONFIG_PM_SLEEP
Date: Sun, 02 Mar 2014 00:59:25 +0100
Message-ID: <1517514.5FC3TgtPH4@vostro.rjw.lan>
References: <1392811761-28201-1-git-send-email-ulf.hansson@linaro.org> <20140219122715.GB32069@amd.pavel.ucw.cz> <CAPDyKFrhyBZV6yUogxTQPdFPg=1R3UZ0Yr_VfXrTivMaNeGVEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53360 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753318AbaCAXoU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Mar 2014 18:44:20 -0500
In-Reply-To: <CAPDyKFrhyBZV6yUogxTQPdFPg=1R3UZ0Yr_VfXrTivMaNeGVEQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>

On Thursday, February 27, 2014 09:29:31 AM Ulf Hansson wrote:
> On 19 February 2014 13:27, Pavel Machek <pavel@ucw.cz> wrote:
> > On Wed 2014-02-19 13:09:21, Ulf Hansson wrote:
> >> Previously only a subset of the functions were defined and set to NULL
> >> while !CONFIG_PM_SLEEP. Let's make them all available so they can be
> >> used no matter of CONFIG_PM_SLEEP or not.
> >>
> >> Cc: Russell King <linux@arm.linux.org.uk>
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Reviewed-by: Pavel Machek <pavel@ucw.cz>
> >
> 
> Hi Rafael,
> 
> If you have no concern with this one, I would appreciate if it could
> go in for 3.15.
> 
> I have some patches for the amba bus (driver/amba/bus.c) that would
> require these pointers to be available.

I've queued it up for 3.15, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
