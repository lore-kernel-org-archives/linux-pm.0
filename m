From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 15:13:56 +0300
Message-ID: <45FFD004.9030507@gmail.com>
References: <44ECFF94.3030506@gmail.com>	
	<200703182104.27555.david-b@pacbell.net>
	<45FF24C3.1000203@gmail.com>	
	<200703200107.17290.david-b@pacbell.net>
	<45FFAD39.1000302@gmail.com>
	<1174386620.25744.23.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174386620.25744.23.camel@Dogbert.NOE.nokia.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Igor Stoppa <igor.stoppa@Nokia.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Igor Stoppa wrote:
> On Tue, 2007-03-20 at 12:45 +0300, ext Dmitry Krivoschekov wrote:
>> David Brownell wrote:
>>> On Monday 19 March 2007 5:03 pm, Dmitry Krivoschekov wrote:
>>>> David Brownell wrote:
>>>>> On Sunday 18 March 2007 1:25 pm, Dmitry Krivoschekov wrote:
>>>>>> Sometimes it's quite reasonable to make decisions (or policy)
>>>>>> at the low level, without exposing events to higher layers,
>>>>> Of course.  Any layer can incorporate a degree of policy.
>>>> But users should be able to choose to use or do not use the incorporat=
ed
>>>> policy, shouldn't they?
>>> Sometimes.  What's a user? =

>> It's a user of a kernel subsystem that (subsystem ) keeps a policy,
>> i.e. a user it's another kernel subsystem or userspace application,
>> it depends on implementation of a system.
>>>  Do you really expect every single
>>> algorithm choice to be packaged as a pluggable policy?  =

>> I didn't say pluggable policy, I just said there are must be
>> an alternative - "use" or "do not use" a predefined policy.
>> For example, in USB you are able to enable/disable autosuspend rule,
>> don't know if it's possible to disable it at runtime though.
>>> Any
>>> time I've seen systems designed that way, those pluggabilty
>>> hooks have been a major drag on performance and maintainability.
>>>
>>> Most components don't actually _need_ a choice of policies.
>>>
>>>
>> Yes, but they at least need a mechanism to disable an associated policy,
>> upper layers should be able to decide where the policy well be kept,
>> they may delegate the keeping to lower layers but also may want to
>> keep the policy themselves for some reason.
> That sounds more like it's driven by IP than by technical reasons.
> Anyway in the USB example mentioned the rule is very high level, while
> here the proposal is to meddle with the internals of a driver.
> It seems more logical to implement policies/rules at driver level,
> rather than going straight for the resources of the driver.
> =

> Why can't the driver itself be able to translate whatever high-level
> command/hint it receives into the platform/arch/board specific actions?

I guess you are confusing two things here.

There are pm resources which are solely used by one linux device driver onl=
y. =

Such pm resources are not supposed to be under control of power parameter =

framework we are talking about. Indeed, a linux device driver controls such=
 pm =

resources
a) by itself
and
b) based on knowledge internal to the driver or translating whatever high-l=
evel =

command/hint it receives.

However there is another type of pm resources - pm resources shared by seve=
ral =

drivers. Such drivers of course do not know about each other and can't know =

which state of the pm resource in question is the best at the moment from t=
he =

_whole_ _system_ point of view. In this case implementation of control of s=
uch a =

pm resource via hinting in some way both drivers seems to me neither =

reasonable/practical nor feasible.

IMO autoidle (a state(s) hw puts a resource to without any sw interaction) =
as a =

particular control case for such pm resources is out of scope of a particul=
ar =

driver as well.

So, in my thinking a devoted entity should exist to deal with such question=
s in =

regard to such shared pm resources. This entity is policy manager. Thus I s=
ee a =

need in an API for policy managers to be presented.
> =

> =

>> Also, in some cases it is reasonable to adjust rules of a policy
>> (without changing the policy). For example if you define a policy
>> "keep an output frequency always for 33 MHz (an input frequency may vary=
)",
>> you may want to change the base frequency to 66 MHz sometimes.
>>
>>
>>>>> It's only when that's badly done -- or the problem is so complex
>>>>> that multiple policies need to be supported -- that you need to
>>>>> pull out that old "mechanism not policy" chestnut, and support
>>>>> some kind of policy switching mechanism (governors, userspace
>>>>> agents, etc) for different application domains.
>>>>>
>>>>>
>>>>>> e.g. turning a clock off when reference counter gets zero, this is
>>>>>> what OMAP's clock framework currently does.
>>>>> There are no choices to be made in that layer; it's no more "policy"
>>>>> than following the laws of arithmetic is "policy".  Software clock
>>>> there is some principle: "turn the clock off when use counter reaches
>>>> zero", so it is a policy, and a choice is to disable or not to disable
>>>> an output clock, it is the simplest case but it's certainly a policy. =

>>> That's not a choice; it's how the API is defined.  It's not "policy".
>>>
>>> Arithmetic is defined so that 2 + 2 =3D=3D 4.  Should we have a "policy"
>>> allowing it to =3D=3D 5 instead?  Or should we just accept that as how
>>> things are defined, and move on?
>> We should accept this if we agree that benefit of using the rule always
>> exist,
>> but if the rule constrain some functionality we may want to disable the
>> rule.
>> Considering the case with clocks,  we may want  to leave the clock runni=
ng
>> even if there is no users of the clock, but there is a timing constraint
>> for readiness  of  a clock device  (PLLs can't be started immediately).
> =

> I find that a bogus example.
> It seems like you are generalising clock handling based on PLLs.

No. We are designing generic framework for various types of pm resources =

provided by currently available hw. Already today we know about such cases =
as =

PLLs. Please remember that we are approaching voltages as well and I hope y=
ou =

agree that voltage regulators also fit in this example as switching a volta=
ge =

incurs latencies.

> The PLL is actually the exception, having a penalty in commuting between
> states, while all the children can be toggled on/off without any delay.
> And that's easy to deal with: if a driver is going to do something that
> could be affected by the PLL automatically going off, the driver can
> avoid releasing its clock. That will effectively keep the PLL on.

It's just about preventing effective power management. A particular driver =
does =

not have all necessary knowledge/information on what is the most efficient =
at =

the moment in regard to _system_ power management. Not releasing a clock/vo=
ltage =

which is not in use by the driver at the moment (and what more important in =

generic case the driver has no clue on when it will start to use it again) =
just =

prevents an upper layer (policy manager) from capability to perform effecti=
ve =

power management.

> =

> The PLL per se is not really significant, apart from the fact that it
> tatkes power and it's desirable to keep it off for as long as possible,
> but the important bit is that the drivers must have the clock ready and
> available when needed.

Indeed we may want to think about that a driver may want to export requirem=
ents =

on what expected latencies for pm_resource_get() are. But again, a particul=
ar =

driver can;t perform such a decision internally for shared pm resources.

Eugeny

> =

> A similar approach can be used for frequencies: if a driver periodically
> needs a certain high frequency, it might be impacted by the system
> automatically scaling voltage/frequence.
> =

> Possible solutions?
> -keep the request for high frequency
>   if a pll relock is involved in the scaling
> =

> -keep the request for high voltage
>   if there is no significant delay from a possible pll relock or no
> relock at all, but significant ramp-up time for the voltage regulator
> =

> These actions could be performed by the driver either autonomously or
> based on hints/commands receivied from upper layers, in the form of
> driver specific commands.
