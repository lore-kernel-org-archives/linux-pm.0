From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: thermal: Remove Eduardo's git tree
Date: Thu, 26 Oct 2017 09:59:19 -0700
Message-ID: <44d01b56-191e-d955-3be8-f413d18b5597@gmail.com>
References: <20170924211843.11451-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:56097 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbdJZQ7Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Oct 2017 12:59:24 -0400
In-Reply-To: <20170924211843.11451-1-f.fainelli@gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: code@mmayer.net, mmayer@broadcom.com, rui.zhang@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, open list <linux-kernel@vger.kernel.org>

On 09/24/2017 02:18 PM, Florian Fainelli wrote:
> Eduardo's git tree at:
> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
> 
> has not been updated in months, remove it to avoid any confusing and
> patch submissions to stall.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> This is agains Rui's next branch

The very fact that this patch has not received any response is a clear
indication that there is something seriously wrong with the SoC thermal
drivers maintenance.

Eduardo, if you can't even be bothered to respond to emails and
Ack/Nack, then remove yourself so you can set clear expectations with
people attempting to get their drivers upstreamed.

> 
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 209306019483..cc5bc8d0b48e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13210,7 +13210,6 @@ M:	Zhang Rui <rui.zhang@intel.com>
>  M:	Eduardo Valentin <edubezval@gmail.com>
>  L:	linux-pm@vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
>  Q:	https://patchwork.kernel.org/project/linux-pm/list/
>  S:	Supported
>  F:	drivers/thermal/
> 


-- 
Florian
