From: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 0/3] Runtime Interpreted Power Sequences
Date: Sun, 28 Apr 2013 00:36:45 +0900
Message-ID: <CAAVeFuLCoi07-9KWyi+iJ58Zb-aiQg1pgCvq1fmF+FKuzfCRiQ@mail.gmail.com>
References: <1353047903-14363-1-git-send-email-acourbot@nvidia.com> <CAPnjgZ1P6dmRB0sO2qBUtd=WBiNcY339NAit2faaotAfEqQDeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPnjgZ1P6dmRB0sO2qBUtd=WBiNcY339NAit2faaotAfEqQDeQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lk <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Simon,

On Sat, Apr 27, 2013 at 3:55 AM, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> Hi,
>
> On Thu, Nov 15, 2012 at 10:38 PM, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> Hopefully the final series before the feature gets merged. Anton Vorontsov
>> kindly accepted to take it into his tree, so this series is mostly a call for
>> acks, tests and reviews notices before the merge window for 3.8 opens. If you
>> are interested in seeing this feature, please add your name.
>>
>> This series also adds an entry for the subsystem into MAINTAINERS, setting me as
>> the person in charge.
>>
>> Changes from v7:
>> - fix bug reported by Tony Prisk
>> - add MAINTAINERS entry
>>
>> Alexandre Courbot (3):
>>   Runtime Interpreted Power Sequences
>>   pwm_backlight: use power sequences
>>   Take maintainership of power sequences
>
> Did this actually land? I can't see it in linux-next.

It has not landed yet, and will not land in the form that I proposed
initially. There were some obvious issues with describing the
sequences in the device tree, and I decided to rethink the whole
thing, study the state of the art some more (especially ACPI) and
start again from a blank page.

The v2 idea is almost ready to be shared, but it needs a cleaner way
to manage GPIOs, which itself requires gpiolib to be refactored and
the GENERIC_GPIO option to be removed. These last two items will land
in 3.10, so I hope to have both the gpiod interface *and* the new
power seqs ready and approved for 3.11. Then my $@?*^! panel backlight
will maybe finally switch on (no kidding - that's really what this
whole thing is about).

The new power seqs will fundamentally work in a similar fashion to v1
(a simple bytecode that controls power-related items), but will not be
encoded through the DT. Instead, I'd like to have small power control
objects that can be referenced by the platform data of pseq-enabled
drivers, or fetched and associated to the driver through the
compatible property of the DT. These objects will have, as before,
power resources they need to request, and power methods that the
driver can call as needed.

I hate to give dates, but my wish is to come with a first version of
the code by the time the merge window closes. And yes, I still plan to
use Anton as a trojan horse to get this in. ;)

Thanks,
Alex.
