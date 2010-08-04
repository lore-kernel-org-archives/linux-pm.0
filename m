From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH/RFC] Runtime PM: ARM: subarch-specific
	extensions of pdev_archdata
Date: Wed, 4 Aug 2010 12:56:17 +0900
Message-ID: <AANLkTi=RTigcf-p=GFncAQ2ZjP=4qjDPXjnMmTO_u6tL__35838.1834267222$1280894282$gmane$org@mail.gmail.com>
References: <1253670648-28610-1-git-send-email-khilman@deeprootsystems.com>
	<f17812d70909222153y4a0e4fc2n496ea2e6caaac847@mail.gmail.com>
	<19129.63264.653666.70492@pilspetsen.it.uu.se>
	<4ABAAF1D.6090907@deeprootsystems.com>
	<f17812d70909231630i20f64328k8d604c3436094b85@mail.gmail.com>
	<87k4yhagv4.fsf@deeprootsystems.com>
	<AANLkTinBqc11oE2SOmvXbFHmlgvZ21LngXNWkSHiJmRK@mail.gmail.com>
	<34dc79dc-0868-4401-9fa5-c7134f6d4485@email.android.com>
	<AANLkTikHUcgBcTmv+=NrYMwgn-UC_Q0Vv3ytfuJbkyRB@mail.gmail.com>
	<87k4o7r7sv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87k4o7r7sv.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-pm@lists.linux-foundation.org, Mikael Pettersson <mikpe@it.uu.se>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 4, 2010 at 1:16 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Magnus Damm <magnus.damm@gmail.com> writes:
>> On Sun, Jul 25, 2010 at 5:24 AM, Grant Likely <grant.likely@secretlab.ca=
> wrote:
>>> "Magnus Damm" <magnus.damm@gmail.com> wrote:
>>>>On Tue, Oct 27, 2009 at 8:13 AM, Kevin Hilman
>>>><khilman@deeprootsystems.com> wrote:
>>>>> Eric Miao <eric.y.miao@gmail.com> writes:
>>>>>> On Thu, Sep 24, 2009 at 7:28 AM, Kevin Hilman
>>>>>> <khilman@deeprootsystems.com> wrote:
>>>>>>> Mikael Pettersson wrote:
>>>>>>>> Eric Miao writes:
>>>>>>>> =A0> On Wed, Sep 23, 2009 at 9:50 AM, Kevin Hilman
>>>>>>>> =A0> <khilman@deeprootsystems.com> wrote:
>>>>>>>> =A0> > On ARM platforms, power management can be very platform spe=
cific.
>>>>>>>> =A0> > This patch allows ARM subarches to extend the platform_devi=
ce
>>>>>>>> =A0> > pdev_archdata for each subarch by creating a new struct pde=
v_machdata
>>>>>>>> =A0> > and allowing each subarch to customize it as needed.
>>
>>>>Do you remember what happened with this patch?
>>>
>>> I don't have all the details in front of me because I'm on my phone,
>>> but I advised against pdev_archdata because it is
>>> multiplatform-unfriendly.
>>
>> Ok, I did not expect that. =3D) But after thinking a bit it does make
>> sense. I wonder what my options are. I'm not so fond of the idea to
>> wrap the platform devices - that's not more multi-platform friendly,
>> is it?
>
> [sorry for the lag, been on vacation]
>
> Wrapping is more multi-platform friendly because only platform-specific
> code accesses the wrapped code. =A0It's also logically consistent as
> a struct device is contained by a platform_device which is then
> contained by an omap_device (in our case.) =A0 Only OMAP-specific code
> ever knows about or touches that layer.

Sure, as long as all platform devices are wrapped into omap_device
then I see no problem. I guess my worries are about mixing platform
devices and omap_device on the same system. The answer to that may
simply be "don't". =3D)

For the mixed case my main concern is the use of to_omap_device() on a
struct platform device which may or may not be an omap_device. You
have your magic check in omap_device_is_valid() so i guess that's ok,
but compared to the rest of the driver model this extended level of
wrapping does not come with any pointer for class/type/bus. Platform
devices all use the platform_bus_type symbol for device->bus, so in
theory it's possible to check the bus type before going from struct
device to struct platform_device using to_platform_device(). In the
wrapped platform device case you first have to speculate using
container_of() and then check for magic. Seems a bit hackish to me. I
prefer the other way around, check wrapping type first then use
container_of().

I guess the question is if it's really needed to differentiate between
platform devices and omap devices, and I guess the only place where it
may be a problem is the runtime pm code. Perhaps thanks to the weak
symbols, sorry about that...

>> How about using devres and platform bus notifiers?
[snip]

> Your patches look multi-platform friendly, but there are still some
> outstanding issues with making runtime PM support multi-platform
> friendly that are not direclty related to the above patches.

I agree!

> 1) weak symbols
>
> We need to change the overriding of weak symbols into some form of
> register/unregister so multiple platforms in the same kernel could work.
> That's the easy one.

Yeah. Perhaps it's possible to reuse part of the pm_generic_... functions.

> 2) custom vs. platform bus.
>
> The other issue under discussion between Grant & myself[1] has been the
> use of a custom bus instead of the platform bus. =A0Following your lead,
> (and preferring that option) I continued to use the platform_bus since
> I only need to override a few of the dev_pm_ops functions.
>
> However, Grant is not happy about overriding the platform_bus. =A0He would
> rather see each platform create a custom bus with it's own PM methods.
>
> In this thread[1], I did a quick and dirty proof of concept to show that
> it is possible, but quite frankly, I still much prefer continuing to use
> the platform_bus since it is mostly identical.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/01892=
5.html

Thanks for the pointer. I've been thinking of using a custom bus as
well, but from my point of view it's always looked like a lot of
coding without any clear benefit. I understand the idea of wanting to
use a single binary on a wide range of systems, and solving that seems
like a good plan.

I'm not sure if a custom bus is the best idea. I wouldn't mind being
able to create platform bus instances though. Or custom buses using
some kind of platform bus library. A lot of drivers use the platform
bus, so there has to be a very good reason to move away from that IMO.
A new bus type seems a bit overkill to me though, what we need from my
point of view is:

1) Mach/Plat hardware configuration data for platform devices
-> Can be kept in struct pdev_archdata (clock and power domain configuratio=
n)
-> Can be kept in a wrapped structure (clock and power domain configuration)
-> Use clkdev tables to handle the device name to clock translation
-> Power domain configuration without wrapping/pdev_archdata, not sure

2) Mach/Plat runtime data for each platform device
-> Data can be kept in the wrapped data structure or struct pdev_archdata
-> Could be solved by bus notifiers and dynamic allocation using devres

3) Mach/Plat specific runtime PM
-> Need to move away from weak symbols to register/unregister interface
-> Struct pdev_archdata could perhaps point out a per-mach/plat dev_pm_ops?

Any ideas?

Cheers,

/ magnus
