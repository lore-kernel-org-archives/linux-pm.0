From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] power: qos: no need to check return value of
 debugfs_create functions
Date: Tue, 22 Jan 2019 16:30:38 +0100
Message-ID: <CAJZ5v0jLeZfsmX12g6r0zXCt9dTjD0TnJ03+Sntt6i2f-PxsGw@mail.gmail.com>
References: <20190122152151.16139-48-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122152151.16139-48-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 22, 2019 at 4:25 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

All of these changes are fine by me and I can take the patches
touching the code maintained by me, so please let me know.

> ---
>  kernel/power/qos.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index b7a82502857a..9d22131afc1e 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -582,10 +582,8 @@ static int register_pm_qos_misc(struct pm_qos_object *qos, struct dentry *d)
>         qos->pm_qos_power_miscdev.name = qos->name;
>         qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
>
> -       if (d) {
> -               (void)debugfs_create_file(qos->name, S_IRUGO, d,
> -                                         (void *)qos, &pm_qos_debug_fops);
> -       }
> +       debugfs_create_file(qos->name, S_IRUGO, d, (void *)qos,
> +                           &pm_qos_debug_fops);
>
>         return misc_register(&qos->pm_qos_power_miscdev);
>  }
> @@ -685,8 +683,6 @@ static int __init pm_qos_power_init(void)
>         BUILD_BUG_ON(ARRAY_SIZE(pm_qos_array) != PM_QOS_NUM_CLASSES);
>
>         d = debugfs_create_dir("pm_qos", NULL);
> -       if (IS_ERR_OR_NULL(d))
> -               d = NULL;
>
>         for (i = PM_QOS_CPU_DMA_LATENCY; i < PM_QOS_NUM_CLASSES; i++) {
>                 ret = register_pm_qos_misc(pm_qos_array[i], d);
> --
> 2.20.1
>
