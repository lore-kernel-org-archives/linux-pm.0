From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v10 2/8] power: add power sequence library
Date: Fri, 2 Dec 2016 14:51:54 +0800
Message-ID: <20161202065154.GA23234@b29397-desktop>
References: <1479087359-7547-1-git-send-email-peter.chen@nxp.com>
 <1479087359-7547-3-git-send-email-peter.chen@nxp.com>
 <CAJZ5v0i-_pHS+N-k7QVuc_0StT+BaFB+2fuHJpCfngtQV5z76w@mail.gmail.com>
 <20161122035324.GA7497@b29397-desktop>
 <CAJZ5v0g9rrJ-pLk4bF9XO_0BndGcduncPU0Tamm2m0UvN9X08A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g9rrJ-pLk4bF9XO_0BndGcduncPU0Tamm2m0UvN9X08A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Chen <peter.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <stephen.boyd@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>, Joshua Clayton <stillcompiling@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, mka@chromium.org, Alan Stern <stern@rowland.harvard.edu>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, mail@maciej.szmigiero.name, Pawel Moll <pawel.moll@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, troy.kisky@boundarydevices.com, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infrade>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 01, 2016 at 10:57:24PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 22, 2016 at 4:53 AM, Peter Chen <hzpeterchen@gmail.com> wrote:
> > On Tue, Nov 22, 2016 at 03:23:12AM +0100, Rafael J. Wysocki wrote:
> >> > @@ -0,0 +1,237 @@
> >> > +/*
> >> > + * core.c      power sequence core file
> >> > + *
> >> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> >> > + * Author: Peter Chen <peter.chen@nxp.com>
> >> > + *
> >> > + * This program is free software: you can redistribute it and/or modify
> >> > + * it under the terms of the GNU General Public License version 2  of
> >> > + * the License as published by the Free Software Foundation.
> >> > + *
> >> > + * This program is distributed in the hope that it will be useful,
> >> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> > + * GNU General Public License for more details.
> >> > + *
> >> > + * You should have received a copy of the GNU General Public License
> >> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> >>
> >> The last paragraph is not necessary AFAICS.
> >
> > I just copy it from:
> >
> > https://www.gnu.org/licenses/gpl-howto.en.html
> >
> > If you are concerns about it, I can delete it.
> 
> It is redundant, so yes, please.

ok.

> 
> >> > +
> >> > +static struct pwrseq *pwrseq_find_available_instance(struct device_node *np)
> >> > +{
> >> > +       struct pwrseq *pwrseq;
> >> > +
> >> > +       list_for_each_entry(pwrseq, &pwrseq_list, node) {
> >> > +               if (pwrseq->used)
> >> > +                       continue;
> >> > +
> >> > +               /* compare compatible string for pwrseq node */
> >> > +               if (of_match_node(pwrseq->pwrseq_of_match_table, np)) {
> >> > +                       pwrseq->used = true;
> >> > +                       return pwrseq;
> >> > +               }
> >> > +
> >> > +               /* return generic pwrseq instance */
> >> > +               if (!strcmp(pwrseq->pwrseq_of_match_table->compatible,
> >> > +                               "generic")) {
> >> > +                       pr_debug("using generic pwrseq instance for %s\n",
> >> > +                               np->full_name);
> >> > +                       pwrseq->used = true;
> >> > +                       return pwrseq;
> >> > +               }
> >> > +       }
> >> > +       pr_warn("Can't find any pwrseq instances for %s\n", np->full_name);
> >>
> >> pr_debug() ?
> >
> > If there is no pwrseq instance for that node, the power sequence on routine will
> > return fail, so I think an warning message is useful for user.
> 
> Useful in what way?  How is the user supposed to know what happened
> from this message?

Ok, I will change it to debug message.

