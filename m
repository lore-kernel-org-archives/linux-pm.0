From: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] PM/domains: add delayed power off capability
Date: Tue, 12 Mar 2013 16:29:07 +0200
Message-ID: <20130312142907.GM27241@tbergstrom-lnx.Nvidia.com>
References: <1363017028-16164-1-git-send-email-mkulkarni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1363017028-16164-1-git-send-email-mkulkarni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mayuresh Kulkarni <mkulkarni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 11, 2013 at 04:50:28PM +0100, Mayuresh Kulkarni wrote:
> - this commit adds a capability to delay the powering off
> of the domain
> - callers can use pm_genpd_set_poweroff_delay to set the
> power off delay for a domain
> - it expects the delay in milli-seconds
> - it also adds a pm_notifier per pm domain which cancels
> the delayed power off work when system suspend is invoked

This is meant as a RFC patch. Some powerdomains (eg. GPU domains) can be
controlled quite well using this strategy. The question is how to implement
this. The current governor scheme is ill suited for this because the governor
is only called when genpd wants to shutdown a domain. So the governor seems
to be mostly there to impose extra constraints beyond 'all devices are off'
and the predicted idle time is long enough to reach energy breakeven.

Thanks,

Peter.
