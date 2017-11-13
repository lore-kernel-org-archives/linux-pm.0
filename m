From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] mailbox/omap: unregister mbox class
Date: Mon, 13 Nov 2017 10:28:30 -0600
Message-ID: <fbb176b6-d479-a5b5-af47-34267d97a6dd@ti.com>
References: <014a4c5cd6008a42621d45f34d57b9e1a72d3c76.1510423634.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:56671 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753443AbdKMQ2c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Nov 2017 11:28:32 -0500
In-Reply-To: <014a4c5cd6008a42621d45f34d57b9e1a72d3c76.1510423634.git.arvind.yadav.cs@gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 11/11/2017 12:09 PM, Arvind Yadav wrote:
> platform_driver_register() can fail here and we must unregister mbox
> class.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>  drivers/mailbox/omap-mailbox.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
> index c5e8b9c..2517038 100644
> --- a/drivers/mailbox/omap-mailbox.c
> +++ b/drivers/mailbox/omap-mailbox.c
> @@ -906,7 +906,11 @@ static int __init omap_mbox_init(void)
>  	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size,
>  							sizeof(mbox_msg_t));
>  
> -	return platform_driver_register(&omap_mbox_driver);
> +	err = platform_driver_register(&omap_mbox_driver);
> +	if (err)
> +		class_unregister(&omap_mbox_class);
> +
> +	return err;
>  }
>  subsys_initcall(omap_mbox_init);
>  
> 
