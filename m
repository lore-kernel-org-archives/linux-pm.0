From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / core: Fix kerneldoc comments of three functions
Date: Fri, 13 Oct 2017 08:48:30 +0200
Message-ID: <CAPDyKFoi_UGJzk9nWR6V5PgecvdVVSBzg8EQBLF6aMUXVFj_ug@mail.gmail.com>
References: <1805031.1a2Ur49QVy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:54118 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbdJMGsb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2017 02:48:31 -0400
Received: by mail-it0-f45.google.com with SMTP id n195so9509885itg.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2017 23:48:31 -0700 (PDT)
In-Reply-To: <1805031.1a2Ur49QVy@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>

On 13 October 2017 at 02:33, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Fix kerneldoc comments of __device_suspend_noirq(),
> __device_suspend_late() and __device_suspend() where the function
> names in kerneldoc don't match the actual names of the functions.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1077,7 +1077,7 @@ static pm_message_t resume_event(pm_mess
>  }
>
>  /**
> - * device_suspend_noirq - Execute a "late suspend" callback for given device.
> + * __device_suspend_noirq - Execute a "late suspend" callback for given device.

While at it, I suggest to also change "late suspend" to "noirq suspend".

As a matter of fact I found the similar text to be wrong also for
device_resume_noirq(), perhaps that should be fixed as well.

[...]

Kind regards
Uffe
