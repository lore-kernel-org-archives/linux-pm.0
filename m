From: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: Time in suspended mode has second resolution
Date: Tue, 11 Sep 2007 02:52:32 -0400
Message-ID: <20070911065232.GA3490@dmt>
References: <20070910200907.GA4736@dmt> <20070911005547.GA26578@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070911005547.GA26578@dmt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
Cc: tglx@linutronix.de, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org


On suspend, timekeeping_suspend() saves the current time from RTC,
and restores that on resume. Since it truncates the time to second
resolution, and the TSC has just been zeroed on poweroff, the following
can happen:

last_jiffies_update =3D second.nanosec;
timekeeping_suspend_time =3D get_rtc_time();
suspend
resume
xtime.tv_sec =3D timekeeping_suspend_time;

So the system might end up with the current time set with a
value lower than last_jiffies_update, causing "delta" from
tick_do_update_jiffies64() to be negative. The end result is that the
system spends more time than necessary in cpu_idle(), until "delta"
becomes positive (which can take hundreds of ms).

The proposed fix is to zero last_jiffies_update on resume. Note: if
cpu_idle() is invoked before timekeeping_resume has had a chance to run,
a negative delta on tick_do_update_jiffies64() will be seen, so a proper
fix would be to zero it in early_resume.

Are there any side effects of zeroing last_jiffies_update like this?

