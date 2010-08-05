From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH/RFC] Runtime PM: ARM: subarch-specific
	extensions of pdev_archdata
Date: Thu, 5 Aug 2010 12:07:53 +0900
Message-ID: <AANLkTimUeFf_Z5pi3x7PWNb0YpooxPb3aN1cmtv1XjQx__8475.15866994417$1280977728$gmane$org@mail.gmail.com>
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
	<AANLkTi=RTigcf-p=GFncAQ2ZjP=4qjDPXjnMmTO_u6tL@mail.gmail.com>
	<AANLkTintoVDFHxmbuj_YHj5e4PzK7j6-SzdWqFKDLjkE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTintoVDFHxmbuj_YHj5e4PzK7j6-SzdWqFKDLjkE@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-pm@lists.linux-foundation.org, Mikael Pettersson <mikpe@it.uu.se>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 5, 2010 at 8:10 AM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Tue, Aug 3, 2010 at 9:56 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> On Wed, Aug 4, 2010 at 1:16 AM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> 2) custom vs. platform bus.
>>>
>>> The other issue under discussion between Grant & myself[1] has been the
>>> use of a custom bus instead of the platform bus. =A0Following your lead,
>>> (and preferring that option) I continued to use the platform_bus since
>>> I only need to override a few of the dev_pm_ops functions.
>>>
>>> However, Grant is not happy about overriding the platform_bus. =A0He wo=
uld
>>> rather see each platform create a custom bus with it's own PM methods.
>>>
>>> In this thread[1], I did a quick and dirty proof of concept to show that
>>> it is possible, but quite frankly, I still much prefer continuing to use
>>> the platform_bus since it is mostly identical.
>>>
>>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/018=
925.html
>>
>> Thanks for the pointer. I've been thinking of using a custom bus as
>> well, but from my point of view it's always looked like a lot of
>> coding without any clear benefit. I understand the idea of wanting to
>> use a single binary on a wide range of systems, and solving that seems
>> like a good plan.
>>
>> I'm not sure if a custom bus is the best idea. I wouldn't mind being
>> able to create platform bus instances though.
>
> The only problem with multiple platform_bus instances would be that
> drivers intended to work on both would need to be registered twice;
> once on the regular platform bus, and once on the custom bus. =A0All the
> rest of the code would be shared, but it probably still doesn't
> reflect the model that you're shooting for.

Do they really have to be registered twice? With the current driver
model yes, but perhaps it's possible to adjust the platform bus to
allow device<->driver matching across buses somehow. I would prefer to
register drivers only once.

> However, on the flipside the question must be asked; are you trying to
> describe inherent bus-type behaviour that the plaform bus does not
> address? =A0ie. is the OMAP bus fundamentally different from a normal
> 'dumb' bus? =A0What is the real count of device drivers that will need
> to be registered on the platform bus and the omap bus (or sh, etc)? =A0A
> modified platform bus type instance may require duplicate driver
> registrations, but it is also potentially a lot less complex for a
> reader to understand what is going on (ie. the runtime-pm calls are
> explicit instead of being indirect through a bus notifier).

I suspect that Runtime PM is the main reason why people all of a
sudden need to extend the platform bus. =3D)

>> Or custom buses using
>> some kind of platform bus library. A lot of drivers use the platform
>> bus, so there has to be a very good reason to move away from that IMO.
>> A new bus type seems a bit overkill to me though, what we need from my
>> point of view is:
>
> bus types are cheep, especially when the code is shared.

Agreed!

>> 1) Mach/Plat hardware configuration data for platform devices
>> -> Can be kept in struct pdev_archdata (clock and power domain configura=
tion)
>
> Careful. =A0putting mach/plat specific stuff into pdev_archdata is
> multiplatform unfriendly. =A0I think pdev_archdata should be restricted
> to arch-specific stuff.

Not sure if it has to be multiplatform-unfriendly. You could have one
structure per mach/plat inside pdev_archdata. That aside, code and
data should of course be shared as much as possible.

>> -> Can be kept in a wrapped structure (clock and power domain configurat=
ion)
>> -> Use clkdev tables to handle the device name to clock translation
>> -> Power domain configuration without wrapping/pdev_archdata, not sure
>>
>> 2) Mach/Plat runtime data for each platform device
>> -> Data can be kept in the wrapped data structure or struct pdev_archdata
>> -> Could be solved by bus notifiers and dynamic allocation using devres
>>
>> 3) Mach/Plat specific runtime PM
>> -> Need to move away from weak symbols to register/unregister interface
>> -> Struct pdev_archdata could perhaps point out a per-mach/plat dev_pm_o=
ps?
>
> registerable per-mach/plat ops structures sound sane. =A0However, I
> think we can do better since this is not an arch-specific problem.
> Already ARM and SH needs a solution, and I can see it being applicable
> to the other embedded archs too. =A0I'd like to see a non-arch-specific
> solution.

Yes, a more generic solution would be nice!

Cheers,

/ magnus
