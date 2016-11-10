From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking support
Date: Wed, 9 Nov 2016 16:59:30 -0800
Message-ID: <CAB=NE6Xdu5AniWsaJGf3pbYCydahwkStqBV+2xbc8S-Zw+2qiA@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan> <20161026111902.GA6447@wunner.de>
 <20161027152551.GA15718@kroah.com> <20161107212250.GH1764@wotan.suse.de> <CAJZ5v0goccDKSkSAj8+v+PG2gt7ESJuUSbyY8YuW7OwCS_KHXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0goccDKSkSAj8+v+PG2gt7ESJuUSbyY8YuW7OwCS_KHXg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>, Grant Likely <grant.likely@secretlab.ca>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrzej Hajda <a.hajda@samsung.co>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 9, 2016 at 4:43 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Nov 7, 2016 at 10:22 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>> On Thu, Oct 27, 2016 at 05:25:51PM +0200, Greg Kroah-Hartman wrote:
>>> On Wed, Oct 26, 2016 at 01:19:02PM +0200, Lukas Wunner wrote:
>>> > Hi Rafael,
>>> >
>>> > sorry for not responding to v5 of your series earlier, just sending
>>> > this out now in the hope that it reaches you before your travels.
>>> >
>>> > On Mon, Oct 10, 2016 at 02:51:04PM +0200, Rafael J. Wysocki wrote:
>>> > > - Modify device_links_check_suppliers(), device_links_driver_bound(),
>>> > >   device_links_no_driver(), device_links_driver_cleanup(), device_links_busy(),
>>> > >   and device_links_unbind_consumers() to walk link lists under device_links_lock
>>> > >   (to make the new "driver presence tracking" mechanism work reliably).
>>> >
>>> > This change might increase boot time if drivers return -EPROBE_DEFER.
>>>
>>> "might"?  Please verify this before guessing....
>>>
>>> And don't make this more complex than needed before actually determining
>>> a real issue.
>>
>> As clarified by Rafael at Plumbers, this functional dependencies
>> framework assumes your driver / subsystem supports deferred probe,
>
> It isn't particularly clear what you mean by "support" here.

I noted some folks had reported issues, and you acknowledged that if
deferred probe was used in some drivers and if this created an issue
the same issue would be seen with this framework. AFAICT there are two
possible issues to consider:

1) the one Geert Uytterhoeven noted. Again I'll note what he had mentioned [0].

  "Some drivers / subsystems don’t support deferred probe yet, such failures
   usually don’t blow up, but cause subtle malfunctioning. Example, an Ethernet
   phy could not get its interrupt as the primary IRQ chip had not been probed
   yet, it reverted to polling though. Sub-optimal." [0]

[0] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-August/003425.html

Geert can you provide more details?

2) Since deferred probe relies on late_initcall() if your driver must
load earlier than this deferred probe can create an issue. Andrzej had
you identified a driver that ran into this and had issues ? If not
this seems like a semantics thing we should consider in extending the
documentation for drivers so that driver writers are aware of this
limitation. I would suppose candidates for this would be anything not
using module_init() or late_initcall() on their inits and have a
probe.

>> if it does not support its not clear what will happen....
>
> I don't see any problems here, but if you see any, please just say
> what they are.
>
>> We have no explicit semantics to check if a driver / subsystem
>> supports deferred probe.
>
> That's correct, but then do we need it?

We can determine this by reviewing the two items above.

  Luis
