From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Thu, 26 Feb 2009 12:34:25 -0800
Message-ID: <d6200be20902261234i5a3896fo78a7f56d16a247c7__32653.5991546281$1235680710$gmane$org@mail.gmail.com>
References: <200902221837.49396.rjw@sisk.pl> <200902250029.16107.rjw@sisk.pl>
	<d6200be20902251717r531c022bl4c25fcb902201188@mail.gmail.com>
	<200902261050.50531.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902261050.50531.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 26, 2009 at 1:50 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday 26 February 2009, Arve Hj=F8nnev=E5g wrote:
>> On Tue, Feb 24, 2009 at 3:29 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > BTW, appended is the current (3rd) version of the $subject patch with =
some
>> > of your comments taken into account. =A0In particular, I did the follo=
wing:
>> > - moved [suspend|resume]_device_irqs() to a separate file (pm.c)
>> > - fixed interrupt.h so that their headers are at a better place
>> > - made enable_irq() clear IRQ_SUSPENDED
>> > - made device_power_down() and device_power_up() call
>> > =A0suspend_device_irqs() and resume_device_irqs(), respectively, which
>> > =A0simplified the callers quite a bit (it changed the Xen code orderin=
g, though,
>> > =A0but I _think_ it still should work).
>>
>> Do you plan to fix edge triggered wakeup interrupts? It still looks
>> like edge triggered wakeup interrupts that occur between
>> suspend_device_irqs and local_irq_disable will not cause a wakeup.
>
> In the current version of the patch the interrupts that have IRQ_WAKEUP s=
et
> in status are not disabled. =A0Is this not enough?

That is enough for drivers that use wakelocks to abort suspend (if I
fix the wakelock code to not use a platform device as its last abort
point). It is not enough if you don't have wakelocks, since the
interrupt can occur after suspend_late has been called and the driver
has no way to abort suspend.

-- =

Arve Hj=F8nnev=E5g
