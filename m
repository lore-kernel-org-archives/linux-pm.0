From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 03:03:15 +0300
Message-ID: <45FF24C3.1000203@gmail.com>
References: <44ECFF94.3030506@gmail.com>
	<200703161103.12333.david-b@pacbell.net>
	<45FDA040.4020502@gmail.com>
	<200703182104.27555.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703182104.27555.david-b@pacbell.net>
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
> On Sunday 18 March 2007 1:25 pm, Dmitry Krivoschekov wrote:
>>
>> Sometimes it's quite reasonable to make decisions (or policy)
>> at the low level, without exposing events to higher layers,
>
> Of course.  Any layer can incorporate a degree of policy.
But users should be able to choose to use or do not use the incorporated
policy, shouldn't they?
>
> It's only when that's badly done -- or the problem is so complex
> that multiple policies need to be supported -- that you need to
> pull out that old "mechanism not policy" chestnut, and support
> some kind of policy switching mechanism (governors, userspace
> agents, etc) for different application domains.
>
>
>> e.g. turning a clock off when reference counter gets zero, this is
>> what OMAP's clock framework currently does.
>
> There are no choices to be made in that layer; it's no more "policy"
> than following the laws of arithmetic is "policy".  Software clock
there is some principle: "turn the clock off when use counter reaches
zero",
so it is a policy, and a choice is to disable or not to disable an
output clock,
it is the simplest case but it's certainly a policy.  And there is no API
to enable/disable the policy that could be useful in some cases.
> gating is what the clock framework is defined as doing; there's
> nothing OMAP-specific about that.
Yes, OMAP's code just a pioneer with that.
>
> The interesting bit for OMAP is that clock gating will often be done
> in hardware, not just in software.  =

Yes, but you are free to disable the feature.
> There are other low-power SOC
> designs that do such things, =

Recent PXAs, i.MX31 are capable for  that. There are also more exotic
examples of hardware PM awareness,  e.g.  i.MX31 chip supports
DVFS that can totally be performed  in hardware i.e.
processor adjusts its clock and voltage basing on current processor
workload.


Thanks,
Dmitry
