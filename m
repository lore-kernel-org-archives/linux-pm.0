From: Matthew Locke <matthew.a.locke@comcast.net>
Subject: Re: So, what's the status on the recent patches here?
Date: Tue, 29 Aug 2006 22:52:00 -0700
Message-ID: <2b520e23c76213a4954c9b97c5df7012@comcast.net>
References: <221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060815010020.GA14251@kroah.com>
	<b324b5ad0608182319y307210a3w6389c83482e43ab8@mail.gmail.com>
	<20060819184843.GB15644@redhat.com>
	<b324b5ad0608192020n6584f749h501e05e141b1f557@mail.gmail.com>
	<20060820033044.GA24928@redhat.com>
	<b324b5ad0608262137y24cfb843kb03476a22e462516@mail.gmail.com>
	<20060827154151.GA4158@ucw.cz>
	<b324b5ad0608290855h19a12a86ucfd831fcd9bab498@mail.gmail.com>
	<20060829163455.GA4821@ucw.cz>
	<b324b5ad0608292152s72a8f428wf45e9d4881bb3b5d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <b324b5ad0608292152s72a8f428wf45e9d4881bb3b5d@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


On Aug 29, 2006, at 9:52 PM, David Singleton wrote:

> On 8/29/06, Pavel Machek <pavel@ucw.cz> wrote:
>> Hi!
>>>>>         point, by name. There is a new
>>>> /sys/power/operating_points directory
>>>>>         that shows all the operating points the
>>>> system supports. An
>>>>>         exampled from my centrino laptop shows:
>>>>>
>>>>>         /sys/power/operating_points/high
>>>>>         /sys/power/operating_points/highest
>>>>>         /sys/power/operating_points/low
>>>>>         /sys/power/operating_points/lowest
>>>>>         /sys/power/operating_points/medium
>>>>>         /sys/power/operating_points/mem
>>>>>         /sys/power/operating_points/standby
>>>>
>>>> What makes you think that mixing operating and sleep
>>>> states is good
>>>> idea?
>>>
>>> They are all power states managed by the kernel and in
>>> the operating
>>> point concept they are all operating points the system
>>> supports.
>>
>> That does not make mixing them right.
>
> Both OpPoint and PowerOp are going to 'mix' frequency, voltage
> and sleep states into their operating point concepts.

PowerOP does not mix sleep states with operating points.  We are not =

pushing for integrating sleep states and operating points.  I haven't =

seen an implementation that makes sense yet.  I'm writing another email =

to address this in more detail.

>
> The point was not to make it look like I was mixing sleep states and
> CPU frequency states, but to present all the power states
> supported by the system in one place and with one interface.  It =

> simplifies
> not only kernel code, but power manager code as well.
>
>>
>>> The system can be set to any of the supported states by
>>> setting their name in the /sys/power/state file.  I find
>>> simplicity
>>> is usually a good thing.
>>
>> I believe the quote is 'make it as simple as possible but not
>> simpler'.
>>
>>>> And '600MHz' makes lot more sense than 'lowest' on
>>>> centrino.
>>>
>>> Perhaps, but the common name space makes it easy for the
>>> power manager
>>> daemon to perform the same functions without having to
>>> know that the lowest
>>> speed on my laptop is 600Mhz.
>>
>> And enumerate english strings in power daemon? Limiting the numver of
>> states?
>
> Hah,  I didn't think of it that way.   I was thinking in the same way
> "mem" and "disk" and "standy" are strings in the kernel.
>
>  The names themselves don't mean anything other than to imply an order =

> so the
> kernel and power manager can understand the same order.
>
> I have the oppointd daemon running on systems of different =

> architectures
> and different numbers of operating points.  Some have only two =

> operating
> points defined, some have three, some have five and one has six.
>
> The power manager functions the same on all of them because of the =

> ordering
> presented by the names.
>
> The oppointd daemon also understands that the operating points =

> associated
> with the names  may be sparsely populated.  The daemon can  still work
> correctly on a sparsely populated name space because of the ordering
> implied. It works unchanged
> on systems with only two states and on systems with six states.
>
>>
>>>>
>>>>>         /sys/power/operating_points/high/frequency
>>>>>         /sys/power/operating_points/high/voltage
>>>>>         /sys/power/operating_points/high/latency
>>>>
>>>> What is voltage for 'mem'?
>>>
>>> I don't know what the voltage or latency is for mem.
>>> Perhaps Intel could better
>>> say what the voltage is in the suspend state and what
>>> the latency was
>>> for transistion to that state.  I didn't have the data
>>> available when
>>> I wrote the code.
>>
>> And you will not have data available even if intel helps you. What is
>> _frequency_ for mem? These fields are meaningless for sleep states;
>> that should tell you that mixing sleep and operating states is bad
>> idea.
>
> Actually the SoC concerns that both OpPoint and PowerOp are trying
> to deal with have different power consumption levels associated with
> different sleep states.
>
> Different sleep states have different power consumption levels
> and different transition latencies.  The power manager needs to
> understand both the power consumption level with each
> sleep state and the transition latency so it can make decisions
> about when to transition into different sleep states.
>
> Typically sleep states with the lowest power consumption have
> the longest transition latencies.  The power manager must know
> the power consumption and transition latencies so it can decide when =

> best to
> switch to a sleep state that consumes a bit more power but has
> a much shorter latency to switch into and out of,  and
> when it's okay to switch to the lowest sleep state, but longest
> transition latency.
>

Latency is a good example of how mixing sleep states with operating =

points doesn't  quite work.  Latency for switching to a new operating =

point is very a much a function of the current operating point.   I =

think latency for sleep states is the same every time.  Also which =

direction are you capturing latency for, suspend or resume?  If your =

power manager is making decisions based on latency, I could imagine =

that it needs to know the latency for going into and out of that state.

>>
>> --
>> Thanks for all the (sleeping) penguins.
>>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>
