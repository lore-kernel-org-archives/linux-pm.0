From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH v2 2/3] PM / sleep: Mark suspend/hibernation start and
 finish
Date: Thu, 20 Jul 2017 10:49:50 -0700
Message-ID: <364d0454-a446-51c4-f9c5-15bc6670928a@android.com>
References: <2539550.y54cRb749c@aspire.rjw.lan>
 <1528829.lXeqX43PVF@aspire.rjw.lan> <21457958.U8q3irAeUz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34035 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753701AbdGTRtw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 13:49:52 -0400
Received: by mail-pg0-f52.google.com with SMTP id 123so17835025pgj.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Jul 2017 10:49:52 -0700 (PDT)
In-Reply-To: <21457958.U8q3irAeUz@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

On 07/19/2017 06:38 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Regardless of whether or not debug messages from the core system
> suspend/hibernation code are enabled, it is useful to know when
> system-wide transitions start and finish (or fail), so print "info"
> messages at these points.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> -> v2: Smiplified the messages as suggested by Mark.
>
> ---
>   kernel/power/hibernate.c |    5 +++++
>   kernel/power/suspend.c   |    2 ++
>   2 files changed, 7 insertions(+)
>
> Index: linux-pm/kernel/power/hibernate.c
> ===================================================================
> --- linux-pm.orig/kernel/power/hibernate.c
> +++ linux-pm/kernel/power/hibernate.c
> @@ -692,6 +692,7 @@ int hibernate(void)
>   		goto Unlock;
>   	}
>   
> +	pr_info("hibernation entry\n");
nit (minor): Many of the logs report a PM: prefix. Flipping coin that 
the 3 characters provides any real gain is in your hands. My WAG is it 
would be nice to be able to do dmesg | grep PM:

Ack
