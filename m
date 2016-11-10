From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] PM / sleep: don't suspend parent when async child
 suspend_{noirq,late} fails
Date: Thu, 10 Nov 2016 02:53:20 +0100
Message-ID: <CAJZ5v0j818ApkM+0aKDuaAKv6-GezuEGFLDd+UH16Kf6BUqWjg@mail.gmail.com>
References: <1477584334-39956-1-git-send-email-briannorris@chromium.org> <1478740868-55269-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34799 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754797AbcKJBxV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2016 20:53:21 -0500
In-Reply-To: <1478740868-55269-1-git-send-email-briannorris@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Linux PM <linux-pm@vger.kernel.org>, Chuansheng Liu <chuansheng.liu@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, Nov 10, 2016 at 2:21 AM, Brian Norris <briannorris@chromium.org> wrote:
> Consider two devices, A and B, where B is a child of A, and B utilizes
> asynchronous suspend (it does not matter whether A is sync or async). If
> B fails to suspend_noirq() or suspend_late(), or is interrupted by a
> wakeup (pm_wakeup_pending()), then it aborts and sets the async_error
> variable. However, device A does not (immediately) check the async_error
> variable; it may continue to run its own suspend_noirq()/suspend_late()
> callback. This is bad.
>
> We can resolve this problem by doing our error and wakeup checking
> (particularly, for the async_error flag) after waiting for children to
> suspend, instead of before. This also helps align the logic for the noirq and
> late suspend cases with the logic in __device_suspend().
>
> It's easy to observe this erroneous behavior by, for example, forcing a
> device to sleep a bit in its suspend_noirq() (to ensure the parent is
> waiting for the child to complete), then return an error, and watch the
> parent suspend_noirq() still get called. (Or similarly, fake a wakeup
> event at the right (or is it wrong?) time.)
>
> Fixes: de377b397272 ("PM / sleep: Asynchronous threads for suspend_late")
> Fixes: 28b6fd6e3779 ("PM / sleep: Asynchronous threads for suspend_noirq")
> Reported-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v2: s/early/late/ in commit message
>
> v3:
>  * drop patch 1, as the callback-printing is unrelated, semi-controversial, and
>    might break existing (but poor -- c'mon, since when do tools get to rely on
>    kernel messages?) tools
>  * do all error checking after dpm_wait_for_children() -- this helps make
>    things consistent and reduces duplication.
>  * drop Dmitry's Reviewed-by, since the patch changed enough
>
>  drivers/base/power/main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index c58563581345..57a8ca4bc8ab 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1027,6 +1027,8 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
>         TRACE_DEVICE(dev);
>         TRACE_SUSPEND(0);
>
> +       dpm_wait_for_children(dev, async);
> +

On a second thought. I'd move the

if (dev->power.syscore || dev->power.direct_complete)

along with this (and put it in front), because those flags won't
change while children are being waited on anyway.

>         if (async_error)
>                 goto Complete;
>
> @@ -1038,8 +1040,6 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
>         if (dev->power.syscore || dev->power.direct_complete)
>                 goto Complete;
>
> -       dpm_wait_for_children(dev, async);
> -
>         if (dev->pm_domain) {
>                 info = "noirq power domain ";
>                 callback = pm_noirq_op(&dev->pm_domain->ops, state);
> @@ -1174,6 +1174,8 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
>
>         __pm_runtime_disable(dev, false);
>
> +       dpm_wait_for_children(dev, async);
> +

And analogously here.

>         if (async_error)
>                 goto Complete;
>
> @@ -1185,8 +1187,6 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
>         if (dev->power.syscore || dev->power.direct_complete)
>                 goto Complete;
>
> -       dpm_wait_for_children(dev, async);
> -
>         if (dev->pm_domain) {
>                 info = "late power domain ";
>                 callback = pm_late_early_op(&dev->pm_domain->ops, state);

Thanks,
Rafael
