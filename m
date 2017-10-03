From: Andrea Adami <andrea.adami@gmail.com>
Subject: Re: [PATCH] PM: ARM: locomo: Drop suspend and resume bus type callbacks
Date: Tue, 3 Oct 2017 16:55:03 +0200
Message-ID: <CAAQYJAvLRZ7ocSqWk1LYQPXp-=ibsU=jS=Jr86-UOZSjiuqOYQ@mail.gmail.com>
References: <2826985.0zUqx1lpzM@aspire.rjw.lan> <CAPDyKFrkUW7S7hkEsYH9UWex3F=1QHFLozxyMey1e+XT2a8JGg@mail.gmail.com>
 <38658124.i1yAOWmsJn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <38658124.i1yAOWmsJn@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 3, 2017 at 1:44 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, October 3, 2017 10:09:21 AM CEST Ulf Hansson wrote:
>> On 26 September 2017 at 22:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > None of the locomo drivers in the tree implements the suspend and
>> > resume callbacks from struct locomo_driver, so drop them and drop
>> > the corresponding callbacks from locomo_bus_type.
>> >
>> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> FWIW:
>>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Do you also plan to convert the locomo_device_driver (platform_driver)
>> to be converted to the modern PM callbacks for suspend/resume?
>
> Yes, I do, but that later. :-)
>
> Thanks,
> Rafael
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


Thanks for working on this.

Just FYI,
there is a patch-serie for 4.2/locomo ported up to 4.4: never went
mainline unfortunately.

http://git.infradead.org/users/dbaryshkov/zaurus.git

I have just adapted the patches form 4.2 to 4.4 [1] and tested on real hw.
Unfortunately it is not trivial updating it (must be adapted to GPIO
descriptors, etc.).

As far as I see in the new driver there isn't anymore the use of the
bus, so your patch shouldn't harm.
I'll put Dmitry in cc to get his confirmation.

Regards
Andrea

[1] http://cgit.openembedded.org/meta-handheld/tree/recipes-kernel/linux/linux-handheld-4.4/locomo
