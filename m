From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Use synchronous runtime PM call in rpm_put_suppliers()
Date: Wed, 22 Mar 2017 12:34:04 +0100
Message-ID: <CAPDyKFq+mTvruQb5ifj3etMxSCWgDZTZ6ebGkk84UCQDqjR4-A@mail.gmail.com>
References: <CGME20170322092305eucas1p20d2a6dfede483210febea5b5e0ff68db@eucas1p2.samsung.com>
 <1490174570-18345-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33162 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbdCVLeG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 07:34:06 -0400
Received: by mail-vk0-f44.google.com with SMTP id d188so121795526vka.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2017 04:34:05 -0700 (PDT)
In-Reply-To: <1490174570-18345-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 22 March 2017 at 10:22, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> rpm_put_suppliers() might be called as a result of pm_runtime_put_sync()
> call, where the called explicitly wants to perform the operation in
> synchronous way to avoid some deadlocks related to concurrent code
> execution in the PM workers. However the current code for handling device
> links always use asynchronous calls. This patch changes it to always use
> the synchronous calls.

This is a good idea! It is better to leave the decision to the "leaf"
node of whether to use asynchronous mode or not.

>
> This patch fixes the potential deadlock, which appears during adding
> runtime PM support to clock framework, which uses global mutex, which is
> reentrant only for the current process, so trying to execute runtime PM
> callback from the worker results in deadlock (the mentioned mutex is
> already taken by the current process, which waits for execution of PM
> worker).

This just tells that the locking mechanism for clocks are fragile.
Whether it is a good motivation for this change, I am not sure.

In either case, I like the change!

Kind regards
Uffe

>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Hi Rafael & Ulf,
>
> This was the simplest way of fixing this issue. Other way would be to
> propagate rpmflags to rpm_get/put_suppliers() to ensure that synchronous
> calls will be also done on the linked devices. Which way is better in
> your opinion?
>
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
> ---
>  drivers/base/power/runtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 7bcf80fa9ada..b7df589ae579 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -292,7 +292,7 @@ static void rpm_put_suppliers(struct device *dev)
>         list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
>                 if (link->rpm_active &&
>                     READ_ONCE(link->status) != DL_STATE_SUPPLIER_UNBIND) {
> -                       pm_runtime_put(link->supplier);
> +                       pm_runtime_put_sync(link->supplier);
>                         link->rpm_active = false;
>                 }
>  }
> --
> 1.9.1
>
