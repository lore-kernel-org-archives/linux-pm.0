From: david@lang.hm
Subject: Re: Higer latency with dynamic tick (need for an
 io-ondemand govenor?)
Date: Sat, 19 Apr 2008 15:49:23 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0804191546430.4670__41890.4716418639$1208645166$gmane$org@asgard>
References: <3B6D69C3A9EBCA4BA5DA60D913027429010253CD@dlee13.ent.ti.com>
	<1179474567.12981.53.camel@chaos>
	<3B6D69C3A9EBCA4BA5DA60D91302742904131BED@dlee13.ent.ti.com>
	<200804182045.56893.david-b@pacbell.net>
	<alpine.LFD.1.10.0804190839140.3261@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="8323328-307532848-1208589223=:3261"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0804190839140.3261@apollo.tec.linutronix.de>
Content-ID: <alpine.DEB.1.10.0804191546431.4670@asgard>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-307532848-1208589223=:3261
Content-Type: TEXT/PLAIN; CHARSET=UTF-8; format=flowed
Content-ID: <alpine.DEB.1.10.0804191546432.4670@asgard>
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id m3JMhCcj031341

On Sat, 19 Apr 2008, Thomas Gleixner wrote:

> On Fri, 18 Apr 2008, David Brownell wrote:
>> On Friday 18 April 2008, Woodruff, Richard wrote:
>>> When capturing some traces with dynamic tick we were noticing the
>>> interrupt latency seems to go up a good amount. If you look at the tr=
ace
>>> the gpio IRQ is now offset a good amount. =C2=A0Good news I guess is =
its
>>> pretty predictable.
>>
>> That is, about 24 usec on this CPU ... an ARM v7, which I'm guessing
>> is an OMAP34xx running fairly fast (order of 4x faster than most ARMs).
>>
>> Similar issues were noted, also using ETM trace, on an ARM920 core [1]
>> from Atmel.  There, the overhead of NO_HZ was observed to be more like
>> 150 usec of per-IRQ overhead, which is enough to make NO_HZ non-viable
>> in some configurations.
>>
>>
>>> I was wondering what thoughts of optimizing this might be.
>>
>> Cutting down the math implied by jiffies updates might help.
>> The 64 bit math for ktime structs isn't cheap; purely by eyeball,
>> that was almost 1/3 the cost of that 24 usec (mostly __do_div64).
>
> Hmm, I have no real good idea to avoid the div64 in the case of a long
> idle sleep. Any brilliant patches are welcome :)

how long is 'long idle sleep'? and how common are such sleeps? is it=20
possibly worth the cost of a test in the hotpath to see if you need to do=
=20
the 64 bit math or can get away with 32 bit math (at least on some=20
platforms)

David Lang
--8323328-307532848-1208589223=:3261
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--8323328-307532848-1208589223=:3261--
