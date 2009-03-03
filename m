From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 1/4] PM: Rework handling of interrupts
	during suspend-resume (rev. 4)
Date: Tue, 3 Mar 2009 00:41:06 -0800
Message-ID: <d6200be20903030041x303293ddn2d07afed318e2f49__21531.7131406211$1236069830$gmane$org@mail.gmail.com>
References: <200902221837.49396.rjw@sisk.pl> <200903012324.39327.rjw@sisk.pl>
	<d6200be20903021501x4ad710fbr834b11b8a6647d2c@mail.gmail.com>
	<200903030013.02805.rjw@sisk.pl>
	<d6200be20903021518r48fe6fb2vd07e9dedc4f5ff44@mail.gmail.com>
	<alpine.LFD.2.00.0903021530200.3111@localhost.localdomain>
	<alpine.LFD.2.00.0903021533130.3111@localhost.localdomain>
	<d6200be20903021608x3ccd8d47u613b35f2ebc609be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20903021608x3ccd8d47u613b35f2ebc609be@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 2, 2009 at 4:08 PM, Arve Hj=F8nnev=E5g <arve@android.com> wrote:
> On Mon, Mar 2, 2009 at 3:35 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>>
>> On Mon, 2 Mar 2009, Linus Torvalds wrote:
>>>
>>> If IRQ_SUSPENDED _is_ set, then that means that we're after the
>>> suspend_late() sequence and before the resume_early() sequence
>>
>> Sorry, after the suspend, and before the resume.
>>
>> We could be _in_ the suspend_late/resume_early sequence, but a driver th=
at
>> were to try to play with interrupts at that stage would be broken. It
>> can't very well do a enable_irq(), because that would be a MAJOR BUG - it
>> would make the whole irq suspend thing pointless, since now interrupts
>> would start to happen exactly where they must not happen!
>
> It may be pointless for a driver to call disable_irq and enable_irq
> from suspend_late or resume_early (instead of suspend and resume), but
> I would not call it a bug. Since disable_irq and enable_irq are
> reference counted all this is doing is indicating that this driver can
> or cannot accept interrupts. If you want to make an additional
> restriction that drivers are not allowed to call disable_irq or
> enable_irq from suspend_late and resume_early, then yes you can tell
> that enable_irq was called from resume_device_irqs.
>
> I don't know of any drivers that do this, I was just pointing out the
> danger of releasing a reference without knowing if you acquired that
> reference.

I did think of a driver that can call enable_irq during the
suspend_late phase with this patch. This will not cause an extra
enable_irq, but it will enable the interrupt since suspend_device_irqs
never incremented depth. Our keypad driver disables its interrupt(s)
as soon as you press a key and starts a timer to scan the keypad. When
the timer detects that no keys are pressed, it re-enables the
interrupt. Since timers now run during suspend_late, this enable_irq
call can happen after suspend_device_irqs. If suspend_device_irqs
increments depth even if it is not zero, this can be avoided.

-- =

Arve Hj=F8nnev=E5g
