From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] Driver Core: Add platform device arch data V2
Date: Tue, 2 Jun 2009 13:33:08 +0900
Message-ID: <aec7e5c30906012133w74d7d843jccad99c564a308ec__29567.8018629134$1243917330$gmane$org@mail.gmail.com>
References: <20090601101614.10720.93804.sendpatchset@rx1.opensource.se>
	<200906012047.59726.rjw@sisk.pl> <200906012133.32074.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906012133.32074.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: paul@pwsan.com, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

2009/6/2 Rafael J. Wysocki <rjw@sisk.pl>:
> On Monday 01 June 2009, Rafael J. Wysocki wrote:
>> On Monday 01 June 2009, Magnus Damm wrote:
>> > From: Magnus Damm <damm@igel.co.jp>
>> >
>> > Allow architecture specific data in struct platform_device V2.
>> > The structure pdev_archdata is added to struct platform_device,
>> > similar to struct dev_archdata in struct device.
>> >
>> > Useful for architecture code that needs to keep extra data
>> > associated with each platform device. This data shall not
>> > be accessed by platform drivers, only architecture code.
>> >
>> > Needed for platform device runtime PM.
>>
>> What exactly do you need this data for?

I'd like to keep a hardware block id associated with each platform
device on our SoC.
Please have a look at "PATCH [04/04] sh: Runtime platform device PM mockup",
http://patchwork.kernel.org/patch/26421/

> Anyway, I think you can introduce something like:
>
> struct <your arch>_platform_device {
> =A0 =A0struct platform_device dev;
> =A0 =A0<some type> <your arch data>;
> =A0 =A0...
> };
>
> define your platform devices using the struct above and pass its dev memb=
er to
> the functions that need 'struct platform_device' as an argument.
>
> Then you won't need to add arch members to 'struct platform_device' itsel=
f.

Thanks for your suggestion. I'm usually a friend of wrapping
structures and using offsetof(), but in this case I don't think it
will work very well.

I'd like to keep a SoC specific hardware block id in this architecture
specific struct. Then let the arch specific functions
platform_device_idle() and platform_device_wakeup() use this hardware
block id to locate which clocks to stop and which power domains to
fiddle with within the SoC. If we only consider this on-SoC case then
wrapping and offsetof() works well.

However, a typical embedded system has a wide range of platform
devices. Some are for the SoC itself and some are for external
devices, like on board ethernet controlllers (not on chip like the SoC
platform devices). And since idle() and wakeup() work with struct
platform device, with a wrapped data structure we need some way to
check if the platform data is actually wrapped and offsetof() is
valid. I guess we could use some platform device specific flag for
this, but that seems overly complicated in my opinion. And modifying
idle() and wakup() to take arch specific structures is not so good
since we want to use the same platform driver on multiple
architectures.

My mockup code that keeps keeps the hardware block id in the platform
device arch specific data works well since the hardware block id with
value zero is a special case. The value zero means "external non-soc
device", so a "regular" board specific struct platform_device that do
not setup arch specific data can just be skipped in idle()/wakeup().

If you guys dislike adding arch specific data to struct platform
device then for SuperH we can just (mis)use the arch specific data in
struct device instead. I'm afraid that solution wastes memory since
the data will only be used for platform devices anyway. So I prefer
adding arch specific data to struct platform_device instead of struct
device if possible.

Maybe there are better ways to solve this? I think arch specific data
in struct platform_device is pretty straight forward though.

Thanks,

/ magnus
