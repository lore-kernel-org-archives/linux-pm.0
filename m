From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] PM / OPP: Fix NULL pointer dereference crash when
 setting the OPP
Date: Mon, 15 Feb 2016 21:55:57 +0530
Message-ID: <20160215162557.GC6334@vireshk-i7>
References: <1455189959-27944-1-git-send-email-jonathanh@nvidia.com>
 <1455544758-7718-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455544758-7718-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 15-02-16, 13:59, Jon Hunter wrote:
> Commit 6a0712f6f199 ("PM / OPP: Add dev_pm_opp_set_rate()") causes a
> crash on Tegra124 Jetson TK1 when using the DFLL clock source for the
> CPU.  The DFLL manages the voltage itself and so there is no regulator
> specified for the OPPs and so we get a crash when we try to dereference
> the regulator pointer.  Fix this by checking to see if the regulator
> IS_ERR_OR_NULL before dereferencing it.
> 
> Fixes: 6a0712f6f199 ("PM / OPP: Add dev_pm_opp_set_rate()")
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> 
> I am not sure why I did not catch this instance of the bug last week
> when I submitted the patch to fix the NULL pointer dereference in
> _opp_supported_by_regulators(). May be I forgot to go back and test
> on HEAD after bisecting? Anyway, both this fix and the one from last
> week are necessary to get the kernel booting again on Tegra124 Jetson
> TK1.

I want to fix it a bit differently, will send out in a different mail
to make it easy for Rafael to apply it.

-- 
viresh
