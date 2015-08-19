From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: cpu_cooling: Add MAINTAINERS entry
Date: Wed, 19 Aug 2015 10:44:46 -0700
Message-ID: <20150819174444.GA6643@localhost.localdomain>
References: <298acc438cba5f64121d883db7ff2b860c0a9610.1439967508.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33968 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbbHSRot (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 13:44:49 -0400
Received: by paccq16 with SMTP id cq16so7762580pac.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2015 10:44:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <298acc438cba5f64121d883db7ff2b860c0a9610.1439967508.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, amit.daniel@samsung.com, linux-pm@vger.kernel.org, rui.zhang@intel.com

On Wed, Aug 19, 2015 at 12:30:40PM +0530, Viresh Kumar wrote:
> None of the patches are reaching Viresh or Daniel directly as
> get_maintainers doesn't report us as maintainers. Looks like file header
> or history of commits isn't able to do that properly.

Interesting. I would expect that by this point, you would be already
listed.. anyways..

> 
> Add a separate entry for cpu_cooling driver in MAINTAINERS.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Apart from the minors below, you can add my:

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
> Please let me know if someone has objections to this.
> 
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d8ab5c06c4f..c85081f08516 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10298,6 +10298,14 @@ F:	include/uapi/linux/thermal.h
>  F:	include/linux/cpu_cooling.h
>  F:	Documentation/devicetree/bindings/thermal/
>  
> +THERMAL/CPU_COOLING
> +M:	Amit Daniel Kachhap <amit.daniel@samsung.com>

Is this still a valid email? I remember one of his email was bouncing
back. 

> +M:	Viresh Kumar <viresh.kumar@linaro.org>
> +L:	linux-pm@vger.kernel.org
> +S:	Supported
> +F:	drivers/thermal/cpu_cooling.c
> +F:	include/linux/cpu_cooling.h
> +

Please add:
+F: Documentation/thermal/cpu-cooling-api.txt 


>  THINGM BLINK(1) USB RGB LED DRIVER
>  M:	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
>  S:	Maintained
> -- 
> 2.4.0
> 
