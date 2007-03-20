From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 12:45:29 +0300
Message-ID: <45FFAD39.1000302@gmail.com>
References: <44ECFF94.3030506@gmail.com>
	<200703182104.27555.david-b@pacbell.net>
	<45FF24C3.1000203@gmail.com>
	<200703200107.17290.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703200107.17290.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> On Monday 19 March 2007 5:03 pm, Dmitry Krivoschekov wrote:
>> David Brownell wrote:
>>> On Sunday 18 March 2007 1:25 pm, Dmitry Krivoschekov wrote:
>>>> Sometimes it's quite reasonable to make decisions (or policy)
>>>> at the low level, without exposing events to higher layers,
>>> Of course.  Any layer can incorporate a degree of policy.
>> But users should be able to choose to use or do not use the incorporated
>> policy, shouldn't they?
>
> Sometimes.  What's a user? =

It's a user of a kernel subsystem that (subsystem ) keeps a policy,
i.e. a user it's another kernel subsystem or userspace application,
it depends on implementation of a system.
>  Do you really expect every single
> algorithm choice to be packaged as a pluggable policy?  =

I didn't say pluggable policy, I just said there are must be
an alternative - "use" or "do not use" a predefined policy.
For example, in USB you are able to enable/disable autosuspend rule,
don't know if it's possible to disable it at runtime though.
> Any
> time I've seen systems designed that way, those pluggabilty
> hooks have been a major drag on performance and maintainability.
>
> Most components don't actually _need_ a choice of policies.
>
>
Yes, but they at least need a mechanism to disable an associated policy,
upper layers should be able to decide where the policy well be kept,
they may delegate the keeping to lower layers but also may want to
keep the policy themselves for some reason.

Also, in some cases it is reasonable to adjust rules of a policy
(without changing the policy). For example if you define a policy
"keep an output frequency always for 33 MHz (an input frequency may vary)",
you may want to change the base frequency to 66 MHz sometimes.


>>> It's only when that's badly done -- or the problem is so complex
>>> that multiple policies need to be supported -- that you need to
>>> pull out that old "mechanism not policy" chestnut, and support
>>> some kind of policy switching mechanism (governors, userspace
>>> agents, etc) for different application domains.
>>>
>>>
>>>> e.g. turning a clock off when reference counter gets zero, this is
>>>> what OMAP's clock framework currently does.
>>> There are no choices to be made in that layer; it's no more "policy"
>>> than following the laws of arithmetic is "policy".  Software clock
>> there is some principle: "turn the clock off when use counter reaches
>> zero", so it is a policy, and a choice is to disable or not to disable
>> an output clock, it is the simplest case but it's certainly a policy. =

>
> That's not a choice; it's how the API is defined.  It's not "policy".
>
> Arithmetic is defined so that 2 + 2 =3D=3D 4.  Should we have a "policy"
> allowing it to =3D=3D 5 instead?  Or should we just accept that as how
> things are defined, and move on?
We should accept this if we agree that benefit of using the rule always
exist,
but if the rule constrain some functionality we may want to disable the
rule.
Considering the case with clocks,  we may want  to leave the clock running
even if there is no users of the clock, but there is a timing constraint
for readiness  of  a clock device  (PLLs can't be started immediately).


Thanks,
Dmitry
