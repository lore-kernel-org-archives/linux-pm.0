From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 17:58:31 +0300
Message-ID: <45FFF697.8080101@gmail.com>
References: <44ECFF94.3030506@gmail.com>	
	<200703182104.27555.david-b@pacbell.net>
	<45FF24C3.1000203@gmail.com>	
	<200703200107.17290.david-b@pacbell.net>
	<45FFAD39.1000302@gmail.com>	
	<1174386620.25744.23.camel@Dogbert.NOE.nokia.com>	
	<45FFDCA3.5060007@gmail.com>
	<1174398759.25744.69.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174398759.25744.69.camel@Dogbert.NOE.nokia.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: linux-pm@lists.osdl.org, Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Igor Stoppa wrote:
> On Tue, 2007-03-20 at 16:07 +0300, ext Dmitry Krivoschekov wrote:
>> Igor Stoppa wrote:
>>> On Tue, 2007-03-20 at 12:45 +0300, ext Dmitry Krivoschekov wrote:
>>>> David Brownell wrote:
>>>>> On Monday 19 March 2007 5:03 pm, Dmitry Krivoschekov wrote:
>>>>>> David Brownell wrote:
>>>>>>> On Sunday 18 March 2007 1:25 pm, Dmitry Krivoschekov wrote:
>>>>>>>> Sometimes it's quite reasonable to make decisions (or policy)
>>>>>>>> at the low level, without exposing events to higher layers,
>>>>>>> Of course.  Any layer can incorporate a degree of policy.
>>>>>> But users should be able to choose to use or do not use the incorpor=
ated
>>>>>> policy, shouldn't they?
>>>>> Sometimes.  What's a user? =

>>>> It's a user of a kernel subsystem that (subsystem ) keeps a policy,
>>>> i.e. a user it's another kernel subsystem or userspace application,
>>>> it depends on implementation of a system.
>>>>>  Do you really expect every single
>>>>> algorithm choice to be packaged as a pluggable policy?  =

>>>> I didn't say pluggable policy, I just said there are must be
>>>> an alternative - "use" or "do not use" a predefined policy.
>>>> For example, in USB you are able to enable/disable autosuspend rule,
>>>> don't know if it's possible to disable it at runtime though.
>>>>> Any
>>>>> time I've seen systems designed that way, those pluggabilty
>>>>> hooks have been a major drag on performance and maintainability.
>>>>>
>>>>> Most components don't actually _need_ a choice of policies.
>>>>>
>>>>>
>>>> Yes, but they at least need a mechanism to disable an associated polic=
y,
>>>> upper layers should be able to decide where the policy well be kept,
>>>> they may delegate the keeping to lower layers but also may want to
>>>> keep the policy themselves for some reason.
>>> That sounds more like it's driven by IP than by technical reasons.
>> Linux - Operating system, the key word is "system", doing things on
>> one layer you have to think how it is refleceted to other layers, so
>> here are not bare technical questions.
>>> Anyway in the USB example mentioned the rule is very high level, =

>> What level can be lower than driver level?
> Enable/disable autosuspend is certainly higher level command than
> forcing a clock that a driver is using.
Please re-read what you wrote, "Anyway in the USB example mentioned the
rule is very high level",
by the rule I assume "suspend a device if it doesn't need for USB
interface for now",  I didn't consider
enabling/disabling the rule itself here.
>> I agree, USB stack consist of a number of drivers but all of them
>> belongs to one, USB, subsystem, more precisely USB host subsystem
>> (considering the case with AUTOSUSPEND)
>>
>> Driver level is serving the lowest level - interacting with particular
>> system device, while layer serving system clocks is higher by default
>> since clocks are usually distributed for several devices  in the system,
>> and you need a common knowledge then. Putting the knowledge to driver
>> layer means duplicating of the knowledge for each driver.
> I really can't immagine how you have read this into what i wrote.
Just think of that then, I don't insist though :)
>
>>> while
>>> here the proposal is to meddle with the internals of a driver.
>>> It seems more logical to implement policies/rules at driver level,
>>> rather than going straight for the resources of the driver.
>>>
>>> Why can't the driver itself be able to translate whatever high-level
>>> command/hint it receives into the platform/arch/board specific actions?
>> Assuming we consider normal device driver, because it needs to coordinate
>> actions with a number of other drivers in this case, and also for the re=
ason
>> I mentioned  in previous comment.
>>
>> And you should definitely read the first chapter of the "Linux Device
>> drivers" book,
>> see "The Role of the Device Driver" section.
> I'll try to reformulate, so maybe this time you won't jump to such funny
> conclusions:
It's not a conclusion it's a suggestion, there you may find explanations
what is wrong
with delegating policies to device drivers.
> case 1-you are speaking in favour of a framework where policies can
> orchestrate system level decisions by having a strict control on every
> shared resource
I personally don't favor any approach I just want to sort out advantages
and disadvantages
of every approach.
> case 2-i'm saying that it is simpler to rely on drivers doing their job,
What criteria do you use to accept one approach is simpler than another?
> as they are doing right now, on OMAP, at least, of releasing resources
Did you think of other archs?
> when not needed. Based on this default behavior, there might be certain
> cases when a system-level manager can interact with them by making the
the system-level manager has to be arch-dependent in this case
> _localised_ power saving less aggressive, thus optimiising the global
> saves/performance. So if others than you are happy with just the
> distributed approach, they can avoid using the framework, while you can
> just put it on top and achive the same power saving that you would get
> in case 1
Ok, seems you are happy with current clock framework and advocating it
to be as is.
Are you against addition some features to it, such as enable/disable =

"turn the unused clock off"
rule, set/get state of  associated  clock device  (to control low power
modes of the clock device itself)?
Besides that it is meaningless for you, do you have any technical
objections for that?


Thanks,
Dmitry
