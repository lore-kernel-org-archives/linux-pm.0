From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 07/11] drivers: thermal: Hide PCI driver when
 CONFIG_PCI is unset
Date: Sun, 23 Dec 2018 22:48:11 +0100
Message-ID: <CAJZ5v0j6Z42pk16fFGpQz+xvU-gVnarkoafcWJuQPWY=X532YQ@mail.gmail.com>
References: <20181222090720.19234-1-okaya@kernel.org> <20181222090720.19234-8-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222090720.19234-8-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, sumeet.r.pawnikar@intel.com, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 22, 2018 at 6:49 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> This driver is both a platform and PCI driver. Hide PCI specific pieces
> when CONFIG_PCI is unset.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  .../intel/int340x_thermal/processor_thermal_device.c      | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 284cf2c5a8fd..b84a475a1162 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -374,6 +374,7 @@ static int int3401_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_PCI
>  static irqreturn_t proc_thermal_pci_msi_irq(int irq, void *devid)
>  {
>         struct proc_thermal_device *proc_priv;
> @@ -482,6 +483,7 @@ static struct pci_driver proc_thermal_pci_driver = {
>         .remove         = proc_thermal_pci_remove,
>         .id_table       = proc_thermal_pci_ids,
>  };
> +#endif
>
>  static const struct acpi_device_id int3401_device_ids[] = {
>         {"INT3401", 0},
> @@ -505,16 +507,18 @@ static int __init proc_thermal_init(void)
>         ret = platform_driver_register(&int3401_driver);
>         if (ret)
>                 return ret;
> -
> +#ifdef CONFIG_PCI
>         ret = pci_register_driver(&proc_thermal_pci_driver);
> -
> +#endif
>         return ret;
>  }
>
>  static void __exit proc_thermal_exit(void)
>  {
>         platform_driver_unregister(&int3401_driver);
> +#ifdef CONFIG_PCI
>         pci_unregister_driver(&proc_thermal_pci_driver);
> +#endif
>  }
>
>  module_init(proc_thermal_init);

Can you actually test this driver with your new #ifdef stuff and with
CONFIG_PCI unset?

Have you really test it in that configuration?

If not, you shouldn't even post this patch.

Please make the driver depend on PCI.
