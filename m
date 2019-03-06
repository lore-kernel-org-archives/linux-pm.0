From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH 4/6] PM / Domains: Move the Subdomain check into
 _genpd_power_off
Date: Wed, 6 Mar 2019 14:47:27 +0000
Message-ID: <AM0PR04MB4211C463AB49AB7D0FC805A780730@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1551878302-8146-1-git-send-email-aisheng.dong@nxp.com>
 <1551878302-8146-5-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFpptBCgkY=e6tK22eM9syAE3c1TJ6PNLst6FOF0AM4HRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpptBCgkY=e6tK22eM9syAE3c1TJ6PNLst6FOF0AM4HRw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Wednesday, March 6, 2019 10:27 PM
> On Wed, 6 Mar 2019 at 14:25, Aisheng Dong <aisheng.dong@nxp.com>
> wrote:
> >
> > Move the Subdomain check into _genpd_power_off, then the caller does
> > not have to check it each time. This also ensures a double check of
> > &genpd->sd_count before really power off domain in case it's increased
> > asynchronously by subdomains. This is the same behavior as the
> > original genpd_power_off() does.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Please squash this with patch 3, as to avoid an intermediate change in
> behavior.
> 
> Otherwise both patch 3 and patch4 looks good to me.
> 

Thanks, I will take this as a reviewed-by tag.
And will resend with patch3&4 squashed later.

Regards
Dong Aisheng

> Kind regards
> Uffe
> 
> > ---
> >  drivers/base/power/domain.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 591f37f..61cd500 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -452,6 +452,9 @@ static int _genpd_power_off(struct
> generic_pm_domain *genpd, bool timed)
> >         if (!genpd->power_off)
> >                 return 0;
> >
> > +       if (atomic_read(&genpd->sd_count) > 0)
> > +               return -EBUSY;
> > +
> >         if (!timed)
> >                 return genpd->power_off(genpd);
> >
> > @@ -547,9 +550,6 @@ static int genpd_power_off(struct
> generic_pm_domain *genpd, bool one_dev_on,
> >         if (!genpd->gov)
> >                 genpd->state_idx = 0;
> >
> > -       if (atomic_read(&genpd->sd_count) > 0)
> > -               return -EBUSY;
> > -
> >         /*
> >          * If sd_count > 0 at this point, one of the subdomains hasn't
> >          * managed to call genpd_power_on() for the master yet after
> > @@ -962,8 +962,7 @@ static void genpd_sync_power_off(struct
> generic_pm_domain *genpd, bool use_lock,
> >         if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
> >                 return;
> >
> > -       if (genpd->suspended_count != genpd->device_count
> > -           || atomic_read(&genpd->sd_count) > 0)
> > +       if (genpd->suspended_count != genpd->device_count)
> >                 return;
> >
> >         /* Choose the deepest state when suspending */
> > --
> > 2.7.4
> >
