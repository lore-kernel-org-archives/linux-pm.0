From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH V2 8/8] irqchip/gic: Add support for tegra AGIC
 interrupt controller
Date: Tue, 22 Dec 2015 11:03:59 +0100
Message-ID: <CACRpkdYWfe3MTE1YBPKspcpXNggADCbguCgupo+POwaTv_-6Kw@mail.gmail.com>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com>
	<1450349309-8107-9-git-send-email-jonathanh@nvidia.com>
	<CACRpkdZT42rpKsVtNYdCuL_i0xWngvKSMSVUy1bLmPtxHhG5ew@mail.gmail.com>
	<5673E38B.7060702@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5673E38B.7060702-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 18, 2015 at 11:44 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> On 17/12/15 13:32, Linus Walleij wrote:
>> On Thu, Dec 17, 2015 at 11:48 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>
>>> Add a driver for the Tegra-AGIC interrupt controller which is compatible
>>> with the ARM GIC-400 interrupt controller.
>> (...)
>>> +static const struct dev_pm_ops gic_pm_ops = {
>>> +       SET_RUNTIME_PM_OPS(gic_runtime_suspend,
>>> +                          gic_runtime_resume, NULL)
>>> +       SET_SYSTEM_SLEEP_PM_OPS(gic_suspend, gic_resume)
>>> +};
>>
>> Now you do what I commented on in the earlier patch: assign
>> the runtime PM functions to normal suspend/resume.
>>
>> This will have the effect of inhibiting any IRQs marked for
>> wakeup on the GIC, even if you just want to go to sleep until
>> something happens, will it not?
>>
>> You should turn on the alarm clock before going to bed, not
>> turn it off, as figure of speak ...
>
> Yes I am alway having problems with my alarm, may be this is why ;-)
>
> I see what you are saying, so if there are any wake-ups enabled then we
> should not suspend the chip. Right?

Yep, so I think you should just wrap the normal suspend functions
into some function that check if we have some wakeup active
and then just return 0, else if everything is clear, call the same
runtime PM hooks, and it will work nicely I think. IIUC the wakeup
flag is only for the suspend/resume/sleep case so this should
be enough.

Yours,
Linus Walleij
