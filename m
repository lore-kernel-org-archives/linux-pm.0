From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 2/8] power: add power sequence library
Date: Thu, 1 Dec 2016 22:57:24 +0100
Message-ID: <CAJZ5v0g9rrJ-pLk4bF9XO_0BndGcduncPU0Tamm2m0UvN9X08A@mail.gmail.com>
References: <1479087359-7547-1-git-send-email-peter.chen@nxp.com>
 <1479087359-7547-3-git-send-email-peter.chen@nxp.com> <CAJZ5v0i-_pHS+N-k7QVuc_0StT+BaFB+2fuHJpCfngtQV5z76w@mail.gmail.com>
 <20161122035324.GA7497@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161122035324.GA7497@b29397-desktop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb@vge>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 22, 2016 at 4:53 AM, Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Nov 22, 2016 at 03:23:12AM +0100, Rafael J. Wysocki wrote:
>> > @@ -0,0 +1,237 @@
>> > +/*
>> > + * core.c      power sequence core file
>> > + *
>> > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
>> > + * Author: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
>> > + *
>> > + * This program is free software: you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License version 2  of
>> > + * the License as published by the Free Software Foundation.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + *
>> > + * You should have received a copy of the GNU General Public License
>> > + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>
>> The last paragraph is not necessary AFAICS.
>
> I just copy it from:
>
> https://www.gnu.org/licenses/gpl-howto.en.html
>
> If you are concerns about it, I can delete it.

It is redundant, so yes, please.

>> > +
>> > +static struct pwrseq *pwrseq_find_available_instance(struct device_node *np)
>> > +{
>> > +       struct pwrseq *pwrseq;
>> > +
>> > +       list_for_each_entry(pwrseq, &pwrseq_list, node) {
>> > +               if (pwrseq->used)
>> > +                       continue;
>> > +
>> > +               /* compare compatible string for pwrseq node */
>> > +               if (of_match_node(pwrseq->pwrseq_of_match_table, np)) {
>> > +                       pwrseq->used = true;
>> > +                       return pwrseq;
>> > +               }
>> > +
>> > +               /* return generic pwrseq instance */
>> > +               if (!strcmp(pwrseq->pwrseq_of_match_table->compatible,
>> > +                               "generic")) {
>> > +                       pr_debug("using generic pwrseq instance for %s\n",
>> > +                               np->full_name);
>> > +                       pwrseq->used = true;
>> > +                       return pwrseq;
>> > +               }
>> > +       }
>> > +       pr_warn("Can't find any pwrseq instances for %s\n", np->full_name);
>>
>> pr_debug() ?
>
> If there is no pwrseq instance for that node, the power sequence on routine will
> return fail, so I think an warning message is useful for user.

Useful in what way?  How is the user supposed to know what happened
from this message?

