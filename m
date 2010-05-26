From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 16:09:12 -0700
Message-ID: <AANLkTikFwznonORd42piWZvBv3oqqSj9odC9Jaud8o3x__20971.68505793$1274918309$gmane$org@mail.gmail.com>
References: <201005262351.59626.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1005261759100.1328-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005261759100.1328-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 26, 2010 at 3:12 PM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
> On Wed, 26 May 2010, Rafael J. Wysocki wrote:
>
>> > The reason is simple: When a user process initiates an opportunistic
>> > suspend, you make it wait in an interruptible sleep until all the
>> > kernel suspend blockers are released. =A0No polling. =A0If another user
>> > thread decides in the meantime that it needs to block the suspend, it
>> > sends a signal to the power manager process.
>> >
>> > In fact, other threads should signal the power manager process whenever
>> > they want to block or unblock suspends. =A0That way the power manager
>> > process can spend all its time sleeping, without doing any polling.
>>
>> I still see an issue here. =A0Namely, if the power manager is in user sp=
ace and
>> it's signaled to suspend, it has to ask the kernel to do that, presumabl=
y by
>> writing something to a sysfs file. =A0Then, if the kernel blocks the sus=
pend, the
>> power manager waits until the block is released. =A0Now, it should go ba=
ck and
>> check if user space still doesn't block suspend and if so, wait until th=
e block
>> is released and start over. =A0With all suspend blockers in the kernel t=
his
>> looping behavior is avoidable.
>
> I must be missing something. =A0In Arve's patch 1/8, if the system is in
> opportunistic suspend, and a wakeup event occurs but no suspend
> blockers get enabled by the handler, what causes the system to go back
> into suspend after the event is handled? =A0Isn't that a loop of some
> sort?
>

Yes it is a loop. I think what you are missing is that it only loops
repeatedly if the driver that aborts suspend does not use a suspend
blocker.

> And even if it isn't, so what? =A0What's wrong with looping behavior?

It is a significant power drain.

> Especially a loop that's as short as this one and spends almost all of
> its time sleeping. =A0Think how much harder it would be to write programs
> if you weren't allowed to use any loops. =A0:-)
>
> Alan Stern
>
>


-- =

Arve Hj=F8nnev=E5g
