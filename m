From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 250/493] cpufreq: remove use of __devinit
Date: Wed, 21 Nov 2012 01:50:41 +0100
Message-ID: <3141036.vn6puQec9S@vostro.rjw.lan>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu> <1353349642-3677-250-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:56817 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752806Ab2KUAqR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 20 Nov 2012 19:46:17 -0500
In-Reply-To: <1353349642-3677-250-git-send-email-wfp5p@virginia.edu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On Monday, November 19, 2012 01:23:19 PM Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.

Applied to the linux-next branch of the linux-pm.git tree as v3.8 material.

Thanks,
Rafael


> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl> 
> Cc: cpufreq@vger.kernel.org 
> Cc: linux-pm@vger.kernel.org 
> ---
>  drivers/cpufreq/cpufreq-cpu0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index e915827..52bf36d 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -174,7 +174,7 @@ static struct cpufreq_driver cpu0_cpufreq_driver = {
>  	.attr = cpu0_cpufreq_attr,
>  };
>  
> -static int __devinit cpu0_cpufreq_driver_init(void)
> +static int cpu0_cpufreq_driver_init(void)
>  {
>  	struct device_node *np;
>  	int ret;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
