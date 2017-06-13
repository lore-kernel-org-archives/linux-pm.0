From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 3/8] PM / Domains: Add lockdep asserts for domains
 list mutex
Date: Tue, 13 Jun 2017 09:12:18 +0200
Message-ID: <20170613071218.bbml7vsfcdgpirlp@kozik-lap>
References: <20170612151748.7380-1-krzk@kernel.org>
 <20170612151748.7380-4-krzk@kernel.org>
 <CAPDyKFr=-Ty9ZQ276nmkAPnJjwc3PmuKSdJrOqeEYcxbgfypYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35724 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbdFMHMW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 03:12:22 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFr=-Ty9ZQ276nmkAPnJjwc3PmuKSdJrOqeEYcxbgfypYA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 12, 2017 at 09:09:59PM +0200, Ulf Hansson wrote:
> On 12 June 2017 at 17:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Add lockdep checks for holding mutex protecting the list of domains.
> > This might expose misuse even though only file-scope functions use it
> > for now.
> 
> I think it seems a bit silly to use these lockdep checks as these
> functions are as you state above, static functions. Moreover there are
> called from a quite limited amount of places.
> 
> Do you really think this add some value?

In ideal world, these would not need lockdeps because we do not make
mistakes. I agree, that mostly the exposed functions to other kernel
modules should be protected, as lockdep annotation is a more advanced
way of documenting the need of locking.

Does it mean that file-scope functions should not be annotated? Even in
such case function can be misused as the code is getting more and more
complicated.

What is best example, one of these calls (pm_genpd_present()) was
already used in wrong way, without locking when iterating over the list.
Having lockdep would point this early.

Best regards,
Krzysztof


> 
> Kind regards
> Uffe
> 
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  drivers/base/power/domain.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 983f086ab235..9d3d3c2a5979 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -726,6 +726,8 @@ static bool pm_genpd_present(const struct generic_pm_domain *genpd)
> >  {
> >         const struct generic_pm_domain *gpd;
> >
> > +       lockdep_assert_held(&gpd_list_lock);
> > +
> >         if (IS_ERR_OR_NULL(genpd))
> >                 return false;
> >
> > @@ -1321,6 +1323,8 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
> >         struct gpd_link *link, *itr;
> >         int ret = 0;
> >
> > +       lockdep_assert_held(&gpd_list_lock);
> > +
> >         if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain)
> >             || genpd == subdomain)
> >                 return -EINVAL;
> > @@ -1528,6 +1532,8 @@ static int genpd_remove(struct generic_pm_domain *genpd)
> >  {
> >         struct gpd_link *l, *link;
> >
> > +       lockdep_assert_held(&gpd_list_lock);
> > +
> >         if (IS_ERR_OR_NULL(genpd))
> >                 return -EINVAL;
> >
> > --
> > 2.9.3
> >
