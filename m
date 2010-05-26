From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 15:52:03 -0700
Message-ID: <AANLkTik-V0vQS5v0wLDDnu6ZXqrs0g5WUjzI1Gliqflx__32330.6663231508$1274917735$gmane$org@mail.gmail.com>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<1274863655.5882.4875.camel@twins>
	<AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	<1274867106.5882.5090.camel@twins>
	<AANLkTiksR3YozbBH0Iv5kNsQkEGKCH1APCvn_s6LkjV9@mail.gmail.com>
	<1274868593.5882.5185.camel@twins>
	<AANLkTinuxCbeBmxIR7b_1OtrqQYJCamiDZJbnNTih1Fb@mail.gmail.com>
	<1274869966.5882.5262.camel@twins>
	<AANLkTikRMBkoFxgaKsxMJ2lOMomTXpiHJDk3rVt0EtwM@mail.gmail.com>
	<1274870970.5882.5311.camel@twins>
	<AANLkTinlxsokwralwRAL9_YRQ7-SZUSvrGHTlRISA9bC@mail.gmail.com>
	<1274872357.27810.16.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274872357.27810.16.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/5/26 Peter Zijlstra <peterz@infradead.org>:
> On Wed, 2010-05-26 at 03:53 -0700, Arve Hj=F8nnev=E5g wrote:
>> 2010/5/26 Peter Zijlstra <peterz@infradead.org>:
>> > On Wed, 2010-05-26 at 03:40 -0700, Arve Hj=F8nnev=E5g wrote:
>> >> 2010/5/26 Peter Zijlstra <peterz@infradead.org>:
>> >> > On Wed, 2010-05-26 at 03:25 -0700, Arve Hj=F8nnev=E5g wrote:
>> >> >
>> >> >> and on systems where the
>> >> >> same power state can be used from idle and suspend, we use suspend=
 so
>> >> >> we can stay in the low power state for minutes to hours instead of
>> >> >> milliseconds to seconds.
>> >> >
>> >> > So don't you think working on making it possible for systems to be =
idle
>> >> > _that_ long would improve things for everybody? as opposed to this
>> >> > auto-suspend which only improves matters for those that (can) use i=
t?
>> >>
>> >> I'm not preventing anyone from working on improving this. Currently
>> >> both the kernel and our user-space code polls way too much. I don't
>> >> think it is reasonable to demand that no one should run any user-space
>> >> code with periodic timers when we have not even fixed the kernel to
>> >> not do this.
>> >
>> > All I'm saying is that merging a stop-gap measure will decrease the
>> > urgency and thus the time spend fixing the actual issues while adding
>> > the burden of maintaining this stop-gap measure.
>> >
>>
>> Fixing the actually issue means fixing all user-space code, and
>> replacing most x86 hardware. I don't think keeping this feature out of
>> the kernel will significantly accelerate this.
>
> I don't think x86 is relevant anyway, it doesn't suspend/resume anywhere
> near fast enough for this to be usable.

x86 systems already auto-suspend.

>
> My laptop still takes several seconds to suspend (Lenovo T500), and
> resume (aside from some userspace bustage) takes the same amount of
> time. That is quick enough for manual suspend, but I'd hate it to try
> and auto-suspend.
>

Why? If your suspend is currently set to sleep after 30 minutes of
inactivity, you can still have the same setting with opportunistic
suspend. With opportunistic suspend you can have an alarm set to run a
task at a specific time without risking that this task does not run at
that time just because your inactivity timer expired at the same time
as the alarm went off.

> Getting longer idle periods however is something that everybody benefits
> from. On x86 we're nowhere close to hitting the max idle time of the
> platform, you get _tons_ of wakeups on current 'desktop' software.
>
> But x86 being a PITA shouldn't stop people from working on this, there's
> plenty other architectures out there, I remember fixing a NO_HZ bug with
> davem on sparc64 because his niagra had cores idling for very long times
> indeed.
>
> So yes, I do think merging this will delay the effort in fixing
> userspace, simply because all the mobile/embedded folks don't care about
> it anymore.
>

To me this is not a good argument for not merging the code. If people
stop caring about the problem if this feature is merged that means it
solved a problem for them. You want to prevent merging a feature
_because_ it solves a problem.

-- =

Arve Hj=F8nnev=E5g