> >> > + */
> >> > +struct pwrseq *of_pwrseq_on(struct device_node *np)
> >> > +{
> >> > +       struct pwrseq *pwrseq;
> >> > +       int ret;
> >> > +
> >> > +       pwrseq = pwrseq_find_available_instance(np);
> >>
> >> What does guarantee the integrity of ths list at this point?
> >
> > Once the use selects the specific pwrseq library, the library will
> > create an empty one instance during the initialization, and it
> > will be called at postcore_initcall, the device driver has not
> > probed yet.
> 
> Which doesn't matter really, because the list is global and some other
> driver using it might have been probed already.
> 
> You have a mutex here and it is used for add/remove.  Why isn't it
> used for list browsing?

I will add mutex for it, thanks.

> >
> >> > + */
> >> > +int of_pwrseq_on_list(struct device_node *np, struct list_head *head)
> >> > +{
> >> > +       struct pwrseq *pwrseq;
> >> > +       struct pwrseq_list_per_dev *pwrseq_list_node;
> >> > +
> >> > +       pwrseq = of_pwrseq_on(np);
> >> > +       if (IS_ERR(pwrseq))
> >> > +               return PTR_ERR(pwrseq);
> >> > +
> >> > +       pwrseq_list_node = kzalloc(sizeof(*pwrseq_list_node), GFP_KERNEL);
> >>
> >> Why don't you allocate memory before turning the power sequence on?
> >>
> >
> > This list is only for power sequence on instance, if I allocate memory before
> > power sequence on, I need to free it if power sequence on is failed.
> 
> So why is that a problem?
> 

Not any problems, I will follow your comments.

> >> > +       if (!pwrseq_list_node) {
> >> > +               of_pwrseq_off(pwrseq);
> >> > +               return -ENOMEM;
> >> > +       }
> >> > +       pwrseq_list_node->pwrseq = pwrseq;
> >> > +       list_add(&pwrseq_list_node->list, head);
> >> > +
> >> > +       return 0;
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(of_pwrseq_on_list);
> >>
> >> So the caller is supposed to provide a list head of the list to put
> >> the power sequence object into on success, right?
> >
> > Yes
> >
> >>
> >> Can you explain to me what the idea here is, please?
> >>
> >
> > Taking USB devices as an example, there is one power sequence on list
> > per bus, and there are several USB devices on the bus. Using a list,
> > we can record which device is powered sequence on, and only powers
> > sequence off which has already powered sequence on at error path, and
> > power sequence off all devices on the bus when the bus (eg, USB HUB)
> > is removed. (eg, when the bus driver is removed)
> 
> Well, I'm not sure I understand this correctly.
> 
> What about system suspend/resume and such, for instance?

Thanks, yes, we need to consider PM.

The initial idea for this library is only for power on/off. It does not
take power management into consideration. As an enhancement, we need
to consider PM, and implement pwrseq_suspend/resume accordingly (will
consider concurrent issue). I will add related APIs at pwrseq_generic.c
at next version, and only call clock operations at it (reset gpio
is not needed for PM).

> 
> > Usually, the power sequence is only needed for hard-wired devices,
> > the power sequence on is carried out during the bus driver probed,
> > and off if carried out during the bus driver is removed,
> > of_pwrseq_on_list/of_powerseq_off_list is not supposed to be
> > called during the other bus driver life cycles.
> >
> >> Also, what's the protection of the list against concurrent access?
> >>
> >
> > I will add comment that the list creator needs to take consideration
> > of concurrent access if exists.
> >
> >> > +
> >> > +/**
> >> > + * of_pwrseq_off_list: do power sequence off for the list
> >> > + *
> >> > + * This API is used to power off all devices on this bus, it is
> >> > + * the opposite operation for of_pwrseq_on_list.
> >> > + *
> >> > + * @head: the list head for pwrseq instance list on this bus
> >> > + */
> >> > +void of_pwrseq_off_list(struct list_head *head)
> >> > +{
> >> > +       struct pwrseq *pwrseq;
> >> > +       struct pwrseq_list_per_dev *pwrseq_list_node, *tmp_node;
> >> > +
> >> > +       list_for_each_entry_safe(pwrseq_list_node, tmp_node, head, list) {
> >> > +               pwrseq = pwrseq_list_node->pwrseq;
> >> > +               of_pwrseq_off(pwrseq);
> >> > +               list_del(&pwrseq_list_node->list);
> >> > +               kfree(pwrseq_list_node);
> >> > +       }
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(of_pwrseq_off_list);
> >>
> >> This looks horribly inefficient.
> >>
> >> Is the user expected to create the list from scratch every time things
> >> are turned on?
> >>
> >
> > Like I explained above, the power sequence is for hard-wired device on
> > board, the list creation and remove are only carried out on driver's
> > probe and remove.
> 
> Which driver exactly are you referring to?
> 

For system PM, the list is still existed. It calls of_pwrseq_suspend/resume
accordingly. The first user for this pwrseq library is USB HUB.
(drivers/usb/core/hub.c).

-- 

Best Regards,
Peter Chen
