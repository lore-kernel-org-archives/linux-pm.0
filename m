From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 08/17] hwmon: abx500: drop the use of IRQF_NO_SUSPEND
Date: Wed, 23 Sep 2015 08:32:57 -0700
Message-ID: <5602C629.3080109@roeck-us.net>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-9-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41168 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbbIWPdD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2015 11:33:03 -0400
In-Reply-To: <1442850433-5903-9-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org

On 09/21/2015 08:47 AM, Sudeep Holla wrote:
> The description in the driver states: "ABX500 does not provide auto ADC,
> so to monitor the required temperatures, a periodic work is used. It is
> more important to not wake up the CPU... If the chip gets too hot during
> a sleep state it's most likely due to external factors, such as the
> surrounding temperature and nothing can be done in S/W."
>
> So it makes no sense to keep IRQs enabled as it need not be wakeup
> source. This patch removes the use of IRQF_NO_SUSPEND flag
>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: lm-sensors@lm-sensors.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>   drivers/hwmon/abx500.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/abx500.c b/drivers/hwmon/abx500.c
> index 6cb89c0ebab6..dcab258f60c1 100644
> --- a/drivers/hwmon/abx500.c
> +++ b/drivers/hwmon/abx500.c
> @@ -377,7 +377,7 @@ static int setup_irqs(struct platform_device *pdev)
>   	}
>
>   	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> -		abx500_temp_irq_handler, IRQF_NO_SUSPEND, "abx500-temp", pdev);
> +		abx500_temp_irq_handler, 0, "abx500-temp", pdev);
>   	if (ret < 0)
>   		dev_err(&pdev->dev, "Request threaded irq failed (%d)\n", ret);
>
>