TIA

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 52db9e3..28b678f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -33,7 +33,7 @@ static DEFINE_PER_CPU(struct tick_sched,
 /*
  * The time, when the last jiffy update happened. Protected by xtime_lock.
  */
-static ktime_t last_jiffies_update;
+ktime_t last_jiffies_update;
 =

 struct tick_sched *tick_get_tick_sched(int cpu)
 {
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 3d1042f..ac22ae2 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -260,6 +260,7 @@ static int timekeeping_suspended;
 /* time in seconds when suspend began */
 static unsigned long timekeeping_suspend_time;
 =

+extern ktime_t last_jiffies_update;
 /**
  * timekeeping_resume - Resumes the generic timekeeping subsystem.
  * @dev:	unused
@@ -293,6 +294,8 @@ static int timekeeping_resume(struct sys
 =

 	clockevents_notify(CLOCK_EVT_NOTIFY_RESUME, NULL);
 =

+	last_jiffies_update =3D ktime_set(0, 0);
+
 	/* Resume hrtimers */
 	hres_timers_resume();
 =


On Mon, Sep 10, 2007 at 08:55:47PM -0400, Marcelo Tosatti wrote:
> =

> I suppose that saving the current nanosecond time from xtime on suspend
> and then restoring it _right after resume_ can fix this.

Bullshit.

> On Mon, Sep 10, 2007 at 04:09:07PM -0400, Marcelo Tosatti wrote:
> > Hi folks,
> > =

> > So I tracked down the problem where time is being spent in cpu_idle()
> > for way more than necessary on resume (thanks Jordan!).
> > =

> > What happens is that "last_jiffies_update" has a higher value than "now"
> > in tick_do_update_jiffies64(), therefore "delta" becomes negative.
> > =

> > The reason for this is that timekeeping_suspend uses the RTC with second
> > resolution to save the time of suspend, thus indirectly truncating the
> > value restored on resume.
> > =

> > So the following gets rid of the problem
> > =

> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index 3d1042f..06a7040 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -280,7 +280,7 @@ static int timekeeping_resume(struct sys
> >         if (now && (now > timekeeping_suspend_time)) {
> >                 unsigned long sleep_length =3D now - timekeeping_suspen=
d_time;
> > =

> > -               xtime.tv_sec +=3D sleep_length;
> > +               xtime.tv_sec +=3D sleep_length + 1;
> >                 wall_to_monotonic.tv_sec -=3D sleep_length;
> >         }
> >         /* re-base the last cycle value */
> > =

> > But it erroneously affects the internal clock.
> > =

> > By the way, talking about "internal clock", the fact that xtime is
> > truncated during resume can result in wrong clock time, right? Even more
> > if you do it often.
> > =

> > =

> > Below you can see the problem in action.
> > =

> > [    0.040888] rtc_cmos rtc_cmos: EARLY resume
> > [    0.040972] platform powerbutton: EARLY resume
> > [    0.041050] platform lid: EARLY resume
> > [    0.041123] pci 0000:00:01.0: EARLY resume
> > [    0.041202] lxfb 0000:00:01.1: EARLY resume
> > [    0.041281] Geode LX AES 0000:00:01.2: EARLY resume
> > [    0.041366] CAF=C9 NAND 0000:00:0c.0: EARLY resume
> > [    0.041450] sdhci 0000:00:0c.1: EARLY resume
> > [    0.041530] cafe1000-ccic 0000:00:0c.2: EARLY resume
> > [    0.041616] pci 0000:00:0f.0: EARLY resume
> > [    0.041694] cs5535audio 0000:00:0f.3: EARLY resume
> > [    0.041779] ohci_hcd 0000:00:0f.4: EARLY resume
> > [    0.041861] ehci_hcd 0000:00:0f.5: EARLY resume
> > [    0.041953] serial8250 serial8250.0: EARLY resume
> > [    0.042034] platform pcspkr: EARLY resume
> > [    0.042111] platform vesafb.0: EARLY resume
> > [    0.042259] serial8250 serial8250: EARLY resume
> > [    0.042354] i8042 i8042: EARLY resume
> > [    0.042430] platform dcon: EARLY resume
> > [    0.042525] platform olpc-battery.0: EARLY resume
> > [    0.042658] tick_do_update_jiffies64: now=3D50081263258 last_jiffies=
_update=3D50523000000
> > [    0.042773] tick_do_update_jiffies64: delta=3D[-1,558263258]
> > [    0.042866] tick_do_update_jiffies64: last_jiffies_update=3D[50,5230=
00000]
> > [    0.042970] tick_do_update_jiffies64: tick_period=3D[0,1000000]
> > [    0.043065] tick_do_update_jiffies64: now=3D[50,81263258]
> > [    0.043829] run_timer_softirq: jiffies=3Dfffc317b, base->timer_jiffi=
es=3Dfffc317c
> > [    0.045982] olpm-pm:  SCI 0x0 received
> > [    0.046075] PM: Finishing wakeup.
> > [    0.046172] rtc_cmos rtc_cmos: resuming
> > [    0.046254] platform powerbutton: resuming
> > [    0.046335] platform lid: resuming
> > [    0.046419] pci 0000:00:01.0: resuming
> > [    0.046627] lxfb 0000:00:01.1: resuming
> > [    0.046887] Geode LX AES 0000:00:01.2: resuming
> > [    0.047128] CAF=C9 NAND 0000:00:0c.0: resuming
> > [    0.047217] sdhci 0000:00:0c.1: resuming
> > [    0.047447] PM: Writing back config space on device 0000:00:0c.1 at =
offset f (was 8080100, writing 808010b)
> > [    0.047719] PM: Writing back config space on device 0000:00:0c.1 at =
offset 3 (was 800000, writing 802000)
> > [    0.047884] PM: Writing back config space on device 0000:00:0c.1 at =
offset 1 (was 2b00002, writing 2b00006)
> > [    0.048228] mmc_detect_change: sleeping for 1 msecs
> > [    0.048310] mmc_schedule_delayed_work, delay=3D1
> > [    0.048401] internal_add_timer, expires=3Dfffc317c now=3Dfffc317b
> > [    0.048503] cafe1000-ccic 0000:00:0c.2: resuming
> > [    0.048674] PM: Writing back config space on device 0000:00:0c.2 at =
offset f (was 8080100, writing 808010b)
> > [    0.048946] PM: Writing back config space on device 0000:00:0c.2 at =
offset 3 (was 800000, writing 802000)
> > [    0.049111] PM: Writing back config space on device 0000:00:0c.2 at =
offset 1 (was 2b00002, writing 2b00006)
> > [    0.054417] pci 0000:00:0f.0: resuming
> > [    0.054648] cs5535audio 0000:00:0f.3: resuming
> > [    0.054917] PCI: Setting latency timer of device 0000:00:0f.3 to 64
> > [    0.059360] __wake_up: caller0=3Dd099ceaa caller1=3Dc052e4d7
> > [    0.059459] ohci_hcd 0000:00:0f.4: resuming
> > [    0.059569] ohci_hcd 0000:00:0f.4: PCI D0, from previous PCI D3
> > [    0.059833] PCI: Setting latency timer of device 0000:00:0f.4 to 64
> > [    0.060100] ohci_hcd 0000:00:0f.4: powerup ports
> > [    0.060195] internal_add_timer, expires=3Dfffc3190 now=3Dfffc317b
> > [    0.060326] no need resched!
> > [    0.070678] tick_do_update_jiffies64: now=3D50109289623 last_jiffies=
_update=3D50523000000
> > [    0.070793] tick_do_update_jiffies64: delta=3D[-1,586289623]
> > [    0.070886] tick_do_update_jiffies64: last_jiffies_update=3D[50,5230=
00000]
> > [    0.070990] tick_do_update_jiffies64: tick_period=3D[0,1000000]
> > [    0.071085] tick_do_update_jiffies64: now=3D[50,109289623]
> > [    0.071226] run_timer_softirq: jiffies=3Dfffc317b, base->timer_jiffi=
es=3Dfffc317c
> > [    0.071353] no need resched!
> > [    0.098686] tick_do_update_jiffies64: now=3D50137300251 last_jiffies=
_update=3D50523000000
> > [    0.098801] tick_do_update_jiffies64: delta=3D[-1,614300251]
> > [    0.098894] tick_do_update_jiffies64: last_jiffies_update=3D[50,5230=
00000]
> > [    0.098998] tick_do_update_jiffies64: tick_period=3D[0,1000000]
> > [    0.099092] tick_do_update_jiffies64: now=3D[50,137300251]
> > [    0.099230] run_timer_softirq: jiffies=3Dfffc317b, base->timer_jiffi=
es=3Dfffc317c
> > [    0.099356] no need resched!
> > [    0.126691] tick_do_update_jiffies64: now=3D50165307741 last_jiffies=
_update=3D50523000000
> > [    0.126806] tick_do_update_jiffies64: delta=3D[-1,642307741]
> > [    0.126899] tick_do_update_jiffies64: last_jiffies_update=3D[50,5230=
00000]
> > [    0.127003] tick_do_update_jiffies64: tick_period=3D[0,1000000]
> > [    0.127097] tick_do_update_jiffies64: now=3D[50,165307741]
> > [    0.127235] run_timer_softirq: jiffies=3Dfffc317b, base->timer_jiffi=
es=3Dfffc317c
> > [    0.127360] no need resched!
> > [    0.154695] tick_do_update_jiffies64: now=3D50193314933 last_jiffies=
_update=3D50523000000
> > [    0.154811] tick_do_update_jiffies64: delta=3D[-1,670314933]
> > [    0.154903] tick_do_update_jiffies64: last_jiffies_update=3D[50,5230=
00000]
> > [    0.155007] tick_do_update_jiffies64: tick_period=3D[0,1000000]
> > [    0.155102] tick_do_update_jiffies64: now=3D[50,193314933]
> > [    0.155240] run_timer_softirq: jiffies=3Dfffc317b, base->timer_jiffi=
es=3Dfffc317c
> > [    0.155365] no need resched!
> > [    0.182700] tick_do_update_jiffies64: now=3D50221322406 last_jiffies=
_update=3D50523000000
> > [    0.182815] tick_do_update_jiffies64: delta=3D[-1,698322406]
> > [    0.182908] tick_do_update_jiffies64: last_jiffies_update=3D[50,5230=
00000]
> > [    0.183013] tick_do_update_jiffies64: tick_period=3D[0,1000000]
> > [    0.183107] tick_do_update_jiffies64: now=3D[50,221322406]
> > [    0.183245] run_timer_softirq: jiffies=3Dfffc317b, base->timer_jiffi=
es=3Dfffc317c
> > [    0.183370] no need resched!
> > [    0.210705] tick_do_update_jiffies64: now=3D50249329404 last_jiffies=
_update=3D50523000000
> > [    0.210820] tick_do_update_jiffies64: delta=3D[-1,726329404]
> > [    0.210913] tick_do_update_jiffies64: last_jiffies_update=3D[50,5230=
00000]
> > [    0.211017] tick_do_update_jiffies64: tick_period=3D[0,1000000]
> > [    0.211111] tick_do_update_jiffies64: now=3D[50,249329404]
> > [    0.211249] run_timer_softirq: jiffies=3Dfffc317b, base->timer_jiffi=
es=3Dfffc317c
> > [    0.211374] no need resched!
> > [    0.462743] tick_do_update_jiffies64: now=3D50501390710 last_jiffies=
_update=3D50523000000
> > ...
> > [    0.462858] tick_do_update_jiffies64: delta=3D[-1,978390710]
> > [    0.462951] tick_do_update_jiffies64: last_jiffies_update=3D[50,5230=
00000]
> > [    0.463055] tick_do_update_jiffies64: tick_period=3D[0,1000000]
> > [    0.463150] tick_do_update_jiffies64: now=3D[50,501390710]
> > [    0.463287] run_timer_softirq: jiffies=3Dfffc317b, base->timer_jiffi=
es=3Dfffc317c
> > [    0.463413] no need resched!
> > [    0.485374] tick_do_update_jiffies64: now=3D50524024023 last_jiffies=
_update=3D50523000000
> > [    0.485488] tick_do_update_jiffies64: delta=3D[0,1024023]
> > [    0.485578] tick_do_update_jiffies64: last_jiffies_update=3D[50,5230=
00000]
> > [    0.485683] tick_do_update_jiffies64: tick_period=3D[0,1000000]
> > [    0.485777] tick_do_update_jiffies64: now=3D[50,524024023]
> > =

> > Then things proceed normally.
> > =

> > =

> > =
