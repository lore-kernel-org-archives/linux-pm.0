From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 04:20:58 -0700
Message-ID: <AANLkTinVs-YfxCHm7Zees9oq_NYySqI6UFtX57JlsLy-__25243.5642098591$1275046252$gmane$org@mail.gmail.com>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<AANLkTil6Bo7qZltbLzHJjIDyruKHFQEURpe5LPJEpTws@mail.gmail.com>
	<20100528101755.7b5f6b8a@lxorguk.ukuu.org.uk>
	<AANLkTilYHKKmQePBGW3LVLjUZy7HXHQku2Iub-LWGBm6@mail.gmail.com>
	<20100528121636.34be17ad@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528121636.34be17ad@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

2010/5/28 Alan Cox <alan@lxorguk.ukuu.org.uk>:
>> > My laptop behaves in
>> > that way if for example the battery is almost flat. Your suspend block=
er
>> > would cause me to lose all my work with a flat battery. This is another
>> > example of why the application must not be the policy manager.
>> >
>>
>> You can still force suspend when the battery gets low.
>
> So now we need suspend blocker blockers - as I predicted.

Forced suspend is still supported. No new API is needed if you really
want to force suspend.

>
>> > In the normal case in the PC world outside of corner cases like flat
>> > batteries the answer is really simple. The laptop suspend to RAM
>> > on idle intervals set in the BIOS and the like are sufficient that
>> > progress will have been made before it considers going back to sleep
>> > again. Right now its about ten seconds in each direction plus other co=
sts
>> > (wear on LCD backlight, disc parking etc).
>> >
>>
>> I'm not sure what you are trying to say here. Are you saying your
>> laptop enters S3 from idle?
>
> If I have an alarm set on my laptop it will wake up when the alarm goes
> off. Once it has woken up it will not go back to suspend (except for
> something libe a battery event) until a timeout has elapsed that began
> when the laptop woke up.
>

I think you are missing the point. It works fine if the alarm caused
the wakeup, but if you had just used your system and your inactivity
timeout expired just as your alarm goes off, the alarm will not wake
the system, nor does it prevent it from suspending.

> This in the laptop work solves the problem of making progress. On a
> laptop power budget, with laptop constraints on suspend (both physical
> cycle limits of hardware and performance) this works fine.
>
> If I suspend/resume my laptop every time I have a 30 second idle gap I
> will need a new laptop much sooner than makes me happy.
>

Then don't set your inactivity timeout to 30 seconds. I don't see how
this is relevant.

> I don't claim this is true for a typical mobile phone obviously.
>
The only difference on the phone is that we have way more wakeup
events which makes the race conditions more visible. The race exist on
your laptop as well.

-- =

Arve Hj=F8nnev=E5g
