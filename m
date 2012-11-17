From: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 1/3] Runtime Interpreted Power Sequences
Date: Sat, 17 Nov 2012 13:04:00 +0900
Message-ID: <CAAVeFuL_r8PGM=0gDv=x2ff3GFCZQ4=DaZq4N9gfvXtnFC=aNg@mail.gmail.com>
References: <1353047903-14363-1-git-send-email-acourbot@nvidia.com>
 <1353047903-14363-2-git-send-email-acourbot@nvidia.com> <20121116103511.GB16084@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121116103511.GB16084-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Fri, Nov 16, 2012 at 7:35 PM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> Given there are several ARM platforms that may have an interest in this, please
> consider posting this to the ARM mailing list:
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XZu6nac5fYnt@public.gmane.org

That's right. New revision on the way.

>> +Similarly, each power sequence declares its steps as sub-nodes of itself. Steps
>> +must be named sequentially, with the first step named step0, the second step1,
>> +etc. Failure to follow this rule will result in a parsing error.
>
> Could we not encode the step number in the unit-address? i.e. step@N rather than
> stepN.

That was the way I did it initially, but it has been pointed out that
doing so would require to have #address-cells and #size-cells in every
power sequence, as well as a "reg" property in every step (see
https://lkml.org/lkml/2012/7/31/454 ). Although I'd prefer to use the
@ notation too (and neither dtc nor the kernel complained when I did
it), I tend to think the current solution is less burdensome than
having these redundant properties.

>> +"gpio" type required properties:
>> +  - gpio: phandle of the GPIO to use.
>> +  - value: value this GPIO should take. Must be 0 or 1.
>
> Is there any reason for id to be a name rather than a phandle? It seems
> inconsistent with the gpio case.

That's another long story. But to make it short, I'd like to make it
possible for power sequences to be referenced and shared between
devices of the same type (as everybody knows, copy/pasting is bad). If
we use phandles in steps, the power sequence becomes tied to the
referred resources and thus cannot be shared with another instance of
the same device. On the other hand, using an identifier that is
resolved at runtime (through e.g. regulator_get(device *, char *)
leverages the existing frameworks and makes things more flexible.

GPIO is currently the exception. It is the only framework for which
you cannot currently resolve a resource from a device and an
identifier. So at the moment we have to use a phandle - but we are
also working with Linus Walleij to provide an alternative GPIO API
that will be more like what we have for regulators/pinctrl/PWM/etc.

Another problem with phandles is that some of the functions that
resolve them are not publicly exported (i.e. AFAIK there is no public
function that returns a regulator from a phandle - the only to obtain
one is through regulator_get)

> I also see from the example below that the gpio property is not just a phandle,
> as it has the gpio-specifier appended. Is there a better way of describing this
> format in the documentation?

This is already clearly be defined in
Documentation/devicetree/bindings/gpio/, isn't it?

Thanks,
Alex.
