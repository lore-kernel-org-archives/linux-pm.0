From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Tue, 3 Aug 2010 22:22:55 -0700
Message-ID: <AANLkTikr6CW5AP9=ZVvyMUar39tPX2QcJbY3a4EFDEkN__308.193165301596$1280899423$gmane$org@mail.gmail.com>
References: <20100801210548.23f77ff6@infradead.org>
	<alpine.DEB.2.00.1008012153300.25170@asgard.lang.hm>
	<20100802140933.GB2405@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008021627290.29820@asgard.lang.hm>
	<AANLkTi=1kBuyPS_P+eNLcnRu1mJH6BzpzQW_sENZuL1L@mail.gmail.com>
	<alpine.DEB.2.00.1008022121430.6545@asgard.lang.hm>
	<AANLkTikhcYzNp8CPp8cqrV7Ey5CLMWu1sJTNxUtEi2as@mail.gmail.com>
	<alpine.DEB.2.00.1008022203470.6545@asgard.lang.hm>
	<AANLkTinFT5jq4nUhUpzS5S4TVDQGj0S7RtRgxNhsz2UF@mail.gmail.com>
	<alpine.DEB.2.00.1008031611100.6545@asgard.lang.hm>
	<20100804001015.GJ2407@linux.vnet.ibm.com>
	<20100803205758.21fcf372@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100803205758.21fcf372@infradead.org>
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
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 3, 2010 at 8:57 PM, Arjan van de Ven <arjan@infradead.org> wrot=
e:
> On Tue, 3 Aug 2010 17:10:15 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
>>
>> OK, I'll bite...
>>
>> >From an Android perspective, the differences are as follows:
>>
>> 1. =A0 =A0Deep idle states are entered only if there are no runnable
>> tasks. In contrast, opportunistic suspend can happen even when there
>> =A0 =A0 =A0 are tasks that are ready, willing, and able to run.
>
> for "system suspend", this is an absolutely valid statement.
> for "use suspend as idle state", it's not so clearly valid.
> (but this is sort of a separate problem, basically the "when do we
> freeze the tasks that we don't like for power reasons" problem,
> which in first order is independent on what kind of idle power state
> you pick, and discussed extensively elsewhere in this thread)
>
>>
>> 2. =A0 =A0There can be a set of input events that do not bring the
>> system out of suspend, but which would bring the system out of a deep
>> =A0 =A0 =A0 idle state. =A0For example, I believe that it was stated that
>> one of the Android-based smartphones ignores touchscreen input while
>> =A0 =A0 =A0 suspended, but pays attention to it while in deep idle state=
s.
>
> I would argue that this is both a hardware specific issue, but also a
> policy issue. From the user point of view, screen off with idle and
> screen off with suspend aren't all that different (if my phone would
> decide to idle rather than suspend because some app blocks suspend... I
> wouldn't expect a difference in behavior when I touch the screen).
> "Screen off -> don't honor touch after a bit" is almost an independent,
> but very real, policy problem (and a forced one in suspend, I'll grant
> you that). I could even argue that the policy decision "we don't care
> about the touch screen input" is a pre-condition for entering suspend
> (or in android speak, caring for touch screen input/having the touch
> screen path active would be a suspend blocker)
>
>>
>> 3. =A0 =A0The system comes out of a deep idle state when a timer
>> =A0 =A0 =A0 expires. =A0In contrast, timers cannot expire while the
>> =A0 =A0 =A0 system is suspended. =A0(This one is debatable: some people
>> =A0 =A0 =A0 argue that timers are subject to jitter, and the suspend
>> =A0 =A0 =A0 case for timers is the same as that for deep idle states,
>> =A0 =A0 =A0 but with unbounded timer jitter. =A0Others disagree. =A0The
>> =A0 =A0 =A0 resulting discussions have produced much heat, but little
>> =A0 =A0 =A0 light. =A0Such is life.)
>
> I'll debate it even harder in that it's platform specific whether
> timers can get the system out of suspend or not. Clearly on the Android
> platform in question that's not the case, but for some of the Intel
> phone silicon for example, timers CAN be wake sources to get you out of
> suspend just fine. It just depend on which exact hw you talk about.
> Generally, even if the fast timers aren't wake up sources, there'll be
> some sort of alarm thing that you can pre-wake.. but yes you are right
> in saying that's rather lame.
> Either way, it's not a general property of suspend, but a property of
> suspend on the specific platform in question.
>

I disagree. On the msm platform the low level timer that brings us out
of the low power state is the same for idle and suspend. The
difference is where which kernel api the request comes from. In idle,
the next event on the clockevents device is usually the first event.
In suspend the generic kernel timekeeping code cancels this event and
the rtc wakeup event remains.

-- =

Arve Hj=F8nnev=E5g
