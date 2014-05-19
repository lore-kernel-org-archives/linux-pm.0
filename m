From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] cpufreq: nforce2: remove DEFINE_PCI_DEVICE_TABLE macro
Date: Tue, 20 May 2014 01:17:59 +0200
Message-ID: <2176895.ku4R6OVGpm@vostro.rjw.lan>
References: <000501cf6b4d$1941cbf0$4bc563d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63628 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751275AbaESXBF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 May 2014 19:01:05 -0400
In-Reply-To: <000501cf6b4d$1941cbf0$4bc563d0$%han@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

On Friday, May 09, 2014 03:08:29 PM Jingoo Han wrote:
> Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
> is deprecated.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 3.16, thanks!

> ---
> Changes since v1:
> - Added Viresh Kumar's Acked-by.
> - Modified commit message to change from 'not preferred' to 'deprecated'. 
> 
>  drivers/cpufreq/cpufreq-nforce2.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
> index bc447b9..a225809 100644
> --- a/drivers/cpufreq/cpufreq-nforce2.c
> +++ b/drivers/cpufreq/cpufreq-nforce2.c
> @@ -379,7 +379,7 @@ static struct cpufreq_driver nforce2_driver = {
>  };
>  
>  #ifdef MODULE
> -static DEFINE_PCI_DEVICE_TABLE(nforce2_ids) = {
> +static const struct pci_device_id nforce2_ids[] = {
>  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2 },
>  	{}
>  };
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
