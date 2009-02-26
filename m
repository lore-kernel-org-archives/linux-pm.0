From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Thu, 26 Feb 2009 13:20:21 -0800
Message-ID: <d6200be20902261320q58a347e5s1af790e56b186c81__8784.44711347601$1235683502$gmane$org@mail.gmail.com>
References: <200902221837.49396.rjw@sisk.pl> <200902250029.16107.rjw@sisk.pl>
	<d6200be20902251717r531c022bl4c25fcb902201188@mail.gmail.com>
	<200902261050.50531.rjw@sisk.pl>
	<d6200be20902261234i5a3896fo78a7f56d16a247c7@mail.gmail.com>
	<1235681849.7388.22.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1235681849.7388.22.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 26, 2009 at 12:57 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2009-02-26 at 12:34 -0800, Arve Hj=F8nnev=E5g wrote:
>> That is enough for drivers that use wakelocks to abort suspend (if I
>> fix the wakelock code to not use a platform device as its last abort
>> point). It is not enough if you don't have wakelocks, since the
>> interrupt can occur after suspend_late has been called and the driver
>> has no way to abort suspend.
>>
> I still don't quite see how you deal with the race anyway. Ie. Even
> without Rafael patch, what if the interrupt occurs after your sysdev
> suspend ?

After local_irq_disable has been called, the interrupt will no longer
be cleared by Linux when it occurs. This means that is still pending
when you get to the low level suspend code which will prevent suspend.

> In general, unless they are level sensitive, wakeup interrupts tend to
> always be somewhat racy.

They don't have to be. If you have a separate hardware component that
tracks wakeup interrupts, you need to start this before you stop the
main interrupt controller. If any interrupts are pending at this time
you abort suspend. After a wakeup you do the reverse.

-- =

Arve Hj=F8nnev=E5g
