From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] PM / OPP: Fix NULL pointer dereference crash when
 disabling OPPs
Date: Thu, 11 Feb 2016 17:04:09 +0530
Message-ID: <20160211113409.GA28558@vireshk>
References: <1455189959-27944-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455189959-27944-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 11-02-16, 11:25, Jon Hunter wrote:
> Commit 7d34d56ef334 ("PM / OPP: Disable OPPs that aren't supported by
> the regulator") disables OPPs that are not supported by the regulator.
> This is causes a crash on Tegra124 Jetson TK1 when using the DFLL clock
> source for the CPU. The DFLL manages the voltage itself and so there is
> no regulator specified for the OPPs and so we get a crash when we try to
> dereference the regulator pointer. Fix this by checking to see if the
> regulator IS_ERR_OR_NULL before dereferencing it.
> 
> Fixes: 7d34d56ef334 ("PM / OPP: Disable OPPs that aren't supported by the
> regulator")
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/base/power/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sorry about that :(

Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

-- 
viresh
