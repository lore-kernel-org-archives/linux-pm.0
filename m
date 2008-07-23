From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2.6.26-rc4-git] PM: boot time suspend selftest
Date: Wed, 23 Jul 2008 01:19:54 -0700
Message-ID: <20080723011954.aa7bf26e.akpm__40553.9620937363$1216801437$gmane$org@linux-foundation.org>
References: <200805291333.42057.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805291333.42057.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Machek <pavel@suse.cz>, Pavel@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Thu, 29 May 2008 13:33:41 -0700 David Brownell <david-b@pacbell.net> wrote:

> Boot-time test for system suspend states (STR or standby).  The generic
> RTC framework triggers wakeup alarms, which are used to exit those states.
> 
>   - Measures some aspects of suspend time ... this uses "jiffies" until
>     someone converts it to use a timebase that works properly even while
>     timer IRQs are disabled. 
> 
>   - Triggered by a command line parameter.  By default nothing even
>     vaguely troublesome will happen, but "test_suspend=mem" will give
>     you a brief STR test during system boot.  (Or you may need to use
>     "test_suspend=standby" instead, if your hardware needs that.)
> 
> This isn't without problems.  It fires early enough during boot that for
> example both PCMCIA and MMC stacks have misbehaved.  The workaround in
> those cases was to boot without such media cards inserted.

mips allmodconfig:

kernel/built-in.o(.init.text+0x5b30): In function `test_suspend':
: undefined reference to `rtc_class'
kernel/built-in.o(.init.text+0x5b38): In function `test_suspend':
: undefined reference to `rtc_class'
kernel/built-in.o(.init.text+0x5ba4): In function `test_suspend':
: undefined reference to `rtc_class_open'
kernel/built-in.o(.init.text+0x5c30): In function `test_suspend':
: undefined reference to `rtc_read_time'
kernel/built-in.o(.init.text+0x5d50): In function `test_suspend':
: undefined reference to `rtc_set_alarm'
kernel/built-in.o(.init.text+0x5f6c): In function `test_suspend':
: undefined reference to `rtc_class_close'

some of these are already exported, so something else went wrong.
