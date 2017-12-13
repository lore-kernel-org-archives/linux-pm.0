From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] powercap: Remove reassignment
Date: Wed, 13 Dec 2017 02:03:14 +0100
Message-ID: <1535899.2uxoW1GXQ1@aspire.rjw.lan>
References: <00329a239c8b1640a9e491b6a90a5b20fd45e42c.1510422357.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63131 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752868AbdLMBD4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Dec 2017 20:03:56 -0500
In-Reply-To: <00329a239c8b1640a9e491b6a90a5b20fd45e42c.1510422357.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Saturday, November 11, 2017 6:47:26 PM CET Arvind Yadav wrote:
> It is not necessary to reassignment of 'result'.
> Here, result is being initialized zero and then updated with
> seed_constraint_attributes().
> class_register is enough to return successful and error value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/powercap/powercap_sys.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> index 5b10b50..64b2b25 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -673,15 +673,13 @@ EXPORT_SYMBOL_GPL(powercap_unregister_control_type);
>  
>  static int __init powercap_init(void)
>  {
> -	int result = 0;
> +	int result;
>  
>  	result = seed_constraint_attributes();
>  	if (result)
>  		return result;
>  
> -	result = class_register(&powercap_class);
> -
> -	return result;
> +	return class_register(&powercap_class);
>  }
>  
>  device_initcall(powercap_init);
> 

Applied, thanks!
