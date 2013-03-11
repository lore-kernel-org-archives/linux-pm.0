From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] PM/domains: add delayed power off capability
Date: Mon, 11 Mar 2013 11:47:18 -0600
Message-ID: <513E18A6.1050101@wwwdotorg.org>
References: <1363017028-16164-1-git-send-email-mkulkarni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363017028-16164-1-git-send-email-mkulkarni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mayuresh Kulkarni <mkulkarni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 03/11/2013 09:50 AM, Mayuresh Kulkarni wrote:
> - this commit adds a capability to delay the powering off
> of the domain
> - callers can use pm_genpd_set_poweroff_delay to set the
> power off delay for a domain
> - it expects the delay in milli-seconds
> - it also adds a pm_notifier per pm domain which cancels
> the delayed power off work when system suspend is invoked

You didn't Cc any of the maintainers of this code. I'm not sure what
this patch directly has to do with Tegra.

> [swarren@swarren-lx1 kernel.git]$ ./scripts/get_maintainer.pl -f drivers/base/power
> Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (supporter:SUSPEND TO RAM)
> Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> (supporter:SUSPEND TO RAM)
> "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org> (supporter:SUSPEND TO RAM)
> Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> (supporter:DRIVER CORE, KOBJ...)
> linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SUSPEND TO RAM)
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