>>
>> > +
>> > +       return NULL;
>> > +}
>> > +
>> > +/**
>> > + * of_pwrseq_on: do power sequence on for device node
>>
>> of_pwrseq_on - Carry out power sequence on for device node
>>
>> Argument description should follow this line.
>>
>> > + *
>> > + * This API is used to power on single device, if the host
>> > + * controller only needs to handle one child device (this device
>> > + * node points to), use this API. If multiply devices are needed
>> > + * to handle on bus, use of_pwrseq_on_list.
>>
>> That's unclear.
>>
>> What about "Carry out a single device power on.  If multiple devices
>> need to be handled, use of_pwrseq_on_list() instead."
>>
>> > + *
>> > + * @np: the device node would like to power on
>> > + *
>> > + * On successful, it returns pwrseq instance, otherwise an error value.
>>
>> "Return a pointer to the power sequence instance on success, or an
>> error code otherwise."
>>
>
> Ok, will change.
>
>> > + */
>> > +struct pwrseq *of_pwrseq_on(struct device_node *np)
>> > +{
>> > +       struct pwrseq *pwrseq;
>> > +       int ret;
>> > +
>> > +       pwrseq = pwrseq_find_available_instance(np);
>>
>> What does guarantee the integrity of ths list at this point?
>
> Once the use selects the specific pwrseq library, the library will
> create an empty one instance during the initialization, and it
> will be called at postcore_initcall, the device driver has not
> probed yet.

Which doesn't matter really, because the list is global and some other
driver using it might have been probed already.

You have a mutex here and it is used for add/remove.  Why isn't it
used for list browsing?

>
>>
>> > +       if (!pwrseq)
>> > +               return ERR_PTR(-ENONET);
>>
>> ENOENT I suppose?
>>
>
> Good catch, thanks.
>
>> > +/**
>> > + * of_pwrseq_off: do power sequence off for this pwrseq instance
>> > + *
>> > + * This API is used to power off single device, it is the opposite
>> > + * operation for of_pwrseq_on.
>> > + *
>> > + * @pwrseq: the pwrseq instance which related device would like to be off
>> > + */
>> > +void of_pwrseq_off(struct pwrseq *pwrseq)
>> > +{
>> > +       pwrseq_off(pwrseq);
>> > +       pwrseq_put(pwrseq);
>> > +}
>> > +EXPORT_SYMBOL_GPL(of_pwrseq_off);
>>
>> What happens if two code paths attempt to turn the same power sequence
>> off in parallel?  Can it ever happen?  If not, then why not?
>>
>
> I don't think the same pwrseq instance off will be called at the same
> time, the of_pwrseq_off is supposed to be only called at error path
> during power-on and at device power-off routine, and only the power-on is
> successful, the device can be created, if the device is not created,
> its power-off routine is not supposed to be called.
>
>> > +
>> > +/**
>> > + * of_pwrseq_on_list: do power sequence on for list
>> > + *
>> > + * This API is used to power on multiple devices at single bus.
>> > + * If there are several devices on bus (eg, USB bus), uses this
>> > + * this API. Otherwise, use of_pwrseq_on. After the device
>> > + * is powered on successfully, it will be added to pwrseq list for
>> > + * this bus.
>> > + *
>> > + * @np: the device node would like to power on
>> > + * @head: the list head for pwrseq list on this bus
>> > + *
>> > + * On successful, it returns 0, otherwise an error value.
>>
>> Please format the kerneldoc comment in a usual way.
>>
>
> Ok.
>
>> > + */
>> > +int of_pwrseq_on_list(struct device_node *np, struct list_head *head)
>> > +{
>> > +       struct pwrseq *pwrseq;
>> > +       struct pwrseq_list_per_dev *pwrseq_list_node;
>> > +
>> > +       pwrseq = of_pwrseq_on(np);
>> > +       if (IS_ERR(pwrseq))
>> > +               return PTR_ERR(pwrseq);
>> > +
>> > +       pwrseq_list_node = kzalloc(sizeof(*pwrseq_list_node), GFP_KERNEL);
>>
>> Why don't you allocate memory before turning the power sequence on?
>>
>
> This list is only for power sequence on instance, if I allocate memory before
> power sequence on, I need to free it if power sequence on is failed.

So why is that a problem?

>> > +       if (!pwrseq_list_node) {
>> > +               of_pwrseq_off(pwrseq);
>> > +               return -ENOMEM;
>> > +       }
>> > +       pwrseq_list_node->pwrseq = pwrseq;
>> > +       list_add(&pwrseq_list_node->list, head);
>> > +
>> > +       return 0;
>> > +}
>> > +EXPORT_SYMBOL_GPL(of_pwrseq_on_list);
>>
>> So the caller is supposed to provide a list head of the list to put
>> the power sequence object into on success, right?
>
> Yes
>
>>
>> Can you explain to me what the idea here is, please?
>>
>
> Taking USB devices as an example, there is one power sequence on list
> per bus, and there are several USB devices on the bus. Using a list,
> we can record which device is powered sequence on, and only powers
> sequence off which has already powered sequence on at error path, and
> power sequence off all devices on the bus when the bus (eg, USB HUB)
> is removed. (eg, when the bus driver is removed)

Well, I'm not sure I understand this correctly.

What about system suspend/resume and such, for instance?

> Usually, the power sequence is only needed for hard-wired devices,
> the power sequence on is carried out during the bus driver probed,
> and off if carried out during the bus driver is removed,
> of_pwrseq_on_list/of_powerseq_off_list is not supposed to be
> called during the other bus driver life cycles.
>
>> Also, what's the protection of the list against concurrent access?
>>
>
> I will add comment that the list creator needs to take consideration
> of concurrent access if exists.
>
>> > +
>> > +/**
>> > + * of_pwrseq_off_list: do power sequence off for the list
>> > + *
>> > + * This API is used to power off all devices on this bus, it is
>> > + * the opposite operation for of_pwrseq_on_list.
>> > + *
>> > + * @head: the list head for pwrseq instance list on this bus
>> > + */
>> > +void of_pwrseq_off_list(struct list_head *head)
>> > +{
>> > +       struct pwrseq *pwrseq;
>> > +       struct pwrseq_list_per_dev *pwrseq_list_node, *tmp_node;
>> > +
>> > +       list_for_each_entry_safe(pwrseq_list_node, tmp_node, head, list) {
>> > +               pwrseq = pwrseq_list_node->pwrseq;
>> > +               of_pwrseq_off(pwrseq);
>> > +               list_del(&pwrseq_list_node->list);
>> > +               kfree(pwrseq_list_node);
>> > +       }
>> > +}
>> > +EXPORT_SYMBOL_GPL(of_pwrseq_off_list);
>>
>> This looks horribly inefficient.
>>
>> Is the user expected to create the list from scratch every time things
>> are turned on?
>>
>
> Like I explained above, the power sequence is for hard-wired device on
> board, the list creation and remove are only carried out on driver's
> probe and remove.

Which driver exactly are you referring to?

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
