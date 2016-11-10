From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking support
Date: Thu, 10 Nov 2016 01:43:38 +0100
Message-ID: <CAJZ5v0goccDKSkSAj8+v+PG2gt7ESJuUSbyY8YuW7OwCS_KHXg@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan> <20161026111902.GA6447@wunner.de>
 <20161027152551.GA15718@kroah.com> <20161107212250.GH1764@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161107212250.GH1764@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 7, 2016 at 10:22 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Thu, Oct 27, 2016 at 05:25:51PM +0200, Greg Kroah-Hartman wrote:
>> On Wed, Oct 26, 2016 at 01:19:02PM +0200, Lukas Wunner wrote:
>> > Hi Rafael,
>> >
>> > sorry for not responding to v5 of your series earlier, just sending
>> > this out now in the hope that it reaches you before your travels.
>> >
>> > On Mon, Oct 10, 2016 at 02:51:04PM +0200, Rafael J. Wysocki wrote:
>> > > - Modify device_links_check_suppliers(), device_links_driver_bound(),
>> > >   device_links_no_driver(), device_links_driver_cleanup(), device_links_busy(),
>> > >   and device_links_unbind_consumers() to walk link lists under device_links_lock
>> > >   (to make the new "driver presence tracking" mechanism work reliably).
>> >
>> > This change might increase boot time if drivers return -EPROBE_DEFER.
>>
>> "might"?  Please verify this before guessing....
>>
>> And don't make this more complex than needed before actually determining
>> a real issue.
>
> As clarified by Rafael at Plumbers, this functional dependencies
> framework assumes your driver / subsystem supports deferred probe,

It isn't particularly clear what you mean by "support" here.

I guess that you mean that it will allow the ->probe callback to be
invoked for multiple times for the same device/driver combination
without issues.  If that's the case, the way the new code uses
-EPROBE_DEFER doesn't interfere with this, because it will not invoke
the ->probe callbacks for consumers at all until their (required)
suppliers are ready.

> if it does not support its not clear what will happen....

I don't see any problems here, but if you see any, please just say
what they are.

> We have no explicit semantics to check if a driver / subsystem
> supports deferred probe.

That's correct, but then do we need it?

Thanks,
Rafael
