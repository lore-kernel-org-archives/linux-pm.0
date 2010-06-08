From: Mike Chan <mike@android.com>
Subject: Re: PM QoS dynamic resource manager
Date: Tue, 8 Jun 2010 16:35:58 -0700
Message-ID: <AANLkTimK_RwRZHcEIxSshovgQLM6SBo2kLVoxWoEFFjx@mail.gmail.com>
References: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>
	<20100525145223.GA4974@gvim.org>
	<AANLkTikLgu2c1GPE3glHLlaznOM59SVeCj2NHzDjyjZR@mail.gmail.com>
	<20100608033333.GA23066@gvim.org>
	<AANLkTinGBvZm870CsjocsCV1SmQ-FCCbJLtKWR1juB1Q@mail.gmail.com>
	<4C0ECC38.2000003@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C0ECC38.2000003@codeaurora.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bryan Huntsman <bryanh@codeaurora.org>
Cc: linux-pm@lists.linux-foundation.org, mark gross <640e9920@gmail.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 8, 2010 at 4:03 PM, Bryan Huntsman <bryanh@codeaurora.org> wrot=
e:
>>> http://lkml.org/lkml/2010/4/22/213 =A0(I guess the details are in the
>>> archives) =A0I'm happy to re-visit it.
>>>
>>
>> Interesting patch, it looks like having a "system wide bus" doesn't
>> easily apply to msm and tegra platforms.
>> An example of some things I would like to be able to control are i2c
>> and memory bus.
>>
>> I'm tempted to suggest adding two types memory and i2c but I'm not
>> sure how future proof this will be given the growing complexity in the
>> embedded hardware road-map.
>> What about the possibility of registering not one but several buses?
>> You could add a bus qos param, with a type enum, or bind to some
>> platform_driver or bus_driver
>>
>> Then there's the issue of having to deal with platform specific buses,
>> do you add this type to pm qos with only one user? Or have some
>> platform bus types defined somewhere. The generic code of min / max
>> for resource X can be useful so everyone doesn't spin their own
>> resource framework in their own architecture.
>>
>> -- Mike
>
> Mike, one idea I'm exploring is having platform-specific busses with QoS
> constraints specified via runtime_pm as part of the LDM. =A0Adding dynamic
> class creation within pm_qos, or a type enum as you suggest, would work.
> =A0However, I think this kind of behavior would fit nicely within runtime=
_pm.
>

I'm not too familiar with the current work in runtime pm and LDM.
However platform specific buses sounds like a good thing, at least
more future proof. This works in the embedded SOC world but I'm
wondering what happens when you have re-configurable hardware and now
your same peripheral is sourcing a different bus?

Does runtime pm hook into pm qos similar to how cpuidle uses pm qos?
So the platform-specific buses would be aa pm rumtime or a pm qos
addition?

-- Mike

> - Bryan
>
