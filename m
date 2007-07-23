From: david@lang.hm
Subject: Re: Power Management framework proposal
Date: Sun, 22 Jul 2007 22:25:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707222207210.6350__4899.61593780226$1185168487$gmane$org@asgard.lang.hm>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1185164357.2714.49.camel@laptopd505.fenrus.org>
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

On Sun, 22 Jul 2007, Arjan van de Ven wrote:

> On Sun, 2007-07-22 at 21:04 -0700, david@lang.hm wrote:
>
>>>> this strategy should work well on the normal unpredictable workload that
>>>> most people deal with, but there are some cases where the workload becomes
>>>> pretty predictable (media players for example) where there really is less
>>>> variation, and a need for a constant availability of the cpu, so it may
>>>> actually save a smidge of power to run below the highest freq that the
>>>> voltage allows rather then running faster and being idle more cycles.
>>>
>>> that actually is the example showcase of race-to-idle where you
>>> absolutely want to run at the highest frequency..
>>
>> only if the transitions don't cost anything significant,
>
> these are second order effects though. On a pc, the transition costs are
> quite low (as I said, single or low double digit microseconds).

including pausing all drivers before the transition and unpausing them 
aftrwords?

>> and the
>> computation capacity per watt of power is the same at all frequencies. the
>> chip performance numbers I've been seeing (which I admit are mostly
>> embedded datasheets) indicate that neither of these hold true.
>
> let me give you a real world example then, and the numbers I'm using are
> ballpark the same as you'll find in a (mobile) core 2 duo datasheet, I
> just rounded them a little so that the math works out nice.
>
> power at full speed: 34W
> power at half speed: 24W
> power at idle: 1W

are these numbers for the CPU itself or for the a larger chunk? I could 
easily see these numbers for motherboard (including CPU and RAM), but it 
would surprise me if these numbers are for the CPU itself. I'm used to 
seeing datasheets that have a much more linear voltage/freq (and therefor 
a quadratic voltage/power) curve. in some cases the voltage requirements 
drop faster then the frequency.

> assume media playback, and a dumb one, that takes half a second to
> decode a second of media. (again to make the math simple)
>
> at half speed: Energy for a second is 0.5 * 24 + 0.5 * 1 = 12.5 J
> at full speed: Energy for a second is 0.25 * 34 + 0.75 * 1 = 9.25 J
>
> this works for all systems where the idle power is more lower than the
> power you save by dropping speed... and that is almost all of them in
> the PC world.

if you can idle the system as a whole I agree with you fully. most PC 
hardware (including the mobile stuff) doesn't change it's power 
consumption much with load. at Usenix there was a presentiation (I don't 
remember if it was by Amazon or Google) about this subject, showing that 
current PC hardware only goes down to 50% power when idle (short of 
switching power modes) and that they and other big companies were pushing 
vendors to improve their hardware, aiming to get the idle power down to 
10% (again without suspending anything). so there's some chance that this 
will change before too long.

> now you can argue that 0.5 seconds is a really really long time, and
> you'd be right. so for really really short stints (say a timer
> interrupt) you don't want to change the voltage at all (nor would you
> want to change the plls to change frequency for that matter). But once
> you start chaning those, you might as well go full speed.

this assumes that you can cache 1 second of video, if you have more 
real-time requirements you have a much harder time (say video confrancing 
where you don't get the frame until just before you need to display it)

David Lang
