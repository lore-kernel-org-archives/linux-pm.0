From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: [RFT][PATCH] swsusp: Change code ordering related to
	ACPI
Date: Sat, 5 May 2007 13:46:14 -0700
Message-ID: <2c0942db0705051346jabd14bam170cf4cf8b54d473@mail.gmail.com>
References: <200705041143.02451.rjw@sisk.pl>
	<2c0942db0705041611u2d82fbb7m4719c1bcf8bcdbf7@mail.gmail.com>
	<200705051150.22108.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705051150.22108.rjw@sisk.pl>
Content-Disposition: inline
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
Cc: LKML <linux-kernel@vger.kernel.org>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Marcus Better <marcus@better.se>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 5/5/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday, 5 May 2007 01:11, Ray Lee wrote:
> > On 5/4/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > The change of the hibernation/suspend code ordering made before 2.6.21 has
> > > caused some systems to have problems related to ACPI.  In particular, the
> > > 'platform' hibernation mode doesn't work any more on some systems.
> >
> > It seems that somewhere between 2.6.21-rc4 and 2.6.21 final my laptop
> > stopped being able to come out of suspend to RAM. Before I start
> > bisecting (again, sigh), is this ringing any bells for anyone? In
> > particular your, patch (snipped) that deals with hibernation, would it
> > also affect suspend to RAM?
>
> Not this particular one, but you may try to move pm_finish() after
> resume_console() in kernel/power/main.c:suspend_prepare() and see if that
> helps.
>
> If it doesn't help, then try to compile the kernel with NO_HZ and
> HIGH_RES_TIMERS unset.  If that doesn't help, you may try with HPET_TIMER
> unset additionally.

Okay, my system is doing it with a known good kernel as well
(2.6.21-rc4), so this is something else. Please ignore my report for
now. In the meantime, I'll be downgrading my hal and drm to what they
were a week ago to see if that fixes the problem.

(I knew better than to change more than one thing at a time, really I
did. Sigh.)

Thanks for your help regardless,

Ray
