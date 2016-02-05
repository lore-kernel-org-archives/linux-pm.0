From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC] Add cpufreq support
Date: Fri, 05 Feb 2016 23:24:35 +0100
Message-ID: <3308645.nrPBoahQ2V@wuerfel>
References: <56B4D4BE.2040008@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:55240 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbcBEWZD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 17:25:03 -0500
In-Reply-To: <56B4D4BE.2040008@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mason <slash.tmp@free.fr>, linux-pm <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On Friday 05 February 2016 17:58:38 Mason wrote:
> I'm throwing this out there to ask:
> Is this the right way to enable cpufreq on my platform?
> ---

> @@ -23,6 +24,11 @@ static void tango_l2c_write(unsigned long val, unsigned int reg)
>  		tango_set_l2_control(val);
>  }
>  
> +static void __init tango_init_late(void)
> +{
> +	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> +}
> +
>  static const char *const tango_dt_compat[] = { "sigma,tango4", NULL };
>  
>  DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
> @@ -30,4 +36,5 @@ DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
>  	.l2c_aux_mask	= ~0,
>  	.l2c_write_sec	= tango_l2c_write,
>  	.map_io		= tango_map_io,
> +	.init_late	= tango_init_late,
>  MACHINE_END
> 

We no longer call platform_device_register_simple() from platform code, at least
for new platforms, and we should probably remove the code from the existing
platforms that still do it. I forget what the replacement was, but I'm not
going to take this version. Viresh should be able to help you do it the right
way.

	Arnd
