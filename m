From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: dev->status.power and future of DPM_
Date: Fri, 15 May 2009 18:46:44 +0900
Message-ID: <aec7e5c30905150246t52c5626er2e537a96aaeab4e@mail.gmail.com>
References: <aec7e5c30905132118m265245f4u9d9581b3fde788f6@mail.gmail.com>
	<Pine.LNX.4.44L0.0905141101220.3004-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0905141101220.3004-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-pm@vger.kernel.org

Hi Alan,

On Fri, May 15, 2009 at 12:14 AM, Alan Stern <stern@rowland.harvard.edu> wr=
ote:
> On Thu, 14 May 2009, Magnus Damm wrote:
>> Basically, dev->power.status seems to represent the soon to be state
>> of each device.
>
> No, that's wrong. =A0It doesn't represent the state of the device at all,
> in spite of its name. =A0Rather, it is a record of which messages have
> been sent (or are about to be sent) from the PM core to the device's
> driver.

Ok. But these messages are only show what is happening during one
"run". There is no information of what has happened what I can tell.
So for suspend-to-disk we may end up with one round of PMSG_FREEZE and
another of PMSG_HIBERNATE. I'd like the driver core to know which
callbacks that have been called for each device.

>> I'd like to keep the state of each device somewhere.
>
> You can't, or at least, you can't keep it anywhere under dev->power.
> That's because the "state" is very device-specific or bus-specific.
> It's not possible to come up with any sort of general indicator that
> applies to all devices.

Not even information like SUSPENDED, FROZEN or OFF? That's pure
software state IMO.

> dev_pm_ops->freeze() and ->restore() are meant to be used by the PM
> core. =A0It's not up to the PM core to keep track of the device state;
> that job belongs to the device's driver.

Hm.

>> So I'd like to be able to freeze individual devices independently of
>> each other. And then there's lots of architecture specific work that
>> needs to be done. =3D)
>
> Be careful of your choice of words. =A0Do you really mean "freeze"?
> That's very different from going to a low-power state. =A0In fact, a
> "frozen" device generally should remain at full power. =A0Being "frozen"
> simply means that the device isn't doing I/O or DMA.

I mean "frozen". For the SuperH Mobile SoCs we enter sleep modes
through the sleep instruction. Since we need run time power management
we don't control the power of each device though suspend callbacks.
Actually, there is not much to control except clocks and they are
handled through the clock framework already. What we want to do is to
mark the device as idle, and at the time of entering cpuidle we check
if all devices are idle, and if so we freeze the devices and enter the
deep sleep mode.

>> Doing things at the bus type level sounds fine with me. I'm mainly
>> interested in platform devices.
>
> Sure, that's fine. =A0But it means you can't use the fields in
> dev->power. =A0You have to add new fields to the bus-specific or
> platform-specific data structures.

Good plan!

>> > USB, where run-time power management has already been
>> > implemented, is a good example too.
>>
>> That's great, but it doesn't help us entering deep sleep states on our S=
oCs. =3D)
>
> It should, because it provides an example of how your code ought to be
> structured.

Ok, examples are always welcome. =3D)

/ magnus
