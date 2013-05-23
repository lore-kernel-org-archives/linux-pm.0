From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/4] Thermal: armada: Remove redundant use of of_match_ptr
Date: Thu, 23 May 2013 17:10:03 +0530
Message-ID: <CAK9yfHyBcuGyYSfEwb+H8Na3OeS5O7iZgKth3-dO7d7oQh+i7g@mail.gmail.com>
References: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:38145 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758176Ab3EWLkE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2013 07:40:04 -0400
Received: by mail-ob0-f178.google.com with SMTP id v19so3752816obq.37
        for <linux-pm@vger.kernel.org>; Thu, 23 May 2013 04:40:03 -0700 (PDT)
In-Reply-To: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, sachin.kamat@linaro.org

On 16 May 2013 15:58, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> 'armada_thermal_id_table' is always compiled in and the driver
> is dependent on OF. Hence use of of_match_ptr is unnecessary.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/thermal/armada_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 0d02d4e..9426bbd 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -220,7 +220,7 @@ static struct platform_driver armada_thermal_driver = {
>         .driver = {
>                 .name = "armada_thermal",
>                 .owner = THIS_MODULE,
> -               .of_match_table = of_match_ptr(armada_thermal_id_table),
> +               .of_match_table = armada_thermal_id_table,
>         },
>  };
>
> --
> 1.7.9.5
>


Ping.. Any comments on this series?

-- 
With warm regards,
Sachin
