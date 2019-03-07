From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH 1/6] PM / Domains: Improve warn for multiple states but no
 governor in genpd
Date: Thu, 7 Mar 2019 13:57:04 +0000
Message-ID: <AM0PR04MB421133ACBFB25A3394FA607D804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1551878302-8146-1-git-send-email-aisheng.dong@nxp.com>
 <1551878302-8146-2-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFqPwF4k3x+yBxMRsR_ahz_+0pwaXxT2csRWEQ_d9Uu8dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFqPwF4k3x+yBxMRsR_ahz_+0pwaXxT2csRWEQ_d9Uu8dg@mail.gmail.com>
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
> Sent: Wednesday, March 6, 2019 10:17 PM
> On Wed, 6 Mar 2019 at 14:25, Aisheng Dong <aisheng.dong@nxp.com>
> wrote:
> >
> > It's possible a PM domain defines only one state and it does not need
> > a governor to work. For such case, a warning actually is not necessary.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Fixes: 2c9b7f877203 ("PM / Domains: Deal with multiple states but no
> governor in genpd")
> Cc: stable@vger.kernel.org
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 

One question, this patch applies for current situation, but when we add two states
support with no governor (see my another patch series to support enter
deepest state for suspend but intermediate state for runtime pm), 
here will still warn.

Do you think if we should totally remove this warning or keep this patch
but change to use another simple governor later for multi states?
e.g. fixed intermediate state for runtime pm?

Regards
Dong Aisheng

> > ---
> >  drivers/base/power/domain.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 2c334c0..394f9da 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1766,7 +1766,7 @@ int pm_genpd_init(struct generic_pm_domain
> *genpd,
> >                 ret = genpd_set_default_power_state(genpd);
> >                 if (ret)
> >                         return ret;
> > -       } else if (!gov) {
> > +       } else if (!gov && genpd->state_count > 1) {
> >                 pr_warn("%s : no governor for states\n", genpd->name);
> >         }
> >
> > --
> > 2.7.4
> >
