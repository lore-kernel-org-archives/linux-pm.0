From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] drivers: cpuidle: Fix checkpatch error and warnings
Date: Fri, 8 Sep 2017 01:18:49 +0200
Message-ID: <CAJZ5v0jUcC7e3R_fRrPuKCaCmi3ZQwKWBJTmC7zN09QaErQXrw@mail.gmail.com>
References: <20170907102325.GA6427@kernel> <1504780406.7546.19.camel@perches.com>
 <20170907124010.GB6427@kernel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36951 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbdIGXSu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2017 19:18:50 -0400
In-Reply-To: <20170907124010.GB6427@kernel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gaurav jindal <gauravjindal1104@gmail.com>
Cc: Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Todd Poynor <toddpoynor@google.com>

On Thu, Sep 7, 2017 at 2:40 PM, gaurav jindal
<gauravjindal1104@gmail.com> wrote:
> this patch fixes the below checkpatch errors and warnings in
> drivers/cpuidle/cpuidle.c
>
> WARNING: line over 80 characters
> #311: FILE: drivers/cpuidle/cpuidle.c:311:
> +               /* Make sure all changes finished before we switch to new idle */
>
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> #343: FILE: drivers/cpuidle/cpuidle.c:343:
> +EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);
>
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> #354: FILE: drivers/cpuidle/cpuidle.c:354:
> +EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
>
> ERROR: do not use assignment in if condition
> #402: FILE: drivers/cpuidle/cpuidle.c:402:
> +       if (cpuidle_curr_governor->enable &&
>
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> #419: FILE: drivers/cpuidle/cpuidle.c:419:
> +EXPORT_SYMBOL_GPL(cpuidle_enable_device);
>
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> #447: FILE: drivers/cpuidle/cpuidle.c:447:
> +EXPORT_SYMBOL_GPL(cpuidle_disable_device);
>
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> #537: FILE: drivers/cpuidle/cpuidle.c:537:
> +EXPORT_SYMBOL_GPL(cpuidle_register_device);
>
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> #561: FILE: drivers/cpuidle/cpuidle.c:561:
> +EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
>
> Signed-off-by:gaurav jindal<gauravjindal1104@gmail.com>
>
> ---
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 60bb64f..a42148e 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -308,7 +308,10 @@ void cpuidle_reflect(struct cpuidle_device *dev, int index)
>  void cpuidle_install_idle_handler(void)
>  {
>         if (enabled_devices) {
> -               /* Make sure all changes finished before we switch to new idle */
> +               /*
> +                * Make sure all changes finished before we switch to
> +                * new idle
> +                */
>                 smp_wmb();
>                 initialized = 1;
>         }

Don't do this.

The rest is fine by me.
