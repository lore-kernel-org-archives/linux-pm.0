From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] OPP: Export opp_add()
Date: Mon, 05 Aug 2013 14:47:11 +0200
Message-ID: <1449166.3f8s044BNa@vostro.rjw.lan>
References: <58acb4a8a4e98089078de3ed71999730b6d97b4b.1375521724.git.viresh.kumar@linaro.org> <51FF9A95.2030307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51FF9A95.2030307@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, pavel@ucw.cz, linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, August 05, 2013 07:29:09 AM Nishanth Menon wrote:
> minor nitpick.
> $subject: PM / OPP:

Those are things I can easily fix up when I'm applying the patch.

> On 08/03/2013 04:25 AM, Viresh Kumar wrote:
> > Export opp_add() so that modules can use it.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >   drivers/base/power/opp.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> > index c8ec186..ef89897 100644
> > --- a/drivers/base/power/opp.c
> > +++ b/drivers/base/power/opp.c
> > @@ -460,6 +460,7 @@ int opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
> >   	srcu_notifier_call_chain(&dev_opp->head, OPP_EVENT_ADD, new_opp);
> >   	return 0;
> >   }
> > +EXPORT_SYMBOL_GPL(opp_add);
> >
> >   /**
> >    * opp_set_availability() - helper to set the availability of an opp
> >
> other than that,
> Acked-by: Nishanth Menon <nm@ti.com>
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
