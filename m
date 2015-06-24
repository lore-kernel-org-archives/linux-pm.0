From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / hibernate: re-enable nonboot cpus on disable_nonboot_cpus() failure
Date: Thu, 25 Jun 2015 00:15:36 +0200
Message-ID: <6366580.JOe80DM3WH@vostro.rjw.lan>
References: <1435154526-9023-1-git-send-email-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54532 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750933AbbFXVt2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2015 17:49:28 -0400
In-Reply-To: <1435154526-9023-1-git-send-email-vkuznets@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>

On Wednesday, June 24, 2015 04:02:06 PM Vitaly Kuznetsov wrote:
> When disable_nonboot_cpus() fails on some cpu it doesn't bring back all
> cpus it managed to offline, a consequent call to enable_nonboot_cpus() is
> expected. In hibernation_platform_enter() we don't call
> enable_nonboot_cpus() on error so cpus stay offlined.
> 
> create_image() and resume_target_kernel() functions handle
> disable_nonboot_cpus() faults correctly, hibernation_platform_enter()
> is the only one which is doing it wrong.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Applied, thanks!

> ---
>  kernel/power/hibernate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 2329daa..690f78f 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -552,7 +552,7 @@ int hibernation_platform_enter(void)
>  
>  	error = disable_nonboot_cpus();
>  	if (error)
> -		goto Platform_finish;
> +		goto Enable_cpus;
>  
>  	local_irq_disable();
>  	syscore_suspend();
> @@ -568,6 +568,8 @@ int hibernation_platform_enter(void)
>   Power_up:
>  	syscore_resume();
>  	local_irq_enable();
> +
> + Enable_cpus:
>  	enable_nonboot_cpus();
>  
>   Platform_finish:
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
