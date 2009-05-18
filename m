From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: dev->status.power and future of DPM_
Date: Mon, 18 May 2009 11:27:29 +0900
Message-ID: <aec7e5c30905171927r7f1fca36l491fd09d3e446be6@mail.gmail.com>
References: <aec7e5c30905150246t52c5626er2e537a96aaeab4e@mail.gmail.com>
	<Pine.LNX.4.44L0.0905151045030.3065-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0905151045030.3065-100000@iolanthe.rowland.org>
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

On Fri, May 15, 2009 at 11:59 PM, Alan Stern <stern@rowland.harvard.edu> wr=
ote:
> On Fri, 15 May 2009, Magnus Damm wrote:
>
>> Ok. But these messages are only show what is happening during one
>> "run". There is no information of what has happened what I can tell.
>> So for suspend-to-disk we may end up with one round of PMSG_FREEZE and
>> another of PMSG_HIBERNATE.
>
> You mean that you'd like to know when the system is in the middle of a
> power transition, such as during the time while the memory image is
> being assembled (PMSG_FREEZE has been sent but not PMSG_HIBERNATE).
> Right?
>
> AFAIK that information isn't stored explicitly anywhere, but it could
> be added easily enough.

Good!

>> >> I'd like to keep the state of each device somewhere.
>> >
>> > You can't, or at least, you can't keep it anywhere under dev->power.
>> > That's because the "state" is very device-specific or bus-specific.
>> > It's not possible to come up with any sort of general indicator that
>> > applies to all devices.
>>
>> Not even information like SUSPENDED, FROZEN or OFF? That's pure
>> software state IMO.
>
> Let's put it this way: Yes, SUSPENDED/FROZEN/OFF is software state.
> In other words, it's really the state of the _driver_ (since the driver
> is software). =A0It isn't the device state; that is, it's not a hardware
> state. =A0So yes, you can keep that information -- but it's not what you
> said you wanted; above you said you wanted to keep the state of each
> _device_ somewhere.

I'd like to keep the state of the driver _instance_. Basically what
struct device represents. Not struct device_driver. Sorry for being
unclear, I mean struct device when I use the word device. Driver and
hardware specific state and information should be kept out of common
data structures. But that's just common sense, no? Same as keeping bus
specific information together with the bus data structures.

So to clarify, we have many drivers with multiple driver instances on
SuperH. A good example is the CEU platform driver, each driver
instance (video capture) is hooked up to a hardware block located
somewhere in io memory space. We have one struct device_driver but may
have multiple struct devices. I'm interested in the state of struct
device.

>> I mean "frozen". For the SuperH Mobile SoCs we enter sleep modes
>> through the sleep instruction. Since we need run time power management
>> we don't control the power of each device though suspend callbacks.
>> Actually, there is not much to control except clocks and they are
>> handled through the clock framework already. What we want to do is to
>> mark the device as idle, and at the time of entering cpuidle we check
>> if all devices are idle, and if so we freeze the devices and enter the
>> deep sleep mode.
>
> I don't understand what you mean by "we freeze the devices".

How about this: "execute some struct device ->freeze() callbacks and
take a note of this by putting driver instances in FROZEN state". Does
it make more sense?

Thanks,

/ magnus
