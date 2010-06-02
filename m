From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC] lp_events: an lternitive to suspend blocker
	user mode and kernel API
Date: Tue, 1 Jun 2010 20:10:15 -0700
Message-ID: <AANLkTimNlEqGhLplj8RjYLNHf3DpI13pDf70eAvRxfI___5818.9875366681$1275448350$gmane$org@mail.gmail.com>
References: <20100530200409.GA21632@gvim.org>
	<20100531095753.4c174f2d@notabene.brown>
	<20100531221035.GB31155@gvim.org> <201006010045.21382.rjw@sisk.pl>
	<20100601050914.GG31155@gvim.org>
	<AANLkTik4ixmtv5Ki7jds5gEspJAxBRAcJCR1Jv-V6ajR@mail.gmail.com>
	<20100601140120.GB1281@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100601140120.GB1281@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: mark.gross@intel.com, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Arve@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

2010/6/1 mark gross <640e9920@gmail.com>:
> On Mon, May 31, 2010 at 10:24:30PM -0700, Arve Hj=F8nnev=E5g wrote:
>> On Mon, May 31, 2010 at 10:09 PM, mark gross <640e9920@gmail.com> wrote:
>> > On Tue, Jun 01, 2010 at 12:45:21AM +0200, Rafael J. Wysocki wrote:
>> >> On Tuesday 01 June 2010, mark gross wrote:
>> >> > On Mon, May 31, 2010 at 09:57:53AM +1000, Neil Brown wrote:
>> >> ...
>> >> > > So I would suggest modifying your proposal to simply create a new=
 'input'
>> >> > > device. =A0Any driver that supports wake-from-suspend queues an e=
vent to that
>> >> > > device when a wakeup event occurs. =A0If the device is open and h=
as any queued
>> >> > > events, then a suspend request such as 'echo mem > /sys/power/sta=
te' completes
>> >> > > without going into full suspend.
>> >> >
>> >> > /me likes.
>> >> >
>> >> > > Then you just need to convince us that this mechanism can be used=
 without any
>> >> > > race problems. =A0If it can, then it would certainly be a simple =
and
>> >> > > unobtrusive approach.
>> >> >
>> >> > Lets find out.
>> >>
>> >> Simple question: how is that better than the Alan Stern's proposed ap=
proach?
>> >>
>> > I just saw Alan Stern's proposal, and have gotten some input form some
>> > others. =A0I can't say my patch represents a better Idea than what Alan
>> > proposed. =A0However; what Alan (and Thomas) are talking about is
>> > effectively the same as the kenrel mode wakelock/suspend blocker thing,
>> > and although it reuses existing infrastructure, it doesn't solve the
>> > problem of needing overlapping blocking sections of code from ISR to
>> > user mode.
>> >
>>
>> I don't think your solution solves this either.
>
> Why? =A0my proposal effectively removes the overlapping kernel blocking
> sections uppon wake up by forcing the user mode to ack the wake event
> and re-issue the suspend request explicitly. =A0That pretty much solves
> that problem.
>

How to you ack the wakeup event in a safe way. Another wakeup event
can come in after you decided to ack the last event. Also when the
user-space power manager reads that there was a wakeup event, how does
it know if the real event has been delivered to user-space, and if the
user-space code that consumed this event has had a chance to block
suspend?

> We can talk about whether or not it can be used effectively with Android
> user mode PM or not, which I still think it can, but I need to try the
> mods to power.c.
>


-- =

Arve Hj=F8nnev=E5g
