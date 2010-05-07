From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Thu, 6 May 2010 17:10:11 -0700
Message-ID: <i2od6200be21005061710mae9a437by90b22f61cbc2ae15__36178.6999660127$1273191066$gmane$org@mail.gmail.com>
References: <20100505202826.GB7450@linux.intel.com>
	<Pine.LNX.4.44L0.1005051705200.1885-100000@iolanthe.rowland.org>
	<z2ta55d774e1005051437heb584584q6afca0b4b254d5d0@mail.gmail.com>
	<20100505234755.GI29604@atomide.com>
	<l2ra55d774e1005051656wbf4f3d7cr8cc9de0478e509f1@mail.gmail.com>
	<20100506000552.GJ29604@atomide.com>
	<g2yd6200be21005052116n5dd8708fk33eaf8944379bfc2@mail.gmail.com>
	<20100506170420.GB30928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100506170420.GB30928@atomide.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Lindgren <tony@atomide.com>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/5/6 Tony Lindgren <tony@atomide.com>:
> * Arve Hj=F8nnev=E5g <arve@android.com> [100505 21:11]:
>> On Wed, May 5, 2010 at 5:05 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Brian Swetland <swetland@google.com> [100505 16:51]:
>> >> On Wed, May 5, 2010 at 4:47 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
>> >> > * Brian Swetland <swetland@google.com> [100505 14:34]:
>> >> >> On Wed, May 5, 2010 at 2:12 PM, Alan Stern <stern@rowland.harvard.=
edu> wrote:
>> >> >> >>
>> >> >> >> Oh, like tell the modem that user mode has handled the ring eve=
nt and
>> >> >> >> its ok to un-block?
>> >> >> >
>> >> >> > No, that's not how it works. =A0It would go like this:
>> >> >> >
>> >> >> > =A0 =A0 =A0 =A0The modem IRQ handler queues its event to the inp=
ut subsystem.
>> >> >> > =A0 =A0 =A0 =A0As it does so the input subsystem enables a suspe=
nd blocker,
>> >> >> > =A0 =A0 =A0 =A0causing the system to stay awake after the IRQ is=
 done.
>> >> >
>> >> > How about instead the modem driver fails to suspend until it's done?
>> >> >
>> >> > Each driver could have a suspend_policy sysfs entry with options su=
ch
>> >> > as [ forced | safe ]. The default would be forced. Forced would
>> >> > be the current behaviour, while safe would refuse suspend until the
>> >> > driver is done processing.
>> >> >
>> >> >> > =A0 =A0 =A0 =A0The user program enables its own suspend blocker =
before reading
>> >> >> > =A0 =A0 =A0 =A0the input queue. =A0When the queue is empty, the =
input subsystem
>> >> >> > =A0 =A0 =A0 =A0releases its suspend blocker.
>> >> >
>> >> > And also the input layer could refuse to suspend until it's done.
>> >> >
>> >> >> > =A0 =A0 =A0 =A0When the user program finishes processing the eve=
nt, it
>> >> >> > =A0 =A0 =A0 =A0releases its suspend blocker. =A0Now the system c=
an go back to
>> >> >> > =A0 =A0 =A0 =A0sleep.
>> >> >
>> >> > And here the user space just tries to suspend again when it's done?
>> >> > It's not like you're trying to suspend all the time, so it should be
>> >> > OK to retry a few times.
>> >>
>> >> We actually are trying to suspend all the time -- that's our basic
>> >> model -- suspend whenever we can when something doesn't prevent it.
>> >
>> > Maybe that state could be kept in some userspace suspend policy manage=
r?
>> >
>> >> >> > At no point does the user program have to communicate anything t=
o the
>> >> >> > modem driver, and at no point does it have to do anything out of=
 the
>> >> >> > ordinary except to enable and disable a suspend blocker.
>> >> >>
>> >> >> Exactly -- and you can use the same style of overlapping suspend
>> >> >> blockers with other drivers than input, if the input interface is =
not
>> >> >> suitable for the particular interaction.
>> >> >
>> >> > Would the suspend blockers still be needed somewhere in the example
>> >> > above?
>> >>
>> >> How often would we retry suspending?
>> >
>> > Well based on some timer, the same way the screen blanks? Or five
>> > seconds of no audio play? So if the suspend fails, then reset whatever
>> > userspace suspend policy timers.
>> >
>> >> If we fail to suspend, don't we have to resume all the drivers that
>> >> suspended before the one that failed? =A0(Maybe I'm mistaken here)
>> >
>> > Sure, but I guess that should be a rare event that only happens when
>> > you try to suspend and something interrupts the suspend.
>> >
>>
>> This is not a rare event. For example, the matrix keypad driver blocks
>> suspend when a key is down so it can scan the matrix.
>
> Sure, but how many times per day are you suspending?
>

How many times we successfully suspend is irrelevant here. If the
driver blocks suspend the number of suspend attempts depend on your
poll frequency.

>> >> With the suspend block model we know the moment we're capable of
>> >> suspending and then can suspend at that moment. =A0Continually trying=
 to
>> >> suspend seems like it'd be inefficient power-wise (we're going to be
>> >> doing a lot more work as we try to suspend over and over, or we're
>> >> going to retry after a timeout and spend extra time not suspended).
>> >>
>> >> We can often spend minutes (possibly many) at a time preventing
>> >> suspend when the system is doing work that would be interrupted by a
>> >> full suspend.
>> >
>> > Maybe you a userspace suspend policy manager would do the trick if
>> > it knows when the screen is blanked and no audio has been played for
>> > five seconds etc?
>> >
>>
>> If user space has to initiate every suspend attempt, then you are
>> forcing it to poll whenever a driver needs to block suspend.
>
> Hmm I don't follow you. If the userspace policy daemon timer times
> out, the device suspends. If the device does not suspend because of
> a blocking driver, then the timers get reset and you try again based
> on some event such as when the screen blanks.
>

This retry is what I call polling. You have to keep retrying until you
succeed. Also, using the screen blank timeout for this polling is not
a good idea. You do not want to toggle the screen off and on with with
every suspend attempt.

-- =

Arve Hj=F8nnev=E5g
