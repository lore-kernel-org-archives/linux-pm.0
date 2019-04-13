From: andrew-sh.cheng <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH v2 2/4] opp: add API which get max freq by voltage
Date: Sat, 13 Apr 2019 12:39:14 +0800
Message-ID: <1555130354.14109.5.camel@mtksdaap41>
References: <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1553841972-19737-3-git-send-email-andrew-sh.cheng@mediatek.com>
 <CANMq1KB6x77F9Vo_wXK-M1Qt0Mo9VP3MfgKBAON18cHMts_kwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CANMq1KB6x77F9Vo_wXK-M1Qt0Mo9VP3MfgKBAON18cHMts_kwg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, Fan Chen <fan.chen@mediatek.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2019-04-03 at 12:32 +0800, Nicolas Boichat wrote:
> On Fri, Mar 29, 2019 at 2:46 PM Andrew-sh.Cheng
> <andrew-sh.cheng@mediatek.com> wrote:
> >
> > This API will get voltage as input parameter.
> > Search all opp items for the item which with max frequency,
> > and the voltae is smaller than provided voltage.
> >
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > ---
> >  drivers/opp/core.c     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_opp.h |  8 ++++++++
> >  2 files changed, 63 insertions(+)
> >
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 0420f7e..7323cd9 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -526,6 +526,61 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
> >
> > +/**
> > + * dev_pm_opp_find_max_freq_by_volt() - Search for a opp with max freq
> > + * under provided voltage
> > + * @dev:       device for which we do this operation
> > + * @u_volt:    provided voltage
> > + *
> > + * Search for the matching available OPP which provide voltage can support.
> > + *
> > + * Return: matching *opp, else returns ERR_PTR in case of error
> > + * and should be handled using IS_ERR.
> > + * Error return values can be:
> > + * EINVAL:     for bad pointer
> > + * ERANGE:     no match found for search
> > + * ENODEV:     if device not found in list of registered devices
> > + *
> > + * The callers are required to call dev_pm_opp_put() for the returned OPP after
> > + * use.
> > + */
> > +struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
> > +                                             unsigned long u_volt)
> > +{
> > +       struct opp_table *opp_table;
> > +       struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
> > +
> > +       if (!dev || !u_volt) {
> > +               dev_err(dev, "%s: Invalid argument volt=%d\n", __func__,
> > +                       u_volt);
> 
> u_volt is an unsigned long, so you should use %lu.
> 
> drivers/opp/core.c:582:3: error: format '%d' expects argument of type
> 'int', but argument 4 has type 'long unsigned int' [-Werror=format=]
>   chromeos-kernel-4_19-4.19.32-r271:    dev_err(dev, "%s: Invalid
> argument volt=%d\n", __func__,
>   chromeos-kernel-4_19-4.19.32-r271:    ^
> 
Got it. I will fix this on next patch
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       opp_table = _find_opp_table(dev);
> > +       if (IS_ERR(opp_table))
> > +               return ERR_CAST(opp_table);
> > +
> > +       mutex_lock(&opp_table->lock);
> > +
> > +       list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
> > +               if (temp_opp->available) {
> > +                       /* go to the next node, before choosing prev */
> > +                       if (temp_opp->supplies[0].u_volt > u_volt)
> > +                               break;
> > +                       opp = temp_opp;
> > +               }
> > +       }
> > +
> > +       /* Increment the reference count of OPP */
> > +       if (!IS_ERR(opp))
> > +               dev_pm_opp_get(opp);
> > +       mutex_unlock(&opp_table->lock);
> > +       dev_pm_opp_put_opp_table(opp_table);
> > +
> > +       return opp;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_pm_opp_find_max_freq_by_volt);
> > +
> >  static int _set_opp_voltage(struct device *dev, struct regulator *reg,
> >                             struct dev_pm_opp_supply *supply)
> >  {
> > diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> > index 24c757a..57deef9 100644
> > --- a/include/linux/pm_opp.h
> > +++ b/include/linux/pm_opp.h
> > @@ -102,6 +102,8 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
> >
> >  struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
> >                                               unsigned long *freq);
> > +struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
> > +                                             unsigned long u_volt);
> >
> >  struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
> >                                              unsigned long *freq);
> > @@ -207,6 +209,12 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
> >         return ERR_PTR(-ENOTSUPP);
> >  }
> >
> > +static inline struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
> > +                                             unsigned long u_volt)
> > +{
> > +       return ERR_PTR(-ENOTSUPP);
> > +}
> > +
> >  static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
> >                                         unsigned long *freq)
> >  {
> > --
> > 1.8.1.1.dirty
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
