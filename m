From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH V2 3/8] genirq: Add runtime power management support
 for IRQ chips
Date: Thu, 21 Jan 2016 08:38:55 +0000
Message-ID: <56A0991F.4010802@nvidia.com>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com>
 <1450349309-8107-4-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFqZK4HYWgXam63=eCKAWsjwCiQbT5jdmgjqid_er3Sg1g@mail.gmail.com>
 <569E1366.8070005@nvidia.com> <alpine.DEB.2.11.1601201620450.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1601201620450.3575@nanos>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


On 20/01/16 15:30, Thomas Gleixner wrote:
> On Tue, 19 Jan 2016, Jon Hunter wrote:
>> On 18/01/16 14:47, Ulf Hansson wrote:
>>>> +/* Inline functions for support of irq chips that require runtime pm */
>>>> +static inline int chip_pm_get(struct irq_desc *desc)
>>>
>>> Why does these new get/put functions need to be inline functions and
>>> thus defined in the header file? Perhaps move them to manage.c are
>>> better?
>>
>> They don't have to be, and so I can move them.
> 
> Yes, please make them proper functions. The proper place for them is chip.c
>  
>>> This won't play nicely when CONFIG_PM is unset, as pm_runtime_put()
>>> would return -ENOSYS. In such cases I guess you would like to ignore
>>> the error!?
>>
>> Ok, yes good point.
> 
> So you need a CONFIG_PM variant and stubs which return 0 for the !PM case.
>  
>>>> @@ -1116,6 +1116,10 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>>>>         if (!try_module_get(desc->owner))
>>>>                 return -ENODEV;
>>>>
>>>> +       ret = chip_pm_get(desc);
>>>> +       if (ret < 0)
>>>> +               return ret;
> 
> That leaks the module refcount.

Ok, I will fix that.

>>> I don't think using __free_irq() is the correct place to decrease the
>>> runtime PM usage count. It will keep the irqchip runtime resumed even
>>> if there are no irqs enabled for it.
>>>
>>> Instead I would rather allow the irqchip to be runtime suspended, when
>>> there are no irqs enabled on it.
> 
> Which is a no no, as you might lose interrupts that way. We disable interrupts
> lazy, i.e. we do not mask them. So no, you cannot do that from
> enable/disable_irq().
>  
>> This may appear ugly, but for something like this, we may need to have a
>> separate enable/disable API, such as
>> enable_irq_lazy()/disable_irq_lazy() which could be used to runtime
>> suspend/resume the chip and must not be used in critical sections.
> 
> enable_irq_lazy is a misnomer. enable_irq_pm or such might be acceptable.

That's fine with me.

> But before we go there I really want to see a proper use case for such
> functions.

Ok, that makes sense.

Cheers
Jon
