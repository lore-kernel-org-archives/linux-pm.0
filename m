From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: remove unnecessary unlikely()
Date: Wed, 01 May 2019 12:24:29 +0200
Message-ID: <4341173.rtllOHV0ML@kreacher>
References: <20190416162305.24375-1-tiny.windzz@gmail.com> <CAPDyKFpR6bwjUG_WtgvXJznBHcZBMOfTkj_Lb7aHPryvxC5mxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpR6bwjUG_WtgvXJznBHcZBMOfTkj_Lb7aHPryvxC5mxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 17, 2019 10:38:14 AM CEST Ulf Hansson wrote:
> On Tue, 16 Apr 2019 at 18:23, Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > WARN_ON() already contains an unlikely(), so it's not necessary to use
> > unlikely.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Kind regards
> Uffe
> 
> > ---
> >  drivers/base/power/domain.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 96a6dc9d305c..598a4e02aee1 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -391,11 +391,9 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
> >         if (unlikely(!genpd->set_performance_state))
> >                 return -EINVAL;
> >
> > -       if (unlikely(!dev->power.subsys_data ||
> > -                    !dev->power.subsys_data->domain_data)) {
> > -               WARN_ON(1);
> > +       if (WARN_ON(!dev->power.subsys_data ||
> > +                    !dev->power.subsys_data->domain_data))
> >                 return -EINVAL;
> > -       }
> >
> >         genpd_lock(genpd);
> >
> > --
> > 2.17.0
> >
> 

Patch applied, thanks!
