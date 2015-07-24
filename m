From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH] PM / Domains: Return -EPROBE_DEFER if we fail to init or turn-on domain
Date: Fri, 24 Jul 2015 22:04:54 +0200
Message-ID: <13712803.ErFak1Toxn@vostro.rjw.lan>
References: <1434649967-21135-1-git-send-email-jonathanh@nvidia.com> <55A3B7E0.8040401@nvidia.com> <55B239C6.2010003@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59901 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753632AbbGXTiE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2015 15:38:04 -0400
In-Reply-To: <55B239C6.2010003@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Friday, July 24, 2015 02:12:38 PM Jon Hunter wrote:
> 
> On 13/07/15 14:06, Jon Hunter wrote:
> > 
> > On 24/06/15 11:18, Ulf Hansson wrote:
> >> On 18 June 2015 at 19:52, Jon Hunter <jonathanh@nvidia.com> wrote:
> >>> When a device is probed, the function dev_pm_domain_attach() is called
> >>> to see if there is a power-domain that is associated with the device and
> >>> needs to be turned on. If dev_pm_domain_attach() does not return
> >>> -EPROBE_DEFER then the device will be probed.
> >>>
> >>> For devices using genpd, dev_pm_domain_attach() will call
> >>> genpd_dev_pm_attach(). If genpd_dev_pm_attach() does not find a power
> >>> domain associated with the device then it returns an error code not
> >>> equal to -EPROBE_DEFER to allow the device to be probed. However, if
> >>> genpd_dev_pm_attach() does find a power-domain that is associated with
> >>> the device, then it does not return -EPROBE_DEFER on failure and hence
> >>> the device will still be probed. Furthermore, genpd_dev_pm_attach() does
> >>> not check the error code returned by pm_genpd_poweron() to see if the
> >>> power-domain was turned on successfully.
> >>>
> >>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >>
> >> This is a clear improvement for genpd and as a short-term solution I
> >> am fine with this!
> >>
> >> The long term solution should be to implement the
> >> pm_domain->activate|dismiss() callbacks, but that requires a bigger
> >> effort.
> >>
> >> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> > 
> > Thanks Ulf.
> > 
> > Kevin, Rafael, are you ok with this?
> 
> I have still not heard back about this.
> 
> Ulf, not sure if you can help here.

Well, if you want me to pick up a patch, please don't send it as an RFC.

Can you please resend it with the Ulf's ACK?

Thanks,
Rafael

