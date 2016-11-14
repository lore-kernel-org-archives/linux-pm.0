From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq/CPPC: Add MODULE_DEVICE_TABLE for cppc_cpufreq driver
Date: Mon, 14 Nov 2016 01:21:25 +0100
Message-ID: <3532123.n0qt8sN7td@vostro.rjw.lan>
References: <1476468023-6917-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55896 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750815AbcKNANx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 19:13:53 -0500
In-Reply-To: <1476468023-6917-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: linux-pm@vger.kernel.org, Hoan Tran <hotran@apm.com>, Christopher Covington <cov@codeaurora.org>, Al Stone <ahs3@redhat.com>

On Friday, October 14, 2016 12:00:23 PM Prashanth Prakash wrote:
> MODULE_DEVICE_TABLE is added so that CPPC cpufreq module can be
> automatically loaded when we have a acpi processor device with
> "ACPI0007" hid.
> 
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 4852d9e..e82bb3c 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -247,3 +247,10 @@ MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
>  MODULE_LICENSE("GPL");
>  
>  late_initcall(cppc_cpufreq_init);
> +
> +static const struct acpi_device_id cppc_acpi_ids[] = {
> +	{ACPI_PROCESSOR_DEVICE_HID, },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, cppc_acpi_ids);

Applied.

Thanks,
Rafael

