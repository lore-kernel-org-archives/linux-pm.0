From: david@lang.hm
Subject: Re: Power Management framework proposal
Date: Mon, 23 Jul 2007 11:19:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707231114230.3828__44356.6004200422$1185214882$gmane$org@asgard.lang.hm>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm>
	<1185091022.19678.28.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707220057210.6350@asgard.lang.hm>
	<1185105911.29238.43.camel@localhost.localdomain>
	<Pine.LNX.4.64.0707221156210.6350@asgard.lang.hm>
	<1185145766.2714.27.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707221914550.6350@asgard.lang.hm>
	<1185162647.2714.35.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707222054060.6350@asgard.lang.hm>
	<1185164357.2714.49.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0707222207210.6350@asgard.lang.hm>
	<1185199929.2714.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1185199929.2714.54.camel@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: "ext linux-pm-bounces@lists.linux-foundation.org" <linux-pm-bounces@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 23 Jul 2007, Arjan van de Ven wrote:

> On Sun, 2007-07-22 at 22:25 -0700, david@lang.hm wrote:
>>>>
>>>> only if the transitions don't cost anything significant,
>>>
>>> these are second order effects though. On a pc, the transition costs are
>>> quite low (as I said, single or low double digit microseconds).
>>
>> including pausing all drivers before the transition and unpausing them
>> aftrwords?
>
> on a PC you don't need to do that.

that's not what the OWAP documentation I was told to read said. it 
specificly lists a requirement to pause drivers before the clock change 
and unpause them afterwords.

>>> this works for all systems where the idle power is more lower than the
>>> power you save by dropping speed... and that is almost all of them in
>>> the PC world.
>>
>> if you can idle the system as a whole I agree with you fully. most PC
>> hardware (including the mobile stuff) doesn't change it's power
>> consumption much with load.
>
> even if the rest of the PC is unchanging (which it's not), it is just an
> offset to both sides of the equation, and the same on both sides at
> that.

but a constant added to both sides makes the relative savings less.

>>  at Usenix there was a presentiation (I don't
>> remember if it was by Amazon or Google) about this subject, showing that
>> current PC hardware only goes down to 50% power when idle (short of
>> switching power modes) and that they and other big companies were pushing
>> vendors to improve their hardware, aiming to get the idle power down to
>> 10% (again without suspending anything). so there's some chance that this
>> will change before too long.
>
> on servers and such, there is a huge offset, sure, but still the effect
> is there. And it really isn't 50%.

their measurements and graphs say otherwise.

>>> now you can argue that 0.5 seconds is a really really long time, and
>>> you'd be right. so for really really short stints (say a timer
>>> interrupt) you don't want to change the voltage at all (nor would
>> you
>>> want to change the plls to change frequency for that matter). But
>> once
>>> you start chaning those, you might as well go full speed.
>>
>> this assumes that you can cache 1 second of video, if you have more
>> real-time requirements you have a much harder time (say video
>> confrancing
>> where you don't get the frame until just before you need to display
>> it)
>
> the same basic math holds for just 1 frame at a fixed rate. At some
> point transition costs will get you (and that's where things like
> ondemand delayed speedup will save us); but to get back to your
> interface, the interface doesnt nearly give the info needed to make
> these decisions...

what is it missing?

it lets you find out what modes are avialable and (in relative terms) how 
much capability and power is available in each mode

it lets you find out what the transition costs are from any mode to any 
other mode

David Lang
