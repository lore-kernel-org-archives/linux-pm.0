From: Kim Kyuwon <q1.kim@samsung.com>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Mon, 25 May 2009 16:02:47 +0900
Message-ID: <4A1A4297.50809__9289.7244765938$1243351703$gmane$org@samsung.com>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
	<200905230029.18279.rjw@sisk.pl>
	<4d34a0a70905221603g785f5b78h330249ff258dbfdd@mail.gmail.com>
	<200905232214.57186.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200905232214.57186.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Saturday 23 May 2009, Kim Kyuwon wrote:
>> On Sat, May 23, 2009 at 7:29 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>> On Saturday 23 May 2009, Kim Kyuwon wrote:
> [--snip--]
>>>> You changed the really important part of Linux, which may affect most
>>>> processor architectures. I think you should be careful. If some of
>>>> architectures can't take care of it (they can implement
>>>> disable_irq_wake correctly in H/W level, will you revert your changes?
>>> No, the changes are not going to be reverted.  In fact things should have been
>>> done like this already much earlier.
>>>
>>> Now, do you have any particular example of a problem related to these changes
>>> or is it only a theoretical issue?
>> I'd CCing you when I'm sending a mail for this particular example of a example.
>> http://markmail.org/thread/fvt7d62arofon5xx
> 
> Well, as I said above, reverting the changes that introduced
> [suspend|resume]_device_irqs() is not an option, becuase it was the only sane
> way to achieve the goal they were added for.  So, we need to fix the wake-up
> problem on your platform with the assumption that
> [suspend|resume]_device_irqs() are going to stay.
> 
> For starters, would it be possible to teach the 'disable' hook of your
> platform's interrupt controller not to mask the IRQs that have both
> IRQ_WAKEUP and IRQ_SUSPENDED set?  That apparently would work around the
> wake-up interrupts problem.

Thank you for considering this issue and spending your time. In order to 
make your idea work, we need to add a dummy 'set_wake' hook which 
returns always zero. Anyway, IMO, I think your idea is good to work 
around this problem. But Kevin Hilman(OMAP PM Maintainer) would make 
final decision.

Buy the way, how can you handle the problem that a few interrupt are 
discarded in a small window? I can be sure they are discarded, because I 
have debugged defects which generate in sleep/resume state hundreds of 
times on ARM Processors(PXA310, S3C6410, OMAP3430). Wake-up interrupts 
are generated as soon as arch_suspend_enable_irqs() invoked.

Regards,
Kyuwon
