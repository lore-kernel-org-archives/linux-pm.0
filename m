From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] ACPI/Sleep: Add init_nvs_nosave_s3() function
Date: Mon, 28 Jan 2013 13:21:53 +0100
Message-ID: <1473081.Cm0g80OnKE@vostro.rjw.lan>
References: <1359359225-28223-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:57705 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757181Ab3A1MPp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Jan 2013 07:15:45 -0500
In-Reply-To: <1359359225-28223-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: stern@rowland.harvard.edu, swilmet@gnome.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday, January 28, 2013 03:47:04 PM Lan Tianyu wrote:
> commit 1bad2f19f7f7 introduces nvs_nosave_s3 flag to just ban
> saving nvs in ths s3 rather than both of s3 and s4. This patch
> is to add init_nvs_nosave_s3() to set nvs_nosave_s3 to true for
> those machines in the nonvs blacklist which only don't need to
> saving nvs during s3 rather than both s3 and s4.
> 
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Please fold [2/2] into [1/2] and resend.

Thanks,
Rafael


> ---
>  drivers/acpi/sleep.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 2fcc67d..405b962 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -141,6 +141,12 @@ static int __init init_nvs_nosave(const struct dmi_system_id *d)
>  	return 0;
>  }
>  
> +static int __init init_nvs_nosave_s3(const struct dmi_system_id *d)
> +{
> +	acpi_nvs_nosave_s3();
> +	return 0;
> +}
> +
>  static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
>  	{
>  	.callback = init_old_suspend_ordering,
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
