From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / Domains: defer dev_pm_domain_set() until genpd->attach_dev succeeds if present
Date: Mon, 17 Jul 2017 13:36:43 +0200
Message-ID: <3522476.ddL1JZVOUh@aspire.rjw.lan>
References: <1498759251-11709-1-git-send-email-sudeep.holla@arm.com> <CAPDyKFqJf+stWC4FAbXAxXgZgCXxc3KOPyG3YS008EWmH6vAcw@mail.gmail.com> <0f5d2da1-0390-c02f-e03b-df07aa40a52f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48578 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751279AbdGQLob (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2017 07:44:31 -0400
In-Reply-To: <0f5d2da1-0390-c02f-e03b-df07aa40a52f@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, "# v4 . 0+" <stable@vger.kernel.org>

On Monday, July 17, 2017 11:34:57 AM Sudeep Holla wrote:
> 
> On 17/07/17 08:01, Ulf Hansson wrote:
> > On 14 July 2017 at 12:51, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >> If the genpd->attach_dev or genpd->power_on fails, genpd_dev_pm_attach
> >> may return -EPROBE_DEFER initially. However genpd_alloc_dev_data sets
> >> the PM domain for the device unconditionally.
> >>
> >> When subsequent attempts are made to call genpd_dev_pm_attach, it may
> >> return -EEXISTS checking dev->pm_domain without re-attempting to call
> >> attach_dev or power_on.
> >>
> >> platform_drv_probe then attempts to call drv->probe as the return value
> >> -EEXIST != -EPROBE_DEFER, which may end up in a situation where the
> >> device is accessed without it's power domain switched on.
> >>
> >> Fixes: f104e1e5ef57 ("PM / Domains: Re-order initialization of generic_pm_domain_data")
> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> Cc: Kevin Hilman <khilman@kernel.org>
> >> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >> Cc: <stable@vger.kernel.org> # v4.0+
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> > 
> >> ---
> >>  drivers/base/power/domain.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> Hi,
> >>
> >> I have added Cc/Fixes tags based on the original commit that caused the issue.
> >> I need to workout a patch that can cleanly apply before commit 989561de9b51
> >> ("PM / Domains: add setter for dev.pm_domain"), i.e. for v4.0.x to v4.4.x
> >> This patch should apply from v4.5.x onwards.
> > 
> > Thanks for checking this.
> > 
> > Perhaps we should change the stable tag to # v4.5+ instead then?
> > Otherwise the stable people will just report problems when trying to
> > apply it.
> > 
> 
> Yes, I know. I thought then I can work out the solution for whatever
> version they need. Instead of trying to post patch for all versions from
> v4.0 to v4.4
> If that's not acceptable, then yes it should be #4.5+
> Rafael, can you just update that if required ?

I can.

> I am fine to work a patch for v4.[0-4].x when requested.

That depends on how much of a problem this can be for the users of those
kernels, but I guess 4.4 is used by Android, so maybe it's worth the effort.

Thanks,
Rafael
