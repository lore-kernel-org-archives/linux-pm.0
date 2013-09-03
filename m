From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 02/27] gpiolib-acpi: convert acpi_evaluate_object() to
 acpi_execute_simple_method()
Date: Tue, 03 Sep 2013 10:42:57 +0300
Message-ID: <52259301.30403@linux.intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com> <1378168335-22556-3-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33404 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932300Ab3ICHiT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 3 Sep 2013 03:38:19 -0400
In-Reply-To: <1378168335-22556-3-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>

On 09/03/2013 03:31 AM, Zhang Rui wrote:
> acpi_execute_simple_method() is a new ACPI API introduced to invoke
> an ACPI control method that has single integer parameter and no return value.
>
> Convert acpi_evaluate_object() to acpi_execute_simple_method()
> in drivers/gpio/gpiolib-acpi.c
>
> Signed-off-by: Zhang Rui<rui.zhang@intel.com>
> CC: Mathias Nyman<mathias.nyman@linux.intel.com>
> CC: Mika Westerberg<mika.westerberg@linux.intel.com>
> CC: Linus Walleij<linus.walleij@linaro.org>
> ---
>   drivers/gpio/gpiolib-acpi.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 5c1ef2b..f2beb72 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -73,15 +73,8 @@ static irqreturn_t acpi_gpio_irq_handler(int irq, void *data)
>   static irqreturn_t acpi_gpio_irq_handler_evt(int irq, void *data)
>   {
>   	struct acpi_gpio_evt_pin *evt_pin = data;
> -	struct acpi_object_list args;
> -	union acpi_object arg;
>
> -	arg.type = ACPI_TYPE_INTEGER;
> -	arg.integer.value = evt_pin->pin;
> -	args.count = 1;
> -	args.pointer =&arg;
> -
> -	acpi_evaluate_object(evt_pin->evt_handle, NULL,&args, NULL);
> +	acpi_execute_simple_method(evt_pin->evt_handle, NULL, evt_pin->pin);
>
>   	return IRQ_HANDLED;
>   }


Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
