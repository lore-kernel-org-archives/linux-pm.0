From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH RESEND] cpupower: Fix no-rounding MHz frequency output
Date: Mon, 23 Oct 2017 21:35:39 +0900
Message-ID: <20171023123539.GF2694@lianli.shorne-pla.net>
References: <20171023115632.27998-1-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:52646 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932194AbdJWMfm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2017 08:35:42 -0400
Received: by mail-pg0-f67.google.com with SMTP id a192so11652545pge.9
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2017 05:35:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171023115632.27998-1-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>

On Mon, Oct 23, 2017 at 07:56:32AM -0400, Prarit Bhargava wrote:
> Sent about a year ago ...
> 
> P.
> 
> ---8<---
> 
> 'cpupower frequency-info -ln' returns kHz values on systems with MHz range
> minimum CPU frequency range.  For example, on a 800MHz to 4.20GHz system
> the command returns
> 
> hardware limits: 800000 MHz - 4.200000 GHz
> 
> The value of speed passed into print_speed is in kHz, so divide speed by
> 1000 in the MHz else-if section to get MHz.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Thomas Renninger <trenn@suse.com>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Shuah Khan <shuah@kernel.org>
> ---
>  tools/power/cpupower/utils/cpufreq-info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
> index 3e701f0e9c14..fe7c25147b3a 100644
> --- a/tools/power/cpupower/utils/cpufreq-info.c
> +++ b/tools/power/cpupower/utils/cpufreq-info.c
> @@ -94,7 +94,7 @@ static void print_speed(unsigned long speed)
>  			printf("%u.%06u GHz", ((unsigned int) speed/1000000),
>  				((unsigned int) speed%1000000));
>  		else if (speed > 100000)
> -			printf("%u MHz", (unsigned int) speed);
> +			printf("%u MHz", (unsigned int) speed/1000);

This looks ok to me, but can't we just remove this condition and depend on the
condition with the decimal point below?

-Stafford

>  		else if (speed > 1000)
>  			printf("%u.%03u MHz", ((unsigned int) speed/1000),
>  				(unsigned int) (speed%1000));
> -- 
> 2.15.0.rc0.39.g2f0e14e64
> 
