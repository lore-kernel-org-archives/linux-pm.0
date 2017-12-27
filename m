From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 20/45] drivers: thermal: remove duplicate includes
Date: Wed, 27 Dec 2017 10:09:34 +0800
Message-ID: <1514340574.2755.5.camel@intel.com>
References: <1512578405-4904-1-git-send-email-pravin.shedge4linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512578405-4904-1-git-send-email-pravin.shedge4linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pravin Shedge <pravin.shedge4linux@gmail.com>, linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2017-12-06 at 22:10 +0530, Pravin Shedge wrote:
> These duplicate includes have been found with
> scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.
> 
> Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>

applied.

thanks,
rui
> ---
>  drivers/thermal/of-thermal.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-
> thermal.c
> index d04ec3b..e09f035 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -30,7 +30,6 @@
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/string.h>
> -#include <linux/thermal.h>
>  
>  #include "thermal_core.h"
>  
