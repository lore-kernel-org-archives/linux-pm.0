From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 07/11] drivers: thermal: int3406_thermal: Make PCI
 dependency explicit
Date: Mon, 7 Jan 2019 12:19:51 +0100
Message-ID: <CAJZ5v0gst1ZDgG-uP9GUUB1ziPnqhfArio3um=wCQjfbeH2_iw@mail.gmail.com>
References: <20190105100606.6673-1-okaya@kernel.org> <20190105100606.6673-8-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105100606.6673-8-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. Need CONFIG_PCI to be set in order to be able to use
> this driver.
>
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/thermal/intel/int340x_thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
> index 0582bd12a239..fba1976d5f8d 100644
> --- a/drivers/thermal/intel/int340x_thermal/Kconfig
> +++ b/drivers/thermal/intel/int340x_thermal/Kconfig
> @@ -31,7 +31,7 @@ if INT340X_THERMAL
>
>  config INT3406_THERMAL
>         tristate "ACPI INT3406 display thermal driver"
> -       depends on ACPI_VIDEO
> +       depends on ACPI_VIDEO && PCI
>         help
>           The display thermal device represents the LED/LCD display panel
>           that may or may not include touch support. The main function of
> --

Rui, any objections here?  And for the [11/11]?
