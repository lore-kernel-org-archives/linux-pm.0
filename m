From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] dd: Invoke one probe retry cycle after some initcall levels
Date: Sun, 9 Sep 2018 22:22:35 +0200
Message-ID: <CAJZ5v0hEFGCu8xv6MvwmVvspOwLveD4sPzU-=ewKfbrV9omzBw@mail.gmail.com>
References: <1534181989-22536-1-git-send-email-rishabhb@quicinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534181989-22536-1-git-send-email-rishabhb@quicinc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rishabhb@quicinc.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sodagudi Prasad <psodagud@codeaurora.org>, ckadabi@codeaurora.org, tsoni@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>, Rishabh Bhatnagar <rishabhb@codeaurora.org>, Vikram Mulukutla <markivx@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 13, 2018 at 7:40 PM Rishabh Bhatnagar <rishabhb@quicinc.com> wrote:
>
> From: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>
> Drivers that are registered at an initcall level may have to
> wait until late_init before the probe deferral mechanism can
> retry their probe functions. It is possible that their
> dependencies were resolved much earlier, in some cases even
> before the next initcall level. Invoke one probe retry cycle
> at every _sync initcall level after subsys initcall, allowing
> these drivers to be probed earlier.
> To give an example many Qualcomm drivers are dependent on the
> regulator and bus driver. Both the regulator and bus driver
> are probed in the subsys_initcall level. Now the probe of bus
> driver requires regulator to be working. If the probe of bus
> driver happens before regulator, then bus driver's probe will
> be deferred and all other device's probes which depend on bus
> driver will also be deferred.
> The impact of this problem is reduced if we have this patch.
>
> Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>
> Changes since v0:
>  * Remove arch_initcall_sync(deferred_probe_initcall) from patch. This is not
>    really needed as none of the devices are re-probed in arch_initcall_sync
>    level.
>
>  drivers/base/dd.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 1435d72..9aa41aa 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -224,23 +224,43 @@ void device_unblock_probing(void)
>         driver_deferred_probe_trigger();
>  }
>
> +static void enable_trigger_defer_cycle(void)
> +{
> +       driver_deferred_probe_enable = true;

Isn't it sufficient to enable it once?

> +       driver_deferred_probe_trigger();
> +       /*
> +        * Sort as many dependencies as possible before the next initcall
> +        * level
> +        */
> +       flush_work(&deferred_probe_work);
> +}

I would call this function driver_deferred_probe_sync() or similar to
indicate that it is a synchronization point.

Thanks,
Rafael
