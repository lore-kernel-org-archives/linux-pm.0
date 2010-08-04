From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH/RFC] Runtime PM: ARM: subarch-specific
	extensions of pdev_archdata
Date: Wed, 4 Aug 2010 16:54:59 -0600
Message-ID: <AANLkTinv2ZpLaRYEN+FVwuX1QTK_+568K8BckVp_tx=K__43766.1018957899$1280962737$gmane$org@mail.gmail.com>
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
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-pm@lists.linux-foundation.org, Mikael Pettersson <mikpe@it.uu.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 3, 2010 at 10:16 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Magnus Damm <magnus.damm@gmail.com> writes:
>
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

(I just noticed this; will also reply on the other thread so it is
recorded in the public record) But it is also really dangerous;
particularly in the case of dynamically allocated platform_devices.
When handed a random platform_device pointer, you have absolutely *no*
idea whether or not it is valid to dereference a pointer at a lower
address from the platform_device pointer.  It is very likely that
there will be other code in the system that will register
platform_devices without the omap_device wrapper.

>> How about using devres and platform bus notifiers?
>
> That seems fine too, and probably better if the amount of data/code you n=
eed
> is small. =A0In the OMAP case, it's rather complicated so it's cleaner
> IMHO to keep it in a separate omap_device layer and struct.

but it is safe

>> For a Runtime PM prototype using devres (instead of pdev_archdata or
>> wrapping) look here:
>> https://patchwork.kernel.org/patch/113605/
>>
>> To make it work with modules I propose adding a driver bind event:
>> https://patchwork.kernel.org/patch/113865/
>>
>> Looks pretty multi-platform friendly to me. Any suggestions?
>
> Your patches look multi-platform friendly, but there are still some
> outstanding issues with making runtime PM support multi-platform
> friendly that are not direclty related to the above patches.
>
> 1) weak symbols
>
> We need to change the overriding of weak symbols into some form of
> register/unregister so multiple platforms in the same kernel could work.
> That's the easy one.
>
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

I quite possibly could be convinced that the devres approach is the
RightThing to do.  It neatly sidesteps the issue I see with the
omap_device container approach.  I'd need to see a prototype to be
sure.

Cheers,
g.
