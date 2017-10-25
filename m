From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH v2] cpupower: Fix no-rounding MHz frequency output
Date: Thu, 26 Oct 2017 07:01:56 +0900
Message-ID: <20171025220156.GH2694@lianli.shorne-pla.net>
References: <20171025135132.16324-1-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:54634 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752041AbdJYWCB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2017 18:02:01 -0400
Received: by mail-pg0-f67.google.com with SMTP id l24so1029461pgu.11
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2017 15:02:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171025135132.16324-1-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>

On Wed, Oct 25, 2017 at 09:51:32AM -0400, Prarit Bhargava wrote:
> 'cpupower frequency-info -ln' returns kHz values on systems with MHz range
> minimum CPU frequency range.  For example, on a 800MHz to 4.20GHz system
> the command returns
> 
> hardware limits: 800000 MHz - 4.200000 GHz
> 
> The code that causes this error can be removed.  The next else if clause
> will handle the output correctly such that
> 
> hardware limits: 800.000 MHz - 4.200000 GHz
> 
> is displayed correctly.
> 
> [v2]: Remove two lines instead of fixing broken code.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Thomas Renninger <trenn@suse.com>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Shuah Khan <shuah@kernel.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>

> ---
>  tools/power/cpupower/utils/cpufreq-info.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
> index 3e701f0e9c14..df43cd45d810 100644
> --- a/tools/power/cpupower/utils/cpufreq-info.c
> +++ b/tools/power/cpupower/utils/cpufreq-info.c
> @@ -93,8 +93,6 @@ static void print_speed(unsigned long speed)
>  		if (speed > 1000000)
>  			printf("%u.%06u GHz", ((unsigned int) speed/1000000),
>  				((unsigned int) speed%1000000));
> -		else if (speed > 100000)
> -			printf("%u MHz", (unsigned int) speed);
>  		else if (speed > 1000)
>  			printf("%u.%03u MHz", ((unsigned int) speed/1000),
>  				(unsigned int) (speed%1000));
> -- 
> 2.15.0.rc0.39.g2f0e14e64
> 
