From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Sleep: Set pm_generic functions to NULL for !CONFIG_PM_SLEEP
Date: Thu, 27 Feb 2014 09:29:31 +0100
Message-ID: <CAPDyKFrhyBZV6yUogxTQPdFPg=1R3UZ0Yr_VfXrTivMaNeGVEQ@mail.gmail.com>
References: <1392811761-28201-1-git-send-email-ulf.hansson@linaro.org>
	<20140219122715.GB32069@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35870 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaB0I3b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 03:29:31 -0500
Received: by mail-qc0-f174.google.com with SMTP id x13so2180750qcv.19
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2014 00:29:31 -0800 (PST)
In-Reply-To: <20140219122715.GB32069@amd.pavel.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>

On 19 February 2014 13:27, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2014-02-19 13:09:21, Ulf Hansson wrote:
>> Previously only a subset of the functions were defined and set to NULL
>> while !CONFIG_PM_SLEEP. Let's make them all available so they can be
>> used no matter of CONFIG_PM_SLEEP or not.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Reviewed-by: Pavel Machek <pavel@ucw.cz>
>

Hi Rafael,

If you have no concern with this one, I would appreciate if it could
go in for 3.15.

I have some patches for the amba bus (driver/amba/bus.c) that would
require these pointers to be available.

Kind regards
Uffe

> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
