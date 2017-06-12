From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/8] PM / domains: Protect reading loop over list of
 domains
Date: Mon, 12 Jun 2017 15:10:00 +0200
Message-ID: <20170612131000.GA22241@kozik-book>
References: <20170609160853.31789-1-krzk@kernel.org>
 <20170609160853.31789-3-krzk@kernel.org>
 <20170609161649.g5wjn24tm2opyq3h@kozik-lap>
 <CAPDyKFosxZCVfSHiv5Q2zbkX+PGbGXuxr88rK1eggQO1UXPM0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33902 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbdFLNKE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 09:10:04 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFosxZCVfSHiv5Q2zbkX+PGbGXuxr88rK1eggQO1UXPM0g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 12, 2017 at 02:57:21PM +0200, Ulf Hansson wrote:
> On 9 June 2017 at 18:16, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Fri, Jun 09, 2017 at 06:08:47PM +0200, Krzysztof Kozlowski wrote:
> >> The pm_genpd_present() iterates over list of domains so grabbing a
> >> gpd_list_lock mutex is necessary before calling it.  Otherwise we could
> >> end up in iterating over and modifying the list at the same time.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >> ---
> >>  drivers/base/power/domain.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> >> index 2e8d0f423507..2a6935dc0164 100644
> >> --- a/drivers/base/power/domain.c
> >> +++ b/drivers/base/power/domain.c
> >> @@ -1099,8 +1099,13 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
> >>       struct generic_pm_domain *genpd;
> >>
> >>       genpd = dev_to_genpd(dev);
> 
> Actually there may be potential problem here as we may end up trying
> to use the container_of() call for a PM domain, not being a genpd but
> something else.
> 
> >> -     if (!pm_genpd_present(genpd))
> >> +
> >> +     mutex_lock(&gpd_list_lock);
> >> +     if (!pm_genpd_present(genpd)) {
> >> +             mutex_unlock(&gpd_list_lock);
> >>               return;
> >> +     }
> >> +     mutex_unlock(&gpd_list_lock);
> 
> Perhaps convert the hole thing above to call genpd_lookup_dev() instead?

Indeed, that would solve both problems. Thanks, I'll fix this.

Best regards,
Krzysztof
